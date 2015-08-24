package objects;

import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.sun.rowset.CachedRowSetImpl;

import hashing.PasswordHash;

/**
 * DAO, using internal variables, and void commands.
 * @author Barrett
 *
 */
public class DataAccessObject {

	//Table Names
    static String CANDB = "cancredentials";
    static String CODB = "cocredentials";
    static String CANDIDATE = "candidate";
    static String COMPANY = "company";
	
	//!@#$local
	//_________________LocalHost________________________________
	//
    private static String URL = "jdbc:mysql://localhost:3306/jdcdb";
    private static String DRIVER = "com.mysql.jdbc.Driver";
    private static String DBUSERNAME = "iamroot";
    private static String DBPASSWORD = "iamroot";
    

	//!@#$webapp
    //_______________OpenShift PMA via 'rhc port-forward'________________
    //Admin
//    private static String DBUSERNAME = "adminSjSmTnT";
//    private static String DBPASSWORD = "Y1TxvCHy--cN";
//    //DB
//    //private static String URL = "mysql://"+DBUSERNAME+":"+DBPASSWORD+"@127.6.67.130:3306/candidatedatabase";
//    private static String URL = "jdbc:mysql://127.0.0.1:3306/candidatedatabase";
//    private static String DRIVER = "com.mysql.jdbc.Driver";
    
    
    
    
    
    
    
    //Varibales
    private Connection con = null;
    private boolean isCompany;
    //private boolean isCompany=false; //!@# I've set default to candidate
    
    
    //Constructors
    public DataAccessObject (){
    	this(DBUSERNAME, DBPASSWORD);
    }
    
    public DataAccessObject (String db_username, String db_password){
    	//Change USERNAME and PASWORD
    	DBUSERNAME=db_username;
    	DBPASSWORD=db_password;
    	
//!@#$local
    	//Establish Connection
    	if(checkForDriver()==true){
    		establishConnection();
    	}
    	
//!@#$webapp
//    	establishConnection();
    	
    }
	
    //Methods

    public boolean checkForDriver(){
    	boolean driver=false;
    	try{
    		Class.forName(DRIVER);
    		//System.out.println("Class.forName("+DRIVER+") was FOUND");
    		driver=true;
    	}catch(ClassNotFoundException x){
    		System.out.println("Got no class... :'(\n");
    		x.printStackTrace();
    	}
    	return driver;
    }
    
    public boolean checkConnection(){
    	boolean isConnected=false;
    	if(con!=null){
    		isConnected=true;
    	}
    	return isConnected;
    }

//!@#$webapp establishConnection
//    public void establishConnection(){
//    	con=null;
//    	try {
//    		InitialContext ic = new InitialContext();
//    	    Context initialContext = (Context) ic.lookup("java:comp/env");
//    	    DataSource datasource = (DataSource) initialContext.lookup("jdbc/MySQLDS");
//    	    con = datasource.getConnection();
//			
//		} catch (SQLException e) {
//			System.err.println("I couldn't open the connection.");
//			e.printStackTrace();
//		} catch (NamingException e) {
//			System.err.println("I couldn't open the connection. A Naming Exception");
//			e.printStackTrace();
//		}
//    	
//    	
//    }    
    
//!@#$local establishConnection
    public void establishConnection(){
    	con=null;
    	try {
			con = DriverManager.getConnection(URL, DBUSERNAME, DBPASSWORD);
		} catch (SQLException e) {
			System.err.println("I couldn't open the connection.");
			e.printStackTrace();
		}
    }
    
    public void closeConnection(){
    	try {
			con.close();
		} catch (SQLException e) {
			System.err.println("I couldn't close the connection.");
			e.printStackTrace();
		}
    	//set con to null after close
    	con=null;
    }
    
    /**
     * Gets the next available Candidate ID (CID) integer.
     * @return Integer, of the next CID. (0 if error)
     */
    public Integer nextAvailableCID(){
    	Integer result=0;
    	try {
			PreparedStatement ps1=con.prepareStatement("SELECT max(cid) FROM "+CANDB);
			ResultSet rs1=ps1.executeQuery();
			rs1.first();
			result=rs1.getInt(1)+1;//added +1
		} catch (SQLException e) {
			e.printStackTrace();
		}
    	return result;
    }
    
    /**
     * Gets the next available Company ID (COID) integer.
     * @return Integer, of the next COID. (0 if error)
     */
    public Integer nextAvailableCOID(){
    	Integer result=0;
    	try {
			PreparedStatement ps1=con.prepareStatement("SELECT max(coid) FROM "+CODB);
			ResultSet rs1=ps1.executeQuery();
			rs1.first();
			result=rs1.getInt(1)+1;//added +1
		} catch (SQLException e) {
			e.printStackTrace();
		}
    	return result;
    }

    //
    //
    //
    //CANDIDATE
    //
    //   
    //
    
    
    /**
     * Checks the CanCredentials table for a given username.
     * @param username
     * @return boolean
     */
    public boolean userInCandidateDB(String username){
    	Boolean result=false;
    	try{
	    	//if Candidate
	    	PreparedStatement stmt1= con.prepareStatement("SELECT * FROM "+CANDB+" WHERE username=?;");
	    	stmt1.setString(1, username);
	    	ResultSet rst1=stmt1.executeQuery();
			if(rst1.first()){
				result=true; 
			}
    	}catch(SQLException x){
    		x.printStackTrace();
    	}
    	return result;
    }
    
