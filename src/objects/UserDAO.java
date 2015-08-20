package objects;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

	//Variables
	DataAccessObject dao;
	Connection con=null;
	
	//Statement Constants
	//private String COMPANY_ATTRIBUTE_ORDERBY_RANGE = "SELECT ? FROM company ORDER BY ? LIMIT ? , ? ;";
	
	
	//Constructor
	public UserDAO(){
		//Instantiate dao
		dao=new DataAccessObject();
		//get dao's connection fo ruse in this class
		con=dao.getCon();
	}
	
	
	//METHODS
	
	//CANIDATE
	/**
	 * Used to fetch particular elements of the COMAPNY table. Fix this //!@#
	 * 0 - coid
	 * 1 - coname
	 * 2 - coyearestablished
	 * 3 - coemail
	 * 4 - courl
	 * 5 - cocontact
	 * 6 - coaddress
	 * 7 - cotel
	 * 8 - codescription
	 * 9 - cosocial
	 * @param attributeIndex
	 * @param orderByIndex
	 * @param startOffset
	 * @param totalNumber
	 * @return ArrayList<CoMap>
	 */
	public ArrayList<CoMap> getCompanyDirectory(int[] attributeIndex, int orderByIndex, Integer startOffset, Integer totalNumber){
		
	//Step 1: get attributes from the index numbers in the array
		String attrs="";
		for(int i: attributeIndex){
			switch(i){
			case 0: //coid
				attrs+="coid";
				break;
			case 1:  //coname
				attrs+="coname";
				break;
			case 2: //coyearestablished
				attrs+="coyearestablished";
				break;
			case 3: //coemail
				attrs+="coemail";
				break;
			case 4: //courl
				attrs+="courl";
				break;
			case 5:	//cocontactname
				attrs+="cocontactname";
				break;
			case 6: //coaddress
				attrs+="coaddress";
				break;
			case 7: //cotel
				attrs+="cotel";
				break;
			case 8: //codescription
				attrs+="codescription";
				break;
			case 9: //cosocial
				attrs+="cosocial";
				break;
			default:
				attrs+="coid";
				System.err.println("going to default coid. "+i+" not recognized");
				break;
			}//switch
			attrs+=", ";
		}//for
		//remove final comma
		attrs=attrs.substring(0,attrs.length()-2);
	
	//Step 2: get the ORDER BY attribute, using the same index numbers as above
		String orderBy="";
		switch(orderByIndex){
		case 0: //coid
			orderBy+="coid";
			break;
		case 1:  //coname
			orderBy+="coname";
			break;
		case 2: //coyearestablished
			orderBy+="coyearestablished";
			break;
		case 3: //coemail
			orderBy+="coemail";
			break;
		case 4: //courl
			orderBy+="courl";
			break;
		case 5:	//cocontactname
			orderBy+="cocontactname";
			break;
		case 6: //coaddress
			orderBy+="coaddress";
			break;
		case 7: //cotel
			orderBy+="cotel";
			break;
		case 8: //codescription
			orderBy+="codescription";
			break;
		case 9: //cosocial
			orderBy+="cosocial";
			break;
		default:
			orderBy+="coid";
			System.err.println("going to default order by coid. "+orderByIndex+" not recognized");
			break;
		}//switch
		
	//Step 3: Fetch ResultSet
		ArrayList<CoMap> result=new ArrayList<CoMap>();
		try {
			PreparedStatement ps1=con.prepareStatement("SELECT "+attrs+" FROM company ORDER BY ? LIMIT ? , ? ;");
			
			ps1.setString(1, orderBy);
			ps1.setInt(2, startOffset);
			ps1.setInt(3, totalNumber);
			ResultSet rs1=ps1.executeQuery();
			
			//iterate through each result
			rs1.first();
			do{			
				//Step 4: Pick the attrs out and add them to a CoMap
				CoMap co=new CoMap();
				
				//attrs
				for(int i: attributeIndex){
					switch(i){
					case 0: //coid //!@#
						String ci=rs1.getString("coid");
						co.put("coid", ci);
						break;
					case 1:  //coname
						co.put("coName", rs1.getString("coname"));
						break;
					case 2: //coyearestablished
						co.put("coYearEstablished", rs1.getString("coyearestablished"));
						break;
					case 3: //coemail
						co.put("coEmail", rs1.getString("coemail"));
						break;
					case 4: //courl
						co.put("coUrl", rs1.getString("courl"));
						break;
					case 5:	//cocontactname
						co.put("coContactName", rs1.getString("cocontactname"));
						break;
					case 6: //coaddress
						co.put("coAddress", rs1.getString("coaddress"));
						break;
					case 7: //cotel
						co.put("coTel", rs1.getString("cotel"));
						break;
					case 8: //codescription
						co.put("coDescription", rs1.getString("codescription"));
						break;
					case 9: //cosocial
						co.put("coSocial", rs1.getString("cosocial"));
						break;
					default:
						System.err.println("Shouldn't be here: skipping "+i);
						break;
					}//switch
					
				}//for attr index

				//add co now that all attrs are added
				result.add(co);
			//while there are still more results	
			}while(rs1.next()); 
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		return result;
		
	}//method
		
	
	//CLOSE
	public void close(){
		dao.closeConnection();
	}
	
	
}//class

//
