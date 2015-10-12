package objects;

import java.beans.PropertyVetoException;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.sun.rowset.CachedRowSetImpl;

import hashing.PasswordHash;


//c3p0
import com.mchange.v2.c3p0.*;

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
    static String RESOURCES = "resources";
    static Integer MAX_CONNECTION_ATTEMPTS=3;
	
    //!@#$BOTH
    static Boolean webapp = true;
    
//	//!@#$local
//	//_________________LocalHost________________________________
//	//
//    private static String URL = "jdbc:mysql://localhost:3306/jdcdb";
//    private static String DRIVER = "com.mysql.jdbc.Driver";
//    private static String DBUSERNAME = "iamroot";
//    private static String DBPASSWORD = "iamroot";
    

//	//!@#$webapp
//    //_______________OpenShift PMA ________________
    private static String DBUSERNAME = "adminSjSmTnT"; //!@#Note: This is admin. Change user before launch
    private static String DBPASSWORD = "Y1TxvCHy--cN";
    //private static String DBUSERNAME = "user";
    //private static String DBPASSWORD = "user";
    ////private static String URL = "mysql://"+DBUSERNAME+":"+DBPASSWORD+"@127.6.67.130:3306/candidatedatabase";
    private static String URL = "jdbc:mysql://127.0.0.1:3306/candidatedatabase";
    private static String DRIVER = "com.mysql.jdbc.Driver";
    
    /*
     * INSTRUCTIONS:
     * 
     * Use the following Global Variables in the following use cases.
     * 
     */
    