    /**
     * Used to check a Candidate's credentials in the CanCredentials database.
     * @param username
     * @param password
     * @return Boolean, representing if the credentials are present in the database
     */
    public boolean validateCandidate(String username, String password){
    	
    	boolean result=false;
    	
    	//if username not in CANDB, return false
    	if(!userInCandidateDB(username)){
    		return false;
    	}
		
		
		//Username at this point has been found in the database, so now to start the crypto on the user's credentials...    	
    	//Fetch User's Salt and Hashed PAssword
    	String salt="";
    	String stringHash="";
    	byte[] byteHash;
    	try{
			PreparedStatement stmt3= con.prepareStatement("SELECT salt, passwordhash  FROM "+CANDB+" WHERE username=?;");
			stmt3.setString(1, username);
			ResultSet rst3= stmt3.executeQuery();
			rst3.first();
			salt=rst3.getString("salt");
			stringHash=rst3.getString("passwordhash"); 
    	}catch(SQLException x){
    		x.printStackTrace();
    	}
    	//Convert stringHash to Byte[] for comparison
    	byteHash=PasswordHash.fromHexPublic(stringHash);
//    	//TEST PRINT
//    	System.out.println("Database\n"+username+"'s Salt: \t\t"+salt+".\n"+username+"'s passwordhash:\t"+stringHash+".");
    	
    	//The User's input password hash function must now be computed
    	//PasswordHash.pbkdf2Public() to compute hash
		byte[] hash = null;
		try {
			hash=PasswordHash.pbkdf2Public(password.toCharArray(), salt.getBytes(), PasswordHash.PBKDF2_ITERATIONS, PasswordHash.HASH_BYTE_SIZE);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (InvalidKeySpecException e) {
			e.printStackTrace();
		} 		
//		//TEST Print
//		System.out.println("DAO\nComputed Hash:\t\t"+PasswordHash.toHexPublic(hash));
//		System.out.println("Arrays compare: "+Arrays.equals(hash, byteHash));
//		System.out.println("PH.slowEq() [result]: "+PasswordHash.slowEqualsPublic(hash, byteHash));
		
		//Finally to compare the computed hash to the one we collected from the db
		result=PasswordHash.slowEqualsPublic(hash, byteHash);
		
    	return result;
    }
    
    
    /**
     * Adds the given Candidate credentials to the CanCredentials table.
     * @param username
     * @param password
     * @param setCID
     * @return Integer, of the new CID of the Candidate. (0 if error)
     */
    public Integer addCredentialsCandidate(String username, String password, String setCID){
    	//NOTE: given the CID as a parameter, the collision check has been removed
    	
    	//Salt
    	byte[] newSalt=PasswordHash.generateSaltPublic();
    	String newSaltString=PasswordHash.toHexPublic(newSalt);
    	
    	//Hash
    	byte[] hash=null;
    	try {
			hash=PasswordHash.pbkdf2Public(password.toCharArray(), newSaltString.getBytes(), PasswordHash.PBKDF2_ITERATIONS, PasswordHash.HASH_BYTE_SIZE); //param 2 ALWAYS: newSaltString.getBytes()
		} catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
			e.printStackTrace();
		}
    	String hashString=PasswordHash.toHexPublic(hash);
    	
    	//TEST PRINT
    	//System.out.println(username+"'s New Values:\n"+"Salt: "+newSaltString+".\nHash: "+hashString+".");
    	
    	//Third, add the new salt/passwordHash to the database
    	Integer up=0;
    	try {
			PreparedStatement ps=con.prepareStatement("INSERT INTO "+CANDB+" (cid, username, salt, passwordhash) VALUES (?, ?, ?, ?)");
			ps.setString(1, setCID);
			ps.setString(2, username);
			ps.setString(3, newSaltString);
			ps.setString(4, hashString);
			up=ps.executeUpdate();	
		} catch (SQLException e) {
			e.printStackTrace();
		}
    	//update check
    	if(up==0){
    		return 0;
    	}   	
    	//TEST PRINT
    	//System.out.println("Credential Instantiation Success: \""+username+"\" was added to the database.");
    	
    	//Return new CID of new credentials
    	Integer newCID=0;
			try {
				PreparedStatement ps1= con.prepareStatement("SELECT cid FROM "+CANDB+" WHERE username=?");		
				ps1.setString(1, username);
				ResultSet rs1=ps1.executeQuery();
				rs1.first();
				newCID=rs1.getInt(1);
			} catch (SQLException e) {
				e.printStackTrace();
			}
    	return newCID;	
    }
    
    
    /**
     * Adds the given Candidate credentials to the CanCredentials table.
     * @param username
     * @param password
     * @return Integer, of the new CID of the Candidate. (0 if error)
     */
    public Integer addCredentialsCandidate(String username, String password){       	
    	//First, check db if credentials already exist.
    	if(userInCandidateDB(username)){
    		return 0;
    	}
   	
    	//Second, now that the username is available, compute the user's new salt and passwordHash
    	
    	//Salt
    	byte[] newSalt=PasswordHash.generateSaltPublic();
    	String newSaltString=PasswordHash.toHexPublic(newSalt);
    	
    	//Hash
    	byte[] hash=null;
    	try {
			hash=PasswordHash.pbkdf2Public(password.toCharArray(), newSaltString.getBytes(), PasswordHash.PBKDF2_ITERATIONS, PasswordHash.HASH_BYTE_SIZE); //param 2 ALWAYS: newSaltString.getBytes()
		} catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
			e.printStackTrace();
		}
    	String hashString=PasswordHash.toHexPublic(hash);
    	
    	//TEST PRINT
    	//System.out.println(username+"'s New Values:\n"+"Salt: "+newSaltString+".\nHash: "+hashString+".");
    	
    	//Third, add the new salt/passwordHash to the database
    	Integer up=0;
    	Integer newCID=0;
    	while(newCID==0){
    		newCID=nextAvailableCID();
    	}
    	try {
			PreparedStatement ps=con.prepareStatement("INSERT INTO "+CANDB+" (cid, username, salt, passwordhash) VALUES (?, ?, ?, ?)");
			ps.setString(1, newCID.toString());
			ps.setString(2, username);
			ps.setString(3, newSaltString);
			ps.setString(4, hashString);
			up=ps.executeUpdate();	
		} catch (SQLException e) {
			e.printStackTrace();
		}	
    	//update check
    	if(up==0){
    		return 0;
    	}
    	//TEST PRINT
    	//System.out.println("Credential Instantiation Success: \""+username+"\" was added to the database.");
    	
    	return newCID;	
    }
    
    /**
     * Gets a Candidate from the Candidate table, based on given CID
     * @param cid
     * @return CanMap, containing the Candidate's information
     */
    public CanMap getCandidate(Integer cid){
    	CanMap c=new CanMap();
    	try {
			PreparedStatement ps=con.prepareStatement("SELECT * FROM "+CANDIDATE+" WHERE cid= ?");
			ps.setInt(1,cid);
			ResultSet rs=ps.executeQuery();
			//extract all elements individually
			rs.first();
			c.put("cid", rs.getInt("cid"));
			c.put("cFirstName",rs.getString("cfirstname"));
			c.put("cLastName", rs.getString("clastname"));
			c.put("dob", rs.getDate("cdateofbirth"));
			c.put("cYear",rs.getInt("cyearofstudy"));
			c.put("gender",rs.getString("gender")); //!@#
			c.put("degree",rs.getString("cdegreeprogram")); //!@#
			c.put("cEmail",rs.getString("cemail"));
			c.put("cResumeLink",rs.getString("cresumelink"));
			c.put("cPhoneNumber",rs.getString("cphonenumber"));
			c.put("cDescription",rs.getString("cdescription"));
			c.put("cJobHistory",rs.getString("cjobhistory"));
			c.put("cDateCreated",rs.getTimestamp("cdatecreated"));
			c.put("cDateLastModified", rs.getTimestamp("cdatelastmodified"));
		} catch (SQLException e) {
			e.printStackTrace();
		}
    	return c;
    }
    
    /**
     * Adds the given Candidate(CanMap) to the Candidate Table
     * @param user
     * @return boolean, stating success of adding the Candidate
     */
    public boolean addCandidate(CanMap user){
    	boolean result=true;
    	//check Candidate
		PreparedStatement stmt1;
		try {
			stmt1 = con.prepareStatement("SELECT * FROM "+CANDIDATE+" WHERE cid=?;");
			stmt1.setString(1, user.get("cid").toString());
			ResultSet rst1=stmt1.executeQuery();
			if(rst1.first()){
				result=false; 
			}
    	
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		if(result){
			//good to go, send through
			Integer up=0;
	    	try {
				PreparedStatement ps=con.prepareStatement(
						"INSERT INTO "+CANDIDATE
						+" (cid, cfirstname, clastname, gender, cdateofbirth, "
						+"cyearofstudy, cdegreeprogram, cjobhistory, cemail, "
						+"cphonenumber, cresumelink, cdescription, cdatecreated, cdatelastmodified)"
						+" VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
				ps.setString(1, user.get("cid").toString());
				ps.setString(2, user.get("cFirstName").toString());
				ps.setString(3, user.get("cLastName").toString());
				ps.setString(4, user.get("gender").toString());
				ps.setString(5, user.get("dob").toString());
				ps.setString(6, user.get("cYear").toString());
				ps.setString(7, user.get("degree").toString());
				ps.setString(8, user.get("cJobHistory").toString());
				ps.setString(9, user.get("cEmail").toString());
				ps.setString(10, user.get("cPhoneNumber").toString());
				ps.setString(11, user.get("cResumeLink").toString());
				ps.setString(12, user.get("cDescription").toString());
				ps.setString(13, user.get("cDateCreated").toString());
				ps.setString(14, user.get("cDateLastModified").toString());
				up=ps.executeUpdate();
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
	    		
	    	//update check
	    	if(up==0){
	    		result=false;
	    	}
		}
		
		return result;
    }//method
    
    /**
     * This method updates a candidate's information in the database, by taking in a CanMap of the new values, and updating them in the DB.
     * @param user
     * @return
     */
    public boolean updateCandidate(CanMap user){
    	boolean result=false;
    	//check CANDIDATE cid
		PreparedStatement stmt1;
		try {
			stmt1 = con.prepareStatement("SELECT * FROM "+CANDIDATE+" WHERE cid=?;");
			stmt1.setString(1, user.get("cid").toString());
			ResultSet rst1=stmt1.executeQuery();
			if(rst1.first()){
				result=true; 
			}
    	
		} catch (SQLException e) {
			System.err.println("LE-ROY JENKINS!!!");
			e.printStackTrace();
		}
		
		if(result){
			//good to go, send update
			Integer up=0;
	    	try {
				PreparedStatement ps=con.prepareStatement(
//						"INSERT INTO "+CANDIDATE
//						+" (cid, cfirstname, clastname, gender, cdateofbirth, "
//						+"cyearofstudy, cdegreeprogram, cjobhistory, cemail, "
//						+"cphonenumber, cresumelink, cdescription, cdatecreated, cdatelastmodified)"
//						+" VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
						
						"UPDATE "+CANDIDATE+" SET "
						+"cfirstname = ? , clastname = ?, gender = ? , cdateofbirth = ? , "
						+"cyearofstudy = ? , cdegreeprogram = ? , cjobhistory = ? , cemail = ? , "
						+"cphonenumber = ? , cresumelink = ? , cdescription = ? "
						+ "WHERE cid = ? ;"
						);
				ps.setString(1, user.get("cFirstName").toString());
				ps.setString(2, user.get("cLastName").toString());
				ps.setString(3, user.get("gender").toString());
				ps.setString(4, user.get("dob").toString());
				ps.setString(5, user.get("cYear").toString());
				ps.setString(6, user.get("degree").toString());
				ps.setString(7, user.get("cJobHistory").toString());
				ps.setString(8, user.get("cEmail").toString());
				ps.setString(9, user.get("cPhoneNumber").toString());
				ps.setString(10, user.get("cResumeLink").toString());
				ps.setString(11, user.get("cDescription").toString());
				//ps.setString(12, user.get("cDateCreated").toString());
				//ps.setString(12, user.get("cDateLastModified").toString());
				ps.setString(12, user.get("cid").toString());
				up=ps.executeUpdate();
				
			} catch (SQLException e) {
				System.err.println("Oh poop...");
				e.printStackTrace();
			}
	    		
	    	//update check
	    	if(up==0){
	    		result=false;
	    	}
		}
		
		return result;
    }//update
    
    //!@#$ need to create an update candidate (and companny) method
    
    //
    //
    //
    // COMPANY
    //
    //
    //
    
    
    /**
     * Checks the CoCredentials table for a given username.
     * @param username
     * @return boolean
     */
    public boolean userInCompanyDB(String username){
    	Boolean result=false;
    	try{
	    	//if Candidate
	    	PreparedStatement stmt1= con.prepareStatement("SELECT * FROM "+CODB+" WHERE username=?;");
	    	stmt1.setString(1, username);
	    	ResultSet rst1=stmt1.executeQuery();
			if(rst1.first()){
				result=true; 
			}
    	}catch(SQLException x){
    		x.printStackTrace();
    	}
    	return result;
    }
    
    
    /**
     * Used to check a Company's credentials in the CoCredentials database.
     * @param username
     * @param password
     * @return Boolean, representing if the credentials are present in the database
     */
    public boolean validateCompany(String username, String password){
    	
    	boolean result=false;
    	
    	//if username not in CODB, return false
    	if(!userInCompanyDB(username)){
    		return false;
    	}
		
		
		//Username at this point has been found in the database, so now to start the crypto on the user's credentials...    	
    	//Fetch User's Salt and Hashed PAssword
    	String salt="";
    	String stringHash="";
    	byte[] byteHash;
    	try{
			PreparedStatement stmt3= con.prepareStatement("SELECT salt, passwordhash  FROM "+CODB+" WHERE username=?;");
			stmt3.setString(1, username);
			ResultSet rst3= stmt3.executeQuery();
			rst3.first();
			salt=rst3.getString("salt");
			stringHash=rst3.getString("passwordhash"); 
    	}catch(SQLException x){
    		x.printStackTrace();
    	}
    	//Convert stringHash to Byte[] for comparison
    	byteHash=PasswordHash.fromHexPublic(stringHash);
//    	//TEST PRINT
//    	System.out.println("Database\n"+username+"'s Salt: \t\t"+salt+".\n"+username+"'s passwordhash:\t"+stringHash+".");
    	
    	//The User's input password hash function must now be computed
    	//PasswordHash.pbkdf2Public() to compute hash
		byte[] hash = null;
		try {
			hash=PasswordHash.pbkdf2Public(password.toCharArray(), salt.getBytes(), PasswordHash.PBKDF2_ITERATIONS, PasswordHash.HASH_BYTE_SIZE);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (InvalidKeySpecException e) {
			e.printStackTrace();
		} 		
//		//TEST Print
//		System.out.println("DAO\nComputed Hash:\t\t"+PasswordHash.toHexPublic(hash));
//		System.out.println("Arrays compare: "+Arrays.equals(hash, byteHash));
//		System.out.println("PH.slowEq() [result]: "+PasswordHash.slowEqualsPublic(hash, byteHash));
		
		//Finally to compare the computed hash to the one we collected from the db
		result=PasswordHash.slowEqualsPublic(hash, byteHash);
		
    	return result;
    }
    
    /**
     * Adds the given Company credentials to the CoCredentials table.
     * @param username
     * @param password
     * @param setCOID
     * @return Integer, of the new Company's COID. (0, if error)
     */
    public Integer addCredentialsCompany(String username, String password, String setCOID){
    	//NOTE: given the COID as a parameter, the collision check has been removed
    	
    	//Salt
    	byte[] newSalt=PasswordHash.generateSaltPublic();
    	String newSaltString=PasswordHash.toHexPublic(newSalt);
    	
    	//Hash
    	byte[] hash=null;
    	try {
			hash=PasswordHash.pbkdf2Public(password.toCharArray(), newSaltString.getBytes(), PasswordHash.PBKDF2_ITERATIONS, PasswordHash.HASH_BYTE_SIZE); //param 2 ALWAYS: newSaltString.getBytes()
		} catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
			e.printStackTrace();
		}
    	String hashString=PasswordHash.toHexPublic(hash);
    	
    	//TEST PRINT
    	//System.out.println(username+"'s New Values:\n"+"Salt: "+newSaltString+".\nHash: "+hashString+".");
    	
    	//Third, add the new salt/passwordHash to the database
    	Integer up=0;
    	try {
			PreparedStatement ps=con.prepareStatement("INSERT INTO "+CODB+" (coid, username, salt, passwordhash) VALUES (?, ?, ?, ?)");
			ps.setString(1, setCOID);
			ps.setString(2, username);
			ps.setString(3, newSaltString);
			ps.setString(4, hashString);
			up=ps.executeUpdate();	
		} catch (SQLException e) {
			e.printStackTrace();
		}
    	//update check
    	if(up==0){
    		return 0;
    	}   	
    	//TEST PRINT
    	//System.out.println("Credential Instantiation Success: \""+username+"\" was added to the database.");
    	
    	//Return new COID of new credentials
    	Integer newCOID=0;
			try {
				PreparedStatement ps1= con.prepareStatement("SELECT coid FROM "+CODB+" WHERE username=?");		
				ps1.setString(1, username);
				ResultSet rs1=ps1.executeQuery();
				rs1.first();
				newCOID=rs1.getInt(1);
			} catch (SQLException e) {
				e.printStackTrace();
			}
    	return newCOID;	
    }
    
    /**
     * Adds the given Company credentials to the CoCredentials table.
     * @param username
     * @param password
     * @return Integer, of the new Company's COID. (0, if error)
     */
    public Integer addCredentialsCompany(String username, String password){       	
    	//First, check db if credentials already exist.
    	if(userInCompanyDB(username)){
    		return 0;
    	}
    	//Second, now that the username is available, compute the user's new salt and passwordHash
    	//Salt
    	byte[] newSalt=PasswordHash.generateSaltPublic();
    	String newSaltString=PasswordHash.toHexPublic(newSalt);
    	
    	//Hash
    	byte[] hash=null;
    	try {
			hash=PasswordHash.pbkdf2Public(password.toCharArray(), newSaltString.getBytes(), PasswordHash.PBKDF2_ITERATIONS, PasswordHash.HASH_BYTE_SIZE); //param 2 ALWAYS: newSaltString.getBytes()
		} catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
			e.printStackTrace();
		}
    	String hashString=PasswordHash.toHexPublic(hash);
    	
    	//TEST PRINT
    	//System.out.println(username+"'s New Values:\n"+"Salt: "+newSaltString+".\nHash: "+hashString+".");
    	
    	//Third, add the new salt/passwordHash to the database
    	Integer up=0;
    	Integer newCOID=0;
    	while(newCOID==0){
    		newCOID=nextAvailableCOID();
    	}
    	try {
			PreparedStatement ps=con.prepareStatement("INSERT INTO "+CODB+" (coid, username, salt, passwordhash) VALUES (?, ?, ?, ?)");
			ps.setString(1, newCOID.toString());
			ps.setString(2, username);
			ps.setString(3, newSaltString);
			ps.setString(4, hashString);
			up=ps.executeUpdate();	
		} catch (SQLException e) {
			e.printStackTrace();
		}	
    	//update check
    	if(up==0){
    		return 0;
    	}
    	//System.out.println("Credential Instantiation Success: \""+username+"\" was added to the database."); //TEST PRINT
    	return newCOID;	
    }
    
    /**
     * Gets a Company from the Company table, given the COID
     * @param coid
     * @return CoMap, containing the Company's information
     */
    public CoMap getCompany(Integer coid){
    	CoMap c=new CoMap();
    	try {
			PreparedStatement ps=con.prepareStatement("SELECT * FROM "+COMPANY+" WHERE coid= ?");
			ps.setInt(1,coid);
			ResultSet rs=ps.executeQuery();
			//extract all elements individually
			rs.first();
			c.put("coid", rs.getInt("coid"));
			c.put("coName",rs.getString("coname"));
			c.put("coYearEstablished",rs.getInt("coyearestablished"));
			c.put("coEmail",rs.getString("coemail"));
			c.put("coUrl",rs.getString("courl"));
			c.put("coContactName", rs.getString("cocontactname"));
			c.put("coAddress", rs.getString("coaddress"));
			c.put("coTel",rs.getString("coTel"));
			c.put("coDescription",rs.getString("codescription"));
			c.put("coSocial",rs.getString("cosocial"));
			c.put("coDateCreated",rs.getTimestamp("codatecreated"));
			c.put("coDateLastModified", rs.getTimestamp("codatelastmodified"));
		} catch (SQLException e) {
			e.printStackTrace();
		}
    	return c;
    }
    
    
    
    public boolean addCompany(CoMap user){
    	boolean result=true;
    	//check Comapny
		PreparedStatement stmt1;
		try {
			stmt1 = con.prepareStatement("SELECT * FROM "+COMPANY+" WHERE coid=?;");
			stmt1.setString(1, user.get("coid").toString());
			ResultSet rst1=stmt1.executeQuery();
			if(rst1.first()){
				result=false; 
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		if(result){
			//good to go, send through
			Integer up=0;
	    	try {
				PreparedStatement ps=con.prepareStatement(
						"INSERT INTO "+COMPANY
						+" (coid, coname, coyearestablished, "
						+"coemail, courl, cocontactname, coaddress, "
						+"cotel, codescription, cosocial, "
						+"codatecreated, codatelastmodified)"
						+" VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
				ps.setString(1, user.get("coid").toString());
				ps.setString(2, user.get("coName").toString());
				ps.setString(3, user.get("coYearEstablished").toString());
				ps.setString(4, user.get("coEmail").toString());
				ps.setString(5, user.get("coUrl").toString());
				ps.setString(6, user.get("coContactName").toString());
				ps.setString(7, user.get("coAddress").toString());
				ps.setString(8, user.get("coTel").toString());
				ps.setString(9, user.get("coDescription").toString());
				ps.setString(10, user.get("coSocial").toString());
				ps.setString(11, user.get("coDateCreated").toString());
				ps.setString(12, user.get("coDateLastModified").toString());
				up=ps.executeUpdate();				
			} catch (SQLException e) {
				e.printStackTrace();
			}		
	    	//update check
	    	if(up==0){
	    		result=false;
	    	}
		}//result
		
		return result;
    }
    
    
   
   // 
   //
   //TABLE
   //
   //
    
    //!@# return type concern
    public Map<String,Object> getUser(String username){
    	boolean isComp;
    	if(userInCandidateDB(username)){
    		isComp=false;
    	}else if(userInCompanyDB(username)){
    		isComp=true;
    	}else{
    		return null;
    	}
    	Integer userID=0;
    	try {
			PreparedStatement ps=con.prepareStatement("SELECT "+(isCompany? "coid" : "cid")+" FROM "+(isCompany? CODB : CANDB)+" WHERE username='"+username+"';");
			ResultSet rs=ps.executeQuery();
			rs.first();
			userID=rs.getInt((isComp? "coid":"cid"));
		} catch (SQLException e) {
			e.printStackTrace();
		}
    	if(userID!=0){
    		if(isComp){
    			return getCompany(userID);
    		}else{
    			return getCandidate(userID);
    		}	
    	}else{
    		return null;
    	}
    }   
    
    
    
    
    
    /**
     * Updates the DataAccessObject.isCompany boolean value, representing if the given username is 
     * a Company (true) or a Candidate (false). This method is called when 
     * DataAccessObject.getIsCompany() method is called
     * @param username
     */
    private void fetchIsCompany(String username){
    	try{
	    	if(userInCandidateDB(username)){
	    		isCompany=false;
	    	}else if(userInCompanyDB(username)){
	    		isCompany=true;
	    	}else{
	    		//user doesn't exist
	    	}				
    	}catch(Exception x){
    		x.printStackTrace();    	   		
    	}	
    }
    
   
    
   
    
    /**
     * @deprecated Doesn't work
     * @param enumName
     * @return
     */
  	@Deprecated
	public String[] getEnumListFromDatabase(String enumName){
  		//sql: SHOW COLUMNS FROM Table LIKE field
  		//choosing to go static
   		String tmp="";
  		try{
  			PreparedStatement stmt1= con.prepareStatement("SHOW COLUMNS FROM "+CANDB+" LIKE ?;");
	    	stmt1.setString(1, enumName); 
	    	ResultSet rst1=stmt1.executeQuery();
	    	ResultSetMetaData rsmd=rst1.getMetaData();
	    	
	    	tmp=rsmd.getColumnTypeName(2);
	    	System.out.println("tmp:"+tmp);
//	    	//TEST PRINT RST1
//	    	if(rst1.first()){
//	    		//get the Type column
//	    		tmp=rst1.getString("Type");
//	    		System.out.println("tmp:"+tmp);
//	    	}else{
//	    		System.out.print("Nuthin..");
//	    		return null;
//	    	}
	    	
  		}catch(SQLException x){
  			x.printStackTrace();
  		}
  		
  		//Remove unwanted elements
  		tmp=tmp.replace("enum","");
  		tmp=tmp.replace("(","");
  		tmp=tmp.replace(")","");
  		
  		//split tokens on ','
  		String[] result=tmp.split(",");
  		
  		//for each, remove apostrophies
//  		for(int i=0;i<result.length;i++){
//  			String fixed=result[i].replace("'","");
//  			result[i]=fixed;
//  		}
  		
  		
  		return result;
  	}
    
    //GETTERS AND SETTERS
    
    
    public boolean getIsCompany(String username) {
    	fetchIsCompany(username);
		return isCompany;
	}

	public void setIsCompany(boolean isCompany) {
		this.isCompany = isCompany;
	}
    
	public Connection getCon() {
		return con;
	}

	public void setCon(Connection con) {
		this.con = con;
	}
    
    public CachedRowSetImpl convertToCRSI(ResultSet r){
    	CachedRowSetImpl crsi = null;
    	try {
			crsi=new CachedRowSetImpl();
			crsi.populate(r);
		} catch (SQLException e) {
			System.err.println("I couldn't convert Resultset to CSRI.");
			e.printStackTrace();
		}
    	return crsi;
    }

	
    
}//class

//TODO fix establish connection and check driver errors for consistency
//(for later) check encapsulation on methods



/*


     * Used to check for a set of credentials in the database.
     * @param username
     * @param password
     * @return Boolean, representing if the credentials are present in the database
     public boolean validateCredentials(String username, String password){
    	
    	boolean result=false;
    	
    	//First, determine if Company or Candidate
     	fetchIsCompany(username); 
     	
    	//If isCompany is either true of false by now, it means that there was a hits in either credentials list
		if(isCompany==true || isCompany==false){
			System.out.println(username+" is a "+(isCompany==true? "Company." : "Candidate."));
		}else{
			//No hits in either list. Username is bad
			System.out.println("The username '"+username+"' was not found in our database.");
			return false;
		}
		
		
		//Second, username at this point has been found in the database, so now to start the crypto on the user's credentials...
    	
    	//Fetch User's Salt and Hashed PAssword
    	String salt="";
    	String stringHash="";
    	byte[] byteHash;
    	try{
			PreparedStatement stmt3= con.prepareStatement("SELECT salt, passwordhash  FROM "+(isCompany? CODB : CANDB)+" WHERE username=?;");
			stmt3.setString(1, username);
			ResultSet rst3= stmt3.executeQuery();
			rst3.first();
			salt=rst3.getString("salt");
			stringHash=rst3.getString("passwordhash"); 
    	}catch(SQLException x){
    		x.printStackTrace();
    	}
    	//Convert stringHash to Byte[] for comparison
    	byteHash=PasswordHash.fromHexPublic(stringHash);
    	
    	
    	//TEST PRINT
    	System.out.println("Database\n"+username+"'s Salt: \t\t"+salt+".\n"+username+"'s passwordhash:\t"+stringHash+".");
    	
    	//The User's input password hash function must now be computed
    	
    	//PasswordHash.pbkdf2Public() to compute hash
		byte[] hash = null;
		try {
			hash=PasswordHash.pbkdf2Public(password.toCharArray(), salt.getBytes(), PasswordHash.PBKDF2_ITERATIONS, PasswordHash.HASH_BYTE_SIZE);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (InvalidKeySpecException e) {
			e.printStackTrace();
		} 
		
		//TEST Print
		System.out.println("DAO\nComputed Hash:\t\t"+PasswordHash.toHexPublic(hash));
		System.out.println("Arrays compare: "+Arrays.equals(hash, byteHash));
		System.out.println("PH.slowEq() [result]: "+PasswordHash.slowEqualsPublic(hash, byteHash));
		
		//Finally to compare the computed hash to the one we collected from the db
		result=PasswordHash.slowEqualsPublic(hash, byteHash);
		
    	return result;
    }
    

///add credentials

	
	public boolean addCredentials(String username, String password, String setCID, boolean isCompany){
    	//NOTE: given the CID as a parameter, the collision check has been removed
    	
    	//Salt
    	byte[] newSalt=PasswordHash.generateSaltPublic();
    	String newSaltString=PasswordHash.toHexPublic(newSalt);
    	
    	//Hash
    	byte[] hash=null;
    	try {
			hash=PasswordHash.pbkdf2Public(password.toCharArray(), newSaltString.getBytes(), PasswordHash.PBKDF2_ITERATIONS, PasswordHash.HASH_BYTE_SIZE); //param 2 ALWAYS: newSaltString.getBytes()
		} catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
			e.printStackTrace();
		}
    	String hashString=PasswordHash.toHexPublic(hash);
    	
    	//TEST PRINT
    	System.out.println(username+"'s New Values:\n"+"Salt: "+newSaltString+".\nHash: "+hashString+".");
    	
    	//Third, add the new salt/passwordHash to the database
    	Integer up=0;
    	boolean result=true;
    	try {
			PreparedStatement ps=con.prepareStatement("INSERT INTO "+(isCompany? CODB : CANDB)+" (cid, username, salt, passwordhash) VALUES (?, ?, ?, ?)");
			ps.setString(1, setCID);
			ps.setString(2, username);
			ps.setString(3, newSaltString);
			ps.setString(4, hashString);
			up=ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
    		
    	//update check
    	if(up==0){
    		result=false;
    	}
    	
    	//TEST PRINT
    	System.out.println("Credential Instantiation Success: \""+username+"\" was added to the database.");
    	
    	return result;	
    }
    
    /**
     * Used to add credentials to the database. Needs a security check later.
     * @param username
     * @param password
     * @return
    
    public boolean addCredentials(String username, String password, boolean isCompany){
    	//!@# later, check if public access modified violates security/encapsulation
       	
    	//First, check db if credentials already exist.
    	
    	boolean result=true;
    	try{
	    	//check Candidate
    		PreparedStatement stmt1= con.prepareStatement("SELECT * FROM "+CANDB+" WHERE username=?;");
	    	stmt1.setString(1, username);
	    	ResultSet rst1=stmt1.executeQuery();
			if(rst1.first()){
				result=false; 
			}
			
			//check Company 
			PreparedStatement stmt2= con.prepareStatement("SELECT * FROM "+CODB+" WHERE username=?;");
	    	stmt2.setString(1, username);
	    	ResultSet rst2=stmt2.executeQuery();
			if(rst2.first()){
				result=false; 
			}
			
			//If result is still true by now, it means that there was no hits in either credentials list
			if(!result){
				//Duplicate Username. Break, and return false.
				System.out.println("Credential Instantiation Failed: \""+username+"\" already exists in the database.");
				return result;
			}else{
			//No hits in either list. Username is available. Proceding with creation.
				System.out.println("\""+username+"\" is available.");
			}
		
    	}catch(SQLException x){
    		x.printStackTrace();    	   		
    	}
    	
    	//Second, now that the username is available, compute the user's new salt and passwordHash
    	
    	//Salt
    	byte[] newSalt=PasswordHash.generateSaltPublic();
    	String newSaltString=PasswordHash.toHexPublic(newSalt);
    	
    	//Hash
    	byte[] hash=null;
    	try {
			hash=PasswordHash.pbkdf2Public(password.toCharArray(), newSaltString.getBytes(), PasswordHash.PBKDF2_ITERATIONS, PasswordHash.HASH_BYTE_SIZE); //param 2 ALWAYS: newSaltString.getBytes()
		} catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
			e.printStackTrace();
		}
    	String hashString=PasswordHash.toHexPublic(hash);
    	
    	//TEST PRINT
    	System.out.println(username+"'s New Values:\n"+"Salt: "+newSaltString+".\nHash: "+hashString+".");
    	
    	//Third, add the new salt/passwordHash to the database
    	Integer up=0;
    	try {
			PreparedStatement ps=con.prepareStatement("INSERT INTO "+(isCompany? CODB : CANDB)+" (username, salt, passwordhash) VALUES (?, ?, ?)");
			ps.setString(1, username);
			ps.setString(2, newSaltString);
			ps.setString(3, hashString);
			up=ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
    		
    	//update check
    	if(up==0){
    		result=false;
    	}
    	
    	//TEST PRINT
    	System.out.println("Credential Instantiation Success: \""+username+"\" was added to the database.");
    	
    	return result;	
    }
	
	
//addUSer


	public boolean addUser(CanMap user){
    	
    	boolean result=true;
    	//check Candidate
		PreparedStatement stmt1;
		try {
			stmt1 = con.prepareStatement("SELECT * FROM "+CANDIDATE+" WHERE cid=?;");
			stmt1.setString(1, user.get("cid").toString());
			ResultSet rst1=stmt1.executeQuery();
			if(rst1.first()){
				result=false; 
			}
    	
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		if(result){
			//good to go, send through/ //!@#note only for candidate
			Integer up=0;
	    	try {
				PreparedStatement ps=con.prepareStatement(
						"INSERT INTO "+(isCompany? COMPANY : CANDIDATE)
						+" (cid, cfirstname, clastname, gender, cdateofbirth, "
						+"cyearofstudy, cdegreeprogram, cjobhistory, cemail, "
						+"cphonenumber, cresumelink, cdescription, cdatecreated, cdatelastmodified)"
						+" VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
				ps.setString(1, user.get("cid").toString());
				ps.setString(2, user.get("cFirstName").toString());
				ps.setString(3, user.get("cLastName").toString());
				ps.setString(4, user.get("gender").toString());
				ps.setString(5, user.get("dob").toString());
				ps.setString(6, user.get("cYear").toString());
				ps.setString(7, user.get("degree").toString());
				ps.setString(8, user.get("cJobHistory").toString());
				ps.setString(9, user.get("cEmail").toString());
				ps.setString(10, user.get("cPhoneNumber").toString());
				ps.setString(11, user.get("cResumeLink").toString());
				ps.setString(12, user.get("cDescription").toString());
				ps.setString(13, user.get("cDateCreated").toString());
				ps.setString(14, user.get("cDateLastModified").toString());
				up=ps.executeUpdate();
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
	    		
	    	//update check
	    	if(up==0){
	    		result=false;
	    	}
		}
		
		return result;
    }//method
	
	
	

*/