//    //!@#$ PORT FORWARDING (rhc port-forward -a candidatedatabase). Use the 'local' methods and 'webapp' credentials above

    
    
    //Variables
    private Connection con = null;
    private boolean isCompany;
    
    
    //Default Constructor
    public DataAccessObject (){
    	
//    	//read in Property file
//    	Properties props=new Properties();
//		FileInputStream fis;
//		boolean error=false;
//		try {
//			fis=new FileInputStream("./Properties/DatabaseProperties.properties");
//			props.load(fis);
//			fis.close();
//			//Get the Properties
//			if(webapp){
//				DBUSERNAME=props.getProperty("OPENSHIFT_MYSQL_DBROOT_USERNAME");
//				DBPASSWORD=props.getProperty("OPENSHIFT_MYSQL_DBROOT_PASSWORD");
//				URL=props.getProperty("OPENSHIFT_MYSQL_DBROOT_URL");
//				DRIVER=props.getProperty("LOCAL_DB_DRIVER"); //local driver?
//			}else{
//				DBUSERNAME=props.getProperty("LOCAL_DB_USERNAME");
//				DBPASSWORD=props.getProperty("LOCAL_DB_PASSWORD");
//				URL=props.getProperty("LOCAL_DB_URL");
//				DRIVER=props.getProperty("LOCAL_DB_DRIVER");
//			}
//			props.getProperty("ATTRIBUTE");
//		} catch (FileNotFoundException e) {
//			System.err.println("Database Properties File Not Found");
//			error=true;
//			e.printStackTrace();
//		} catch (IOException e) {
//			System.err.println("Database Properties I/O Error");
//			error=true;
//			e.printStackTrace();
//		}finally{
//			if(error){	
//			}else{
//			}
//		}
//		
//		//Establish Connection
//		establishConnection();
		
		//Param Constructor
		this(DBUSERNAME, DBPASSWORD);
    }
    
    //Parameter Constructor
    public DataAccessObject (String db_username, String db_password){
    	//Change USERNAME and PASWORD
    	DBUSERNAME=db_username;
    	DBPASSWORD=db_password;
    	

    	//Establish Connection
    	if(webapp){
    		establishConnection();
    		//establishConnection2();
    	}else{
	    	if(checkForDriver()==true){
	    		establishConnection();
	    	}
    	}
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

//!@#$V.2 webapp establishConnection (Attempting c3p0 integration)
//    public void establishConnection(){
//    	//DataSource's
//    	DataSource ds=null;
//    	DataSource ds_pooled = null;
//    	
//    	//establish
//    	try {    		
//    		//DataSource Factory
//    		InitialContext ic = new InitialContext();
//    	    Context initialContext = (Context) ic.lookup("java:comp/env");
//    	    ds = (DataSource) initialContext.lookup("jdbc/MySQLDS");
//    	    
//    	       	    
//    	    //create ds_pooled
//    	    ds_pooled=DataSources.pooledDataSource(ds);
//    	    //get connection (with username and password).
//    	    //con=ds_pooled.getConnection(DBUSERNAME, DBPASSWORD); //not supported with basic datasource
//    	    con=ds_pooled.getConnection();
//    	    
//		} catch (SQLException e) {
//			System.err.println("I couldn't open the connection. A SQLException");
//			e.printStackTrace();
//		} catch (NamingException e) {
//			System.err.println("I couldn't open the connection. A Naming Exception");
//			e.printStackTrace();
//		}finally{
//			//clean up datasources with .destroy
////			try {
////				DataSources.destroy(ds);
////				DataSources.destroy(ds_pooled);
////			} catch (SQLException e) {
////				//empty
////			}
//		}
//    }    

    
//!@#$test establishConnection2() (DONT WORRY ABOUT THIS ONE FOR NOW)
    public void establishConnection2(){   	
    	loop:
    	for(int i=0; i<MAX_CONNECTION_ATTEMPTS; i++){
    		con=null;
	    	try {
	    		InitialContext ic = new InitialContext();
	    	    Context initialContext = (Context) ic.lookup("java:comp/env");
	    	    DataSource datasource = (DataSource) initialContext.lookup("jdbc/MySQLDS");
	    	    con = datasource.getConnection();
	    	    if(con!=null){
	    	    	System.out.println("Attempt "+i+": Connection Established.");
	    	    	break loop;
	    	    }
			} catch (Exception e) {
				System.err.println("Attempt "+i+": Exception Failure.");
			}
    	}//for
    }//method
    
//!@#$webapp establishConnection
  public void establishConnection(){
	  establishConnection2();
	  
//    	con=null;
//    	try {
//    		InitialContext ic = new InitialContext();
//    	    Context initialContext = (Context) ic.lookup("java:comp/env");
//    	    DataSource datasource = (DataSource) initialContext.lookup("jdbc/MySQLDS");
//    	    con = datasource.getConnection();
//		} catch (SQLException e) {
//			System.err.println("I couldn't open the connection.");
//			e.printStackTrace();
//		} catch (NamingException e) {
//			System.err.println("I couldn't open the connection. A Naming Exception");
//			e.printStackTrace();
//		}    	
    }    
    
//!@#$local establishConnection
//    public void establishConnection(){
//    	con=null;
//    	try {
//			con = DriverManager.getConnection(URL, DBUSERNAME, DBPASSWORD);
//		} catch (SQLException e) {
//			System.err.println("I couldn't open the connection.");
//			e.printStackTrace();
//		}
//    }

    
    /**
     * Closes the connection.
     */
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
    //CANDIDATE____________________________________________________________________________________________________________________
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
     * 
     * DEV USE ONLY
     * Adds the given Candidate credentials to the CanCredentials table.
     * @param username
     * @param password
     * @param setCID
     * @return Integer, of the new CID of the Candidate. (0 if error)
     */
    public Integer addCredentialsCandidate(String username, String password, String recoveryToken, String setCID){
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
    	//ADDED: Add recovery token
    	boolean r=createAndAddRecoveryString(username, recoveryToken);
    	if(!r){
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
    public Integer addCredentialsCandidate(String username, String password, String recoveryString){       	
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
    	//ADDED: Add recovery token
    	boolean r=createAndAddRecoveryString(username, recoveryString);
    	if(!r){
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
			//DOB
			String dob=rs.getDate("cdateofbirth").toString()+" 00:00:00"; //!@#$ verify if this getDate instead of getTimestamp works
			c.put("dob", dob);//!@#
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
				ps.setString(5, user.get("dob").toString()); //does this work?
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
    
    
    //
    //
    //
    // COMPANY______________________________________________________________________________________________________________________
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
     * DEV USE ONLY
     * Adds the given Company credentials to the CoCredentials table.
     * @param username
     * @param password
     * @param setCOID
     * @return Integer, of the new Company's COID. (0, if error)
     */
    public Integer addCredentialsCompany(String username, String password, String recoveryToken, String setCOID){
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
    	//ADDED: Add recovery token
    	boolean r=createAndAddRecoveryString(username, recoveryToken);
    	if(!r){
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
    public Integer addCredentialsCompany(String username, String password, String recoveryString){       	
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
    	//ADDED: Add recovery token
    	boolean r=createAndAddRecoveryString(username, recoveryString);
    	if(!r){
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
    
    
    /**
     * This method updates a company's information in the database, by taking in a CoMap of the new values, and updating them in the DB.
     * @param CoMap company
     * @return Boolean, indicating success of operation.
     */
    public boolean updateCompany(CoMap co){
    	boolean result=false;
    	//check COMPANY coid
		PreparedStatement stmt1;
		try {
			stmt1 = con.prepareStatement("SELECT * FROM "+COMPANY+" WHERE coid=?;");
			stmt1.setString(1, co.get("coid").toString());
			ResultSet rst1=stmt1.executeQuery();
			if(rst1.first()){
				result=true; 
			}
    	
		} catch (SQLException e) {
			System.err.println("LE-ROY JENKINS!!!");
			e.printStackTrace();
		}
		
		if(result){
			//good to go, send update //!@#$ return
			Integer up=0;
	    	try {
				PreparedStatement ps=con.prepareStatement(
						"UPDATE "+COMPANY+" SET "
						+"coname = ? , coyearestablished = ?, coemail = ? , courl = ? , "
						+"cocontactname = ? , coaddress = ? , cotel = ? , codescription = ? , "
						+"cosocial = ? "
						+ "WHERE coid = ? ;"
						);
				ps.setString(1, co.get("coName").toString());
				ps.setString(2, co.get("coYearEstablished").toString());
				ps.setString(3, co.get("coEmail").toString());
				ps.setString(4, co.get("coUrl").toString());
				ps.setString(5, co.get("coContactName").toString());
				ps.setString(6, co.get("coAddress").toString());
				ps.setString(7, co.get("coTel").toString());
				ps.setString(8, co.get("coDescription").toString());
				ps.setString(9, co.get("coSocial").toString());
				ps.setString(10, co.get("coid").toString());
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
    
    
    //
    //
    //
    //Password Resetting______________________________________________________________________________________
    //
    //
    
    public boolean resetPassword(String username, String newPassword){
    	//Step 1: determine isComp
    	boolean isComp=getIsCompany(username);
    	
    	//Step 2: Hash the password using the user's salt   	
    	//Fetch User's Salt
    	String salt="";
    	try{
			PreparedStatement stmt3= con.prepareStatement("SELECT salt FROM "+(isComp? CODB : CANDB)+" WHERE username=?;");/////
			stmt3.setString(1, username);
			ResultSet rst3= stmt3.executeQuery();
			rst3.first();
			salt=rst3.getString("salt");
    	}catch(SQLException x){
    		x.printStackTrace();
    	}
    	
    	//The user's password hash function must now be computed
    	//PasswordHash.pbkdf2Public() to compute hash
		byte[] passwordHash = null;
		try {
			passwordHash=PasswordHash.pbkdf2Public(newPassword.toCharArray(), salt.getBytes(), PasswordHash.PBKDF2_ITERATIONS, PasswordHash.HASH_BYTE_SIZE);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (InvalidKeySpecException e) {
			e.printStackTrace();
		}
		String stringHashPassword=PasswordHash.toHexPublic(passwordHash);
    	
    	
    	//Step 3: update/add StringHashPassword to db
    	Integer up=0;
    	try {
			PreparedStatement ps=con.prepareStatement("UPDATE "+(isComp? CODB : CANDB)+" SET passwordhash= ? WHERE username=?");
			ps.setString(1, stringHashPassword);
			ps.setString(2, username);
			up=ps.executeUpdate();	
		} catch (SQLException e) {
			e.printStackTrace();
		}
    	    	
//    	//TEST PRINTING TO CONSOLE
//    	String print="createAndAddRecoveryString() Method Variables:\n";
//    	print+="Inputs:\n\tusername:"+username+"\n\t(input)token:"+token; //inputs
//    	print+="\n\nOutputs\n\t(DB)salt:"+salt; //outputs
//    	print+="\nComputed stringHashToken:"+stringHashToken; //computed token hash
//    	//print
//    	System.out.println(print);
    	
    	
    	//update check
    	if(up==0){
    		return false;
    	}
    	return true;
    }
    
    
   //
    //
    //
    //RecoveryString______________________________________________________________________________________________________________
    //
    //
    
    
    /**
     * Used to create/update a user's recoveryString in the database, given a username and the plaintext token. 
     * @param username
     * @param token
     * @return boolean, indicating success of operation.
     */
    public boolean createAndAddRecoveryString(String username, String token){
    	//Step 1: determin isComp
    	boolean isComp=getIsCompany(username);
    	
    	//Step 2: Hash the token using the user's salt   	
    	//Fetch User's Salt
    	String salt="";
    	try{
			PreparedStatement stmt3= con.prepareStatement("SELECT salt FROM "+(isComp? CODB : CANDB)+" WHERE username=?;");/////
			stmt3.setString(1, username);
			ResultSet rst3= stmt3.executeQuery();
			rst3.first();
			salt=rst3.getString("salt");
    	}catch(SQLException x){
    		x.printStackTrace();
    	}
    	
    	//The user's token hash function must now be computed
    	//PasswordHash.pbkdf2Public() to compute hash
		byte[] tokenHash = null;
		try {
			tokenHash=PasswordHash.pbkdf2Public(token.toCharArray(), salt.getBytes(), PasswordHash.PBKDF2_ITERATIONS, PasswordHash.HASH_BYTE_SIZE);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (InvalidKeySpecException e) {
			e.printStackTrace();
		}
		String stringHashToken=PasswordHash.toHexPublic(tokenHash);
    	
    	
    	//Step 3: update/add StringHashToken to db
    	Integer up=0;
    	try {
			PreparedStatement ps=con.prepareStatement("UPDATE "+(isComp? CODB : CANDB)+" SET recoveryString= ? WHERE username=?");
			ps.setString(1, stringHashToken);
			ps.setString(2, username);
			up=ps.executeUpdate();	
		} catch (SQLException e) {
			e.printStackTrace();
		}
    	
    	
//    	//TEST PRINTING TO CONSOLE
//    	String print="createAndAddRecoveryString() Method Variables:\n";
//    	print+="Inputs:\n\tusername:"+username+"\n\t(input)token:"+token; //inputs
//    	print+="\n\nOutputs\n\t(DB)salt:"+salt; //outputs
//    	print+="\nComputed stringHashToken:"+stringHashToken; //computed token hash
//    	//print
//    	System.out.println(print);
    	
    	
    	
    	//update check
    	if(up==0){
    		return false;
    	}
    	return true;
    }
    
    
    public boolean validateRecoveryToken(String username, String token){
    	
    	//Step 1: determine isComp
    	boolean isComp=getIsCompany(username);
    	
    	//Step 2: Collect the user's hashed recoveryString and salt   	
    	
    	//Fetch User's Salt
    	String salt="";
    	String recoveryHash="";
    	@SuppressWarnings("unused")
		byte[] byteRecoveryHash;
    	try{
			PreparedStatement stmt3= con.prepareStatement("SELECT salt, recoveryString FROM "+(isComp? CODB : CANDB)+" WHERE username=?;");/////
			stmt3.setString(1, username);
			ResultSet rst3= stmt3.executeQuery();
			rst3.first();
			salt=rst3.getString("salt");
			recoveryHash=rst3.getString("recoveryString");
    	}catch(SQLException x){
    		x.printStackTrace();
    	}
    	//Convert db recoveryString to Byte[] for comparison
    	byteRecoveryHash=PasswordHash.fromHexPublic(salt);
    	
    	
    	
    	//Step 3: The user's token hash function must now be computed, using the collected salt
    	//PasswordHash.pbkdf2Public() to compute hash
		byte[] tokenHash = null;
		try {
			tokenHash=PasswordHash.pbkdf2Public(token.toCharArray(), salt.getBytes(), PasswordHash.PBKDF2_ITERATIONS, PasswordHash.HASH_BYTE_SIZE);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (InvalidKeySpecException e) {
			e.printStackTrace();
		}
		
    	//Compare slow equals //SEEMS TO BE MISBEHAVING. USING REGULAR EQUALS, AS TEMPORAL VUNERABILITIES CLOUDED WITH HOSTING SERVICE EMMULATION INCONSISTENCY
		//boolean result=PasswordHash.slowEqualsPublic(tokenHash,byteRecoveryHash);
    	boolean result=recoveryHash.equals(PasswordHash.toHexPublic(tokenHash));
		
		
//		//TEST PRINTING TO CONSOLE
//		String print="ValidateRecoveryToken() Method Variables:\n";
//		print+="Inputs:\n\tusername:"+username+"\n\t(input)token:"+token; //inputs
//		print+="\n\nOutputs\n\t(DB)salt:"+salt+"\n\t(DB)recoveryHash:"+recoveryHash; //outputs
//		print+="\nComputed token hashing (PH.toHexPub):"+PasswordHash.toHexPublic(tokenHash); //computed token hash
//		//print
//		System.out.println(print);
		
		//Return result
    	return result;
    }
    
   
   // 
   //
   //TABLE______________________________________________________________________________________________________________________
   //
   //
    
    /**
     * For any given username, return the appropriate mapping (either CanMap or CoMap) for that user. Null if invalid.
     * 
     * This method is used when the 'isCompany' status of the user is not known, because Map<string,Object> handles both mappings. 
     * @param username
     * @return
     */
    public Map<String,Object> getUser(String username){
    	if(userInCandidateDB(username)){
    		isCompany=false;
    	}else if(userInCompanyDB(username)){
    		isCompany=true;
    	}else{
    		return null;
    	}
    	Integer userID=0;
    	try {
			PreparedStatement ps=con.prepareStatement("SELECT "+(isCompany? "coid" : "cid")+" FROM "+(isCompany? CODB : CANDB)+" WHERE username='"+username+"';");
			ResultSet rs=ps.executeQuery();
			rs.first();
			userID=rs.getInt((isCompany? "coid":"cid"));
		} catch (SQLException e) {
			e.printStackTrace();
		}
    	if(userID!=0){
    		if(isCompany){
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
     * Fetches the name of either the candidate of company.
     * @param uid
     * @param isCo
     * @return
     */
    public String fetchNameString(String uid, boolean isCo){
    	String result="";
    	
    	try{
	    	PreparedStatement ps=con.prepareStatement("SELECT "+(isCo? "coname" : "cfirstname")+" FROM "+(isCo?  COMPANY: CANDIDATE)+" WHERE "+(isCo? "coid": "cid")+"= ?;");
	    	ps.setString(1, uid);
			ResultSet rs=ps.executeQuery();
			rs.first();
			result=rs.getString((isCo? "coname":"cfirstname"));
    	}catch(Exception x){
    		//x.printStackTrace();
    		result="User";
    	}
    	
    	return result;
    }
    
    /**
     * Gets the db table sizes, and returns them in a string. "Error" if error has occured.
     * @return String result
     */
    public String queryDBSize(){
    	String result="";
    	try{
    		Statement s=con.createStatement();
    		ResultSet rs=s.executeQuery("SELECT table_name AS 'Tables', round(((data_length + index_length) / 1024), 2) 'Size in KB' FROM information_schema.TABLES WHERE table_schema = 'candidatedatabase' ORDER BY (data_length + index_length) DESC;");
			rs.first();
			while(rs.next()){
				result+=rs.getString("Tables")+"="+rs.getDouble("Size in KB")+" KB |";
			}
    	}catch(Exception x){
    		//x.printStackTrace();
    		result="Error Querying DB Size";
    	}
    	
    	//test print
    	System.out.println("DBSize:"+result);
    	
    	return result;
    }
    
    //
    //
    //IMAGES_________________________________________________________________________________________
    //
    //
    
    
    
    /**
     * Returns a boolean indicating the presence of a photo attached to the given uid's profile.
     * @param uid
     * @return
     */
    public boolean checkForProfileImage(Integer uid){
    	//determine isCompany of uid (Candidate.cid>=1000000)
    	boolean isComp=(uid>999999? false:true);
    	//query for uid and profile image
    	boolean result=false;
    	int count=0;
    	if(isComp){
	    	try {
	    		PreparedStatement ps=con.prepareStatement("SELECT count(coid) AS count FROM "+COMPANY+" WHERE cophoto IS NOT NULL AND coid = ?");
	    		ps.setInt(1, uid);
	    		ResultSet rs=ps.executeQuery();
	    		rs.first();
	    		count=rs.getInt("count");
	    	} catch (SQLException e) {
	    		e.printStackTrace();
	    	}
    	}else{
    		try {
	    		PreparedStatement ps=con.prepareStatement("SELECT count(cid) AS count FROM "+CANDIDATE+" WHERE cphoto IS NOT NULL AND cid = ?");
	    		ps.setInt(1, uid);
	    		ResultSet rs=ps.executeQuery();
	    		rs.first();
	    		count=rs.getInt("count");
	    	} catch (SQLException e) {
	    		e.printStackTrace();
	    	}
    	}
    	//if 1 found, result true.
    	if(count==1){
    		result=true;
    	}
    	//System.out.println("hasImage:"+result);//TEST
    	return result;
    }
    
    /**
     * Returns the byte[] of the image stored in the table pertaining to the given user id.
     * @param uid
     * @return
     */
    public byte[] fetchProfileImageBytes(Integer uid){
    	byte[] imageBytes=null;
    	//determine isCompany of uid (Candidate.cid>=1000000)
    	boolean isComp=(uid>999999? false:true);    	
    	//contact db for byte[]
    	if(isComp){
	    	try {
	    		PreparedStatement ps=con.prepareStatement("SELECT cophoto FROM "+DataAccessObject.COMPANY+" WHERE coid = ?");
	    		ps.setInt(1, uid);
	    		ResultSet rs=ps.executeQuery();
	    		rs.first();
	    		imageBytes=rs.getBytes("cophoto");
	    	} catch (SQLException e) {
	    		e.printStackTrace();
	    	}
    	}else{
    		try {
	    		PreparedStatement ps=con.prepareStatement("SELECT cphoto FROM "+DataAccessObject.CANDIDATE+" WHERE cid = ?");
	    		ps.setInt(1, uid);
	    		ResultSet rs=ps.executeQuery();
	    		rs.first();
	    		imageBytes=rs.getBytes("cphoto");
	    	} catch (SQLException e) {
	    		e.printStackTrace();
	    	}
    	}
    	return imageBytes;
    }
    
    
    public Integer uploadProfileBytes(byte[] picture){
    	
    	
    	
    	
    	return 0;
    }
    
    /**
     * Collect image resources from the site, given the resource id.
     * @param rid
     * @return
     */
    public byte[] fetchResourceImageBytes(Integer rid){
    	byte[] imageBytes=null;  	
	    try {
	    	PreparedStatement ps=con.prepareStatement("SELECT rphoto FROM "+DataAccessObject.RESOURCES+" WHERE rid = ?");
	    	ps.setInt(1, rid);
	    	ResultSet rs=ps.executeQuery();
	    	rs.first();
	    	imageBytes=rs.getBytes("rphoto");
	    } catch (SQLException e) {
	    	e.printStackTrace();
	    }
    	return imageBytes;
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
    
	@Deprecated
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
	

	
	RHC COMMANDS:
	rhc app show candidatedatabase  --gears quota
	rhc app-tidy candidatedatabase
	

*/