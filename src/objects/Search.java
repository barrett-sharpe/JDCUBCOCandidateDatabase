package objects;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLWarning;
import java.util.ArrayList;
import java.util.HashSet;

import com.sun.org.apache.xerces.internal.impl.dv.dtd.NMTOKENDatatypeValidator;
import com.sun.rowset.CachedRowSetImpl;

public class Search {

	//Variables
	DataAccessObject dao;
	Connection con;
	Character[] unacceptable=new Character[]{'-','!','@','#','$','%','^','&','*','(',')','_','+','=','{','}',':',';','\\','"','?','<','>',',','.','|'};
	//From Candidate Options
	String queryString="";
	String queryNum="";
	String area="";
	String yearInt="";
	String yearLogic="";
	//From Result Options
	String orderBy="";
	String orderByDirection="";
	Integer numResults=null;
	
	//!@#$Thnigs for later
	/*
	 * Add in the ability to search on only 1 parameter (currently, need two in order to get the SQL to form properly
	 * Sanatizing queryNum of symbols +()- 
	 * fix all error conditions so they return null or something.
	 * 
	 */
	
	
	
	
	//Constructor
	public Search(String queryString, String queryNum, String area, String yearInt, String yearLogic, String orderBy, String orderByDirection, Integer numResults){
		this.queryString=queryString;
		this.queryNum=queryNum;
		this.area=area;
		this.yearInt=yearInt;
		this.yearLogic=yearLogic;
		this.orderBy=orderBy;
		this.orderByDirection=orderByDirection;
		this.numResults=numResults;
		
		//instantiate dao and con
		dao=new DataAccessObject();
		con=dao.getCon();
	}

	//helper methods
	
	public String showAll(){
		String result="ALL CURRENT SEARCH VARIABLES:\n";
		result+="queryString:"+queryString;
		result+="\nqueryNum:"+queryNum;
		result+="\narea:"+area;
		result+="\nyearInt:"+yearInt;
		result+="\nyearLogic:"+yearLogic;
		result+="\norderBy:"+orderBy;
		result+="\norderByDirection:"+orderByDirection;
		result+="\nnumResults:"+numResults;
		//print
		System.out.println(result);
		//and return
		return result;
	}
	
	public boolean validateInput(){
		boolean result=true;
		
		//Sanitize all variables
		//queryString
//		for(Character c: unacceptable){
//			if(queryString.contains(c.toString())){		// "-!@#$%^&*()_{},':+=;\\\"?<>.|"
//				queryString.replace(c.toString(),"");
//			}
//		}
		
		//check if valid
		
		//remember to check the resulst set options (like orderby)
		
		
		
		return result;
	}

	/**
	 *!@#Fix this descriptionReturns the counted integer, given the selected attribute index, and the value of that attribute
	 * 1) cid
	 * 2) cfirstname
	 * 3) clastname
	 * 4) gender
	 * 5) cdateofbirth
	 * 6) cyearofstudy
	 * 7) cdegreeprogram
	 * 8) cjobhistory
	 * 9) cemail
	 * 10) cphonenumber
	 * 11) cdescription
	 * 12) cphoto
	 * 
	 * 
	 */
	public Integer countAttribute(Integer[] indexes, String[] values){
		//column names
		String[] attr=new String[indexes.length];
		
		//for each index given
		for(int i=0;i<attr.length;i++){
			//Get the column names using the indexes
			switch(indexes[i]){
			case 1:
				attr[i]="cid";
				break;
			case 2:
				attr[i]="cfirstname";
				break;
			case 3:
				attr[i]="clastname";
				break;
			case 4:
				attr[i]="gender";
				break;
			case 5:
				attr[i]="cdateofbirth";
				break;
			case 6:
				attr[i]="cyearofstudy";
				break;
			case 7:
				attr[i]="cdegreeprogram";
				break;
			case 8:
				attr[i]="cjobhistory";
				break;
			case 9:
				attr[i]="cemail";
				break;
			case 10:
				attr[i]="cphonenumber";
				break;
			case 11:
				attr[i]="cdescription";
				break;
			case 12:
				attr[i]="cphoto";
				break;
	//		case 13:
	//			attr[i]="";
	//			break;
			default:
				System.out.println("Shouldn't be here.");
				return null;
			}//switch
		}//for
		
		//Count the number of table records matching the listed values for the listed indexes
		
		//Prepare the SQL
		String sql="SELECT COUNT(*) AS num FROM "+DataAccessObject.CANDIDATE+" WHERE";
		//for each given index
		for(int j=0;j<attr.length;j++){
			sql+=" "+attr[j]+"='"+values[j]+"'";
			
			//and if the j'th index is NOT the last one, add AND
			if(!(j==attr.length-1)){
				sql+=" AND";
			}
		}
		sql+=";";
		
		//TEST
		//System.out.println("The SQL Statement:\n"+sql+"\n");
		
		//Execute
		Integer num = null;
		try {
			PreparedStatement ps1=con.prepareStatement(sql);
			ResultSet rs1=ps1.executeQuery();
			rs1.first();
			num=rs1.getInt("num");
			
		}catch(SQLException x){
			x.printStackTrace();			
		}	
		
		//TEST print
		//System.out.println("num: "+num);
		
		return num;
	}
	
	
	/**
	 * Fetches results of this Search object
	 */
	public ArrayList<CanMap> getResults(Integer startOffset){
		
		String sql="";
		
		//STEP 1: PARSE AND VALIDATE VARIABLES _______________________________________________________________________________
		
		//1.1 Parse queryString for first AND/OR last name. Only first two words taken at the moment.
		String[] names;
		names=queryString.split(" ");
		
		//1.2 yearInt validate
		boolean valid=validateInput();
		
		
		
		//STEP 2: FIGURE OUT WHAT QUERIES TO BE DONE, BY ESTABLISHING WHAT FIELDS ARE EMPTY.  __________________________________
		
		boolean hasQueryString=true; //qs 	has[0]
		boolean hasQueryNum=true;	//qn 	has[1]
		boolean hasYearInt=true;	//yi 	has[2]
		boolean hasArea=true;		//ha 	has[3]
		Boolean[] has=new Boolean[4]; 
		Integer qCount=4;
		
		//If The Given Inputs Were Valid
		if(valid){		
			System.out.println("Inputs Valid"); //TEST
			
			if(queryString==null||queryString.isEmpty()||queryString.length()==0||queryString.equalsIgnoreCase("")){
				//nothing was input to queryString, so nothing in names
				hasQueryString=false;
				qCount--;
			}
			if(area==null||area=="null"||area.isEmpty()||area.length()==0||area.equalsIgnoreCase("")){
				//no area was input, OR, "Any Area" (with a value of "null", the default option) was input.
				//Either way, it means we do not have to specify a particular area.
				hasArea=false;
				qCount--;
			}
			if(queryNum==null||queryNum.isEmpty()||queryNum.length()==0||queryNum.equalsIgnoreCase("")){
				//nothing entered for queryNum, so no specific cid or cphonenumber
				hasQueryNum=false;
				qCount--;
			}
			if(yearInt==null||yearInt.isEmpty()||yearInt.length()==0||yearInt.equalsIgnoreCase("")){
				//nothing entered for graduating year
				hasYearInt=false;
				qCount--;
			}		
		}else{
			//invalid input, throw error !@#
			System.out.println("Error invalid input");
			return null;
		}
		
		//Populate 'has' array with booleans
		has[0]=hasQueryString;
		has[1]=hasQueryNum;
		has[2]=hasYearInt;
		has[3]=hasArea;
		
		//Only Need Attribute 'cid' For Inner Join Selects
		String attrs="cid";
		
		
		
		//STEP 3: DETERMINE AND COMPILE QUERIES  _______________________________________________________________________________
		
		System.out.println("Determining Query:\n"+qCount+ " attributes used."); //TEST
		
		//Based On the Number Of Fields Filled In By The User, The Formation Of The SQL Query Is Different. Observe the following 2 cases:
		//CASE 1: (1 FIELD). A simple query like: "SELECT cid FROM candidate WHERE cfirstname='devon' UNION DISTINCT SELECT cid FROM candidate WHERE clastname='devon'" may be used.
		//CASE 2: (2+ FIELDs). A JOIN is need to assure that rows in the final output meet ALL of the conditions of the query. This involves using aliases to do joins, and the variable nature of the input make this complicated. Example:
		/* 
		SELECT a.cid AS results FROM
		(
				SELECT cid FROM candidate WHERE cfirstname='devon'
				UNION DISTINCT
				SELECT cid FROM candidate WHERE clastname='devon'
		) AS a
		INNER JOIN
		(
				SELECT cid FROM candidate WHERE cphonenumber='254956375'
		) AS b
		ON a.cid = b.cid;
		*/
		//Therfore, a single if condition will span the two sql creation types
		
		if(qCount>1){		
		//CASE 2: (2+ FIELDS) Two or more fields were enterd by the user.
			
			
			//3.0: Overall SELECT cid
			sql+="SELECT ";
			//Select the temporary table name to alias the cid.
			done:
			for(int i=0;i<has.length;i++){
				if(has[i]==true){
					switch(i){
					case 0:
						sql+="queryString.cid";
						break done;
					case 1:
						sql+="queryNum.cid";
						break done;
					case 2:
						sql+="yearInt.cid";
						break done;
					case 3:
						sql+="area.cid";
						break done;
					default:
						break done;
					}
				}
			}
			sql+=" FROM ";
			
			
			//3.1 queryString [AS queryString]
			if(hasQueryString){
				System.out.println("queryString found"); //TEST
				//a string was entered into the querystring box. Now we attempt to determine what is meant by the user, based on the following list of cases:
				
				if(names.length==1){
				//CASE 1: a signle name was entered	
					//this could be either a first or last name. Check the count for both
					String[] value=new String[]{names[0]};
					
					Integer first=countAttribute(new Integer[]{2}, value); //cfirstname 2
					Integer last=countAttribute(new Integer[]{3}, value); //clastname 3
					
					//If the counts for either of them are 0, we know that they were probably looking for the other one
					//(else they searched for a non-existant record)
					if(first==0&&last==0){
						//No result for for names[0] as a first or last name
						System.out.println("No record for "+names[0]+" as either a first or last name.");
						
					}else if(first==0&&last!=0){
						//A result for last name only
						System.out.println("Last name of "+names[0]+" found.");
						//statement
						sql+="(SELECT "+attrs+" FROM candidate WHERE clastname='"+names[0]+"')";
					}else if(first!=0&&last==0){
						//A result for first name only
						System.out.println("First name of "+names[0]+" found.");
						//statement
						sql+="(SELECT "+attrs+" FROM candidate WHERE cfirstname='"+names[0]+"')";
					}else if(first!=0&&last!=0){
						//Results for BOTH first and last name
						System.out.println("First name AND Last name of "+names[0]+" found.");
						//statement
						sql+="(SELECT "+attrs+" FROM candidate WHERE cfirstname='"+names[0]+"'";
						sql+=" UNION DISTINCT ";
						sql+="SELECT "+attrs+" FROM candidate WHERE clastname='"+names[0]+"')";
					}else{
						//error
						System.out.println("Error. First="+first+",Last="+last);
					}
					
				
				
				
				}else if(names.length>=2){
				//CASE 2: two names were entered, most likely a first and last (in any order)	
					
					//this could be either a 'last/first' OR a 'first/last' situation. We count.
					String[] values=new String[]{names[0],names[1]};
					
					Integer firstLast=countAttribute(new Integer[]{2, 3},values); //2,3: first/last
					Integer lastFirst=countAttribute(new Integer[]{3, 2},values); //3,2: last/first
					
					//If the counts for either of them are 0, we know that they were probably looking for the other one
					//(else they searched for a non-existant record)
					if(firstLast==0&&lastFirst==0){
						//No result for for names[0]names[1] as a first or last name combination
						System.out.println("No record for "+names[0]+" "+names[1]+" as any first/last name combination.");
						
					}else if(firstLast==0&&lastFirst!=0){
						//A result for lastFirst name only
						System.out.println("Last First of "+names[0]+" "+names[1]+" found.");
						//statement
						sql+="(SELECT "+attrs+" FROM candidate WHERE clastname='"+names[0]+"' AND cfirstname='"+names[1]+"')";
					}else if(firstLast!=0&&lastFirst==0){
						//A result for firstLast name only
						System.out.println("First Last of "+names[0]+" "+names[1]+" found.");
						//statement
						sql+="(SELECT "+attrs+" FROM candidate WHERE cfirstname='"+names[0]+"' AND clastname='"+names[1]+"')";
					}else if(firstLast!=0&&lastFirst!=0){
						//Results for BOTH firstLast AND lastFirst names
						System.out.println("BOTH FirstLast and Last First for"+names[0]+" "+names[1]+" found.");
						//statement
						sql+="(SELECT "+attrs+" FROM candidate WHERE cfirstname='"+names[0]+"' AND clastname='"+names[1]+"'";
						sql+=" UNION DISTINCT ";
						sql+="SELECT "+attrs+" FROM candidate WHERE clastname='"+names[0]+"' AND cfirstname='"+names[1]+"')";
					}else{
						//error
						System.out.println("Error. FirstLast="+firstLast+",LastFirst="+lastFirst);
					}
				
				}//
				
				
				//queryString SQL alias
				sql+=" AS queryString";
					
				
			}//hasQueryString
			
			//3.2 hasQueryNum
			if(hasQueryNum){
				System.out.println("queryNum found");
				//a number was entered into the field. It could be either a phone number or a cid. We count 
				
				//check if hasQueryString, in order to determine adding INNER JOIN before this set of query
				if(hasQueryString){
					sql+=" INNER JOIN ";
				}
				
			
				//count
				Integer phone=countAttribute(new Integer[]{10}, new String[]{queryNum}); //10 cphonenumber
				Integer cid=countAttribute(new Integer[]{1}, new String[]{queryNum}); //1 cphonenumber
				
				//If the counts for either of them are 0, we know that they were probably looking for the other one
				//(else they searched for a non-existant record)
				if(phone==0&&cid==0){
					//No result for for queryNum as either phone number of cid
					System.out.println("No record for "+queryNum+" as cid or cphonenumber.");
					
				}else if(phone==0&&cid!=0){
					//A result for cid only
					System.out.println("cid of "+queryNum+" found.");
					//statement
					sql+="(SELECT "+attrs+" FROM candidate WHERE cid='"+queryNum+"')";
				}else if(phone!=0&&cid==0){
					//A result for phone only
					System.out.println("cphonenumber of "+queryNum+" found.");
					//statement
					sql+="(SELECT "+attrs+" FROM candidate WHERE cphonenumber='"+queryNum+"')";
				}else if(phone!=0&&cid!=0){
					//Results for BOTH phone AND cid names //!@#remove case? can't/shouldn't happen
					System.out.println("BOTH phone and cid for"+queryNum+" found. Hmmm...");
					//statement
					sql+="(SELECT "+attrs+" FROM candidate WHERE cid='"+queryNum+"'";
					sql+=" UNION DISTINCT ";
					sql+="SELECT "+attrs+" FROM candidate WHERE cphonenumber='"+queryNum+"')";
				}else{
					//error
					System.out.println("Error. phone="+phone+",cid="+cid);
				}
				
				//queryNum SQL alias
				sql+=" AS queryNum";
				
			}//queryNum
			
			//3.3 hasYearInt
			if(hasYearInt){
				System.out.println("yearInt found");
				//a graduating year has been specified
				
				//check if hasQueryString OR hasQueryNum, in order to determine adding INNER JOIN before this set of query
				if(hasQueryString || hasQueryNum){
					sql+=" INNER JOIN ";
				}
				
				
				//confirm yearLogic
				if(yearLogic.equalsIgnoreCase("lessThan")){
					System.out.println("< "+yearInt);
					//statement
					sql+="(SELECT "+attrs+" FROM "+DataAccessObject.CANDIDATE+" WHERE cyearofstudy < "+yearInt+")";
				}else if(yearLogic.equalsIgnoreCase("equal")){
					System.out.println("== "+yearInt);
					//statement
					sql+="(SELECT "+attrs+" FROM "+DataAccessObject.CANDIDATE+" WHERE cyearofstudy = "+yearInt+")";
				}else if(yearLogic.equalsIgnoreCase("greaterThan")){
					System.out.println("> "+yearInt);
					//statement
					sql+="(SELECT "+attrs+" FROM "+DataAccessObject.CANDIDATE+" WHERE cyearofstudy > "+yearInt+")";
				}else{
					//error
					System.out.println("Error in direction");
				}
			
				//yearInt SQL alias
				sql+=" AS yearInt";
				
			}//hasYearInt
			
			//3.4 hasArea
			if(hasArea){
				System.out.println("area found");
				//an area has been found
				System.out.println(""+area);
				
				//check if hasQueryString OR hasQueryNum OR hasYearInt, in order to determine adding INNER JOIN before this set of query
				if(hasQueryString || hasQueryNum || hasYearInt){
					sql+=" INNER JOIN ";
				}
				
				//statement
				sql+="(SELECT "+attrs+" FROM candidate WHERE cdegreeprogram='"+area+"')";
			
				
				//area SQL alias
				sql+=" AS area";
				
			}//hasArea
			
			
			//3.5 finish up overall SELECT cid
			sql+=" ON";
				for(int i=0;i<has.length;i++){
					if(has[i]==true){
						switch(i){
						case 0:
							sql+=" queryString.cid =";
							break;
						case 1:
							sql+=" queryNum.cid =";
							break;
						case 2:
							sql+=" yearInt.cid =";
							break;
						case 3:
							sql+=" area.cid =";
							break;
						default:
							break;
						}
					}
				}
				//remove final '=' sign
				sql=sql.substring(0, sql.length()-2);
		
		}else{
			// Case 1: (1 Field) Only a single field was entered by the user.
			
			//!@#$ continue to fix below for single query, as it was copied from above more complex two+ query level		
			
			//3.1 queryString
			if(hasQueryString){
				System.out.println("queryString found"); //TEST
				//a string was entered into the querystring box. Now we attempt to determine what is meant by the user, based on the following list of cases:
				
				if(names.length==1){
				//CASE 1: a signle name was entered	
					//this could be either a first or last name. Check the count for both
					String[] value=new String[]{names[0]};
					
					Integer first=countAttribute(new Integer[]{2}, value); //cfirstname 2
					Integer last=countAttribute(new Integer[]{3}, value); //clastname 3
					
					//If the counts for either of them are 0, we know that they were probably looking for the other one
					//(else they searched for a non-existant record)
					if(first==0&&last==0){
						//No result for for names[0] as a first or last name
						System.out.println("No record for "+names[0]+" as either a first or last name.");
						
					}else if(first==0&&last!=0){
						//A result for last name only
						System.out.println("Last name of "+names[0]+" found.");
						//statement
						sql+="(SELECT "+attrs+" FROM candidate WHERE clastname='"+names[0]+"')";
					}else if(first!=0&&last==0){
						//A result for first name only
						System.out.println("First name of "+names[0]+" found.");
						//statement
						sql+="(SELECT "+attrs+" FROM candidate WHERE cfirstname='"+names[0]+"')";
					}else if(first!=0&&last!=0){
						//Results for BOTH first and last name
						System.out.println("First name AND Last name of "+names[0]+" found.");
						//statement
						sql+="(SELECT "+attrs+" FROM candidate WHERE cfirstname='"+names[0]+"')";
						sql+=" UNION DISTINCT ";
						sql+="(SELECT "+attrs+" FROM candidate WHERE clastname='"+names[0]+"')";
					}else{
						//error
						System.out.println("Error. First="+first+",Last="+last);
					}
					
				
				
				
				}else if(names.length>=2){
				//CASE 2: two names were entered, most likely a first and last (in any order)	
					
					//this could be either a 'last/first' OR a 'first/last' situation. We count.
					String[] values=new String[]{names[0],names[1]};
					
					Integer firstLast=countAttribute(new Integer[]{2, 3},values); //2,3: first/last
					Integer lastFirst=countAttribute(new Integer[]{3, 2},values); //3,2: last/first
					
					//If the counts for either of them are 0, we know that they were probably looking for the other one
					//(else they searched for a non-existant record)
					if(firstLast==0&&lastFirst==0){
						//No result for for names[0]names[1] as a first or last name combination
						System.out.println("No record for "+names[0]+" "+names[1]+" as any first/last name combination.");
						
					}else if(firstLast==0&&lastFirst!=0){
						//A result for lastFirst name only
						System.out.println("Last First of "+names[0]+" "+names[1]+" found.");
						//statement
						sql+="(SELECT "+attrs+" FROM candidate WHERE clastname='"+names[0]+"' AND cfirstname='"+names[1]+"')";
					}else if(firstLast!=0&&lastFirst==0){
						//A result for firstLast name only
						System.out.println("First Last of "+names[0]+" "+names[1]+" found.");
						//statement
						sql+="(SELECT "+attrs+" FROM candidate WHERE cfirstname='"+names[0]+"' AND clastname='"+names[1]+"')";
					}else if(firstLast!=0&&lastFirst!=0){
						//Results for BOTH firstLast AND lastFirst names
						System.out.println("BOTH FirstLast and Last First for"+names[0]+" "+names[1]+" found.");
						//statement
						sql+="(SELECT "+attrs+" FROM candidate WHERE cfirstname='"+names[0]+"' AND clastname='"+names[1]+"')";
						sql+=" UNION DISTINCT ";
						sql+="(SELECT "+attrs+" FROM candidate WHERE clastname='"+names[0]+"' AND cfirstname='"+names[1]+"')";
					}else{
						//error
						System.out.println("Error. FirstLast="+firstLast+",LastFirst="+lastFirst);
					}
				
				}//

				
			}//hasQueryString
			
			//3.2 hasQueryNum
			if(hasQueryNum){
				System.out.println("queryNum found");
				//a number was entered into the field. It could be either a phone number or a cid. We count 
						
				//count
				Integer phone=countAttribute(new Integer[]{10}, new String[]{queryNum}); //10 cphonenumber
				Integer cid=countAttribute(new Integer[]{1}, new String[]{queryNum}); //1 cphonenumber
				
				//If the counts for either of them are 0, we know that they were probably looking for the other one
				//(else they searched for a non-existant record)
				if(phone==0&&cid==0){
					//No result for for queryNum as either phone number of cid
					System.out.println("No record for "+queryNum+" as cid or cphonenumber.");
					
				}else if(phone==0&&cid!=0){
					//A result for cid only
					System.out.println("cid of "+queryNum+" found.");
					//statement
					sql+="(SELECT "+attrs+" FROM candidate WHERE cid='"+queryNum+"')";
				}else if(phone!=0&&cid==0){
					//A result for phone only
					System.out.println("cphonenumber of "+queryNum+" found.");
					//statement
					sql+="(SELECT "+attrs+" FROM candidate WHERE cphonenumber='"+queryNum+"')";
				}else if(phone!=0&&cid!=0){
					//Results for BOTH phone AND cid names //!@#remove case? can't/shouldn't happen
					System.out.println("BOTH phone and cid for"+queryNum+" found. Hmmm...");
					//statement
					sql+="(SELECT "+attrs+" FROM candidate WHERE cid='"+queryNum+"')";
					sql+=" UNION DISTINCT ";
					sql+="(SELECT "+attrs+" FROM candidate WHERE cphonenumber='"+queryNum+"')";
				}else{
					//error
					System.out.println("Error. phone="+phone+",cid="+cid);
				}
				
			}//queryNum
			
			//3.3 hasYearInt
			if(hasYearInt){
				System.out.println("yearInt found");
				//a graduating year has been specified
				
				//confirm yearLogic
				if(yearLogic.equalsIgnoreCase("lessThan")){
					System.out.println("< "+yearInt);
					//statement
					sql+="SELECT "+attrs+" FROM "+DataAccessObject.CANDIDATE+" WHERE cyearofstudy < "+yearInt;
				}else if(yearLogic.equalsIgnoreCase("equal")){
					System.out.println("== "+yearInt);
					//statement
					sql+="SELECT "+attrs+" FROM "+DataAccessObject.CANDIDATE+" WHERE cyearofstudy = "+yearInt;
				}else if(yearLogic.equalsIgnoreCase("greaterThan")){
					System.out.println("> "+yearInt);
					//statement
					sql+="SELECT "+attrs+" FROM "+DataAccessObject.CANDIDATE+" WHERE cyearofstudy > "+yearInt;
				}else{
					//error
					System.out.println("Error in direction");
				}
				
			}//hasYearInt
			
			//3.4 hasArea
			if(hasArea){
				System.out.println("area found");
				//an area has been found
				System.out.println(""+area);
			
				//statement
				sql+="(SELECT "+attrs+" FROM candidate WHERE cdegreeprogram='"+area+"')";
			
			}//hasArea
			
			
		}//1 or More Fields

		
		
		//STEP 4: Launch Results and Prepare FINAL QUERY _______________________________________________________________________________________________
		
		//Launch/Collect applicable cid's
		ArrayList<Integer> cidList=new ArrayList<Integer>();
		try {
			PreparedStatement ps1=con.prepareStatement(sql);
			ResultSet rs1=ps1.executeQuery();
			while(rs1.next()){
				Integer next=rs1.getInt("cid");
				cidList.add(next);
				//note: null's are 0;
			}	
		}catch(SQLException x){
			x.printStackTrace();			
		}
		
		//Create new SQL statement to collect detailed information
		
		//User-Requested Attribute for final output
		String attributes="cid, clastname, cdegreeprogram, cyearofstudy";
		
		//newSQL
		String newSQL="SELECT "+attributes+" FROM "+DataAccessObject.CANDIDATE+" WHERE";
		
		
		boolean results=false;
		//for every CID in the cidList, add a cid condidtion
		for(Integer i: cidList){
			newSQL+=" cid='"+i.toString()+"' OR";
			results=true;
		}
		//Query has results. If extra characters (caused by adding cids) at end, remove them
		if(results){
			newSQL=newSQL.substring(0,newSQL.length()-3);//check 5 ? check 4 NO check 3 YES(1,?) //!@#$
		}else{
			//Query has no results. Add 0 to the WHERE clause
			newSQL=newSQL+" 0";
		}
		
		//STEP 5: RESULTSET OPTIONS AND LAUNCH _______________________________________________________________________________________________
		
		String resultOptions="";
		
		//5.1 OrderBy
		if(orderBy.equalsIgnoreCase("cid")){
			resultOptions+="ORDER BY cid";
		}else if(orderBy.equalsIgnoreCase("cfirstname")){
			resultOptions+=" ORDER BY cfirstname";
		}else if(orderBy.equalsIgnoreCase("clastname")){
			resultOptions+=" ORDER BY clastname";
		}else{
			//error
			System.out.println("shouldnt hell naw be here");
		}
		
		//5.2 orderbydirection
		
		if(orderByDirection.equalsIgnoreCase("asc")){
			resultOptions+=" ASC";
		}else if(orderByDirection.equalsIgnoreCase("desc")){
			resultOptions+=" DESC";
		}else{
			//Error
		}
		
		//5.3 num results	
		resultOptions+=" LIMIT "+startOffset+", "+numResults;
		
		//5.4 Add to sql
		newSQL+=" "+resultOptions;
		
		
		//5.5 Lanuch  //!@#$ resume here. Ready to launch/collect and return results
		try {
			PreparedStatement ps2=con.prepareStatement(newSQL);
			ResultSet rs2=ps2.executeQuery();
			while(rs2.next()){
				Integer next=rs2.getInt("cid");
				System.out.println(next);
				//note: null's are 0;
			}	
		}catch(SQLException x){
			x.printStackTrace();			
		}
		
		//STEP 6 TEST PRINT _____________________________________________________________________________________________
		
		
		System.out.println("FINAL QUERIES:");
		System.out.println(sql);
		System.out.println(newSQL);
		System.out.println("____________________________");
		
		
		
		return null;
	}//METHOD
	
	
}//class

/*

//Constructor
	public Search(DataAccessObject dao, String query, String[] args){
		this.dao=dao;
		this.query=query;
		this.args=args;
		con=dao.getCon();
	}
	
	//Method
	public CachedRowSetImpl getResults(){
		
		//Tokenize/Split query into words
		String[] tokens=query.split(" ");
		int[] tokenType=new int[tokens.length];
		ArrayList<CachedRowSetImpl>all=new ArrayList<>(); //!@#Depricating. Moving to store cid's in ArrayLlist<String[]>
		ArrayList<ArrayList<String>>alls=new ArrayList<>();
		
		//Step 1: Check for Integers
		
		//Check for any pure integers among the tokens (ex "2", but not "20-12-15"
		//for every token,
		for(int i=0;i<tokens.length; i++){
			//try to parse an integer out of token
			try{
				Integer.parseInt(tokens[i]);
				//then it is a number, and its position is marked as a number(1) in the tokenType array
				tokenType[i]=1;
			}catch(NumberFormatException x){
				//else it is a string, and its position is marked as a string(0) in the tokenType array
				tokenType[i]=0;
			}
			
			
		}//for
		
		//Step 2: Process arguments. Determine what arguments to append to the ARGS string (which will be appended to the queries)
		
		String ARGS="";
		
		//If args 0-3 are all of the same (either "on" or "null"), no specific gender to search for
		if(args[0].compareTo(args[1])==0 && args[2].compareTo(args[3])==0 && args[1].compareTo(args[2])==0){
			//no change to ARGS
		}else{
			//else, specific gender to search for. Determine all "on"s
			for(int i=0; i<4; i++){
				if(args[i].equalsIgnoreCase("on")){
					switch(i){
					case 0: //male
						ARGS+=" AND gender='Male'";
						break;
					case 1: //female
						ARGS+=" AND gender='Female'";
						break;
					case 2: //trans
						ARGS+=" AND gender='Transgendered'";
						break;
					case 3: //other
						ARGS+=" AND gender='Other'";
						break;
					}
				}
			}//for
		}
		
		//Args[4] is the candidate degree. This is the string literal of the SQL enum type, used in the db.
		//if args[4] is not null,
		if(!args[4].equalsIgnoreCase("null")){
			//append args[4] to ARGS
			ARGS+=" AND cdegreeprogram='"+args[4]+"'";
		}
		
		
		//Step 3: Launch the Queries, and collect results into 'all'
		
		for(int i=0;i<tokens.length;i++){
			if(tokenType[i]==1){
				//Integer. Query all Integer fields.
				try{
					
					//!@#$ for all of the following queries, fix the wildcard usage in the statement. %se% example
					//for now, no wildcard on integers
					
					//cid
					PreparedStatement stmt1= con.prepareStatement("SELECT cid FROM "+DataAccessObject.CANDIDATE+" WHERE cid=?"+ARGS);
			    	stmt1.setString(1, tokens[i]);
			    	ResultSet rst1=stmt1.executeQuery();
			    	//if query has results, add to all
					if(rst1.first()){
						//all.add(dao.convertToCRSI(rst1));
						ArrayList<String> temp=new ArrayList<>();
						rst1.beforeFirst();
						while(rst1.next()){
							temp.add(rst1.getString("cid"));
						}
					}
					
					//cyearofstudy
					PreparedStatement stmt2= con.prepareStatement("SELECT cid FROM "+DataAccessObject.CANDIDATE+" WHERE cyearofstudy=?"+ARGS);
			    	stmt2.setString(1, tokens[i]);
			    	ResultSet rst2=stmt2.executeQuery();
			    	//if query has results, add to all
					if(rst2.first()){
						all.add(dao.convertToCRSI(rst2)); 
					}
					
					//cphonenumber
					PreparedStatement stmt3= con.prepareStatement("SELECT cid FROM "+DataAccessObject.CANDIDATE+" WHERE cphonenumber=?"+ARGS);
			    	stmt3.setString(1, tokens[i]);
			    	ResultSet rst3=stmt3.executeQuery();
			    	//if query has results, add to all
					if(rst3.first()){
						all.add(dao.convertToCRSI(rst3)); 
					}
					
					
					
				}catch(SQLException x){
					x.printStackTrace();
				}//try
				
				
			}else{
				//String. Query all String fields.
					
			
				try {
					
					//cfirstname
					PreparedStatement stmt1 = con.prepareStatement("SELECT cid FROM "+DataAccessObject.CANDIDATE+" WHERE cfirstname LIKE ?"+ARGS); //!@#modifying
					stmt1.setString(1, "%"+tokens[i]+"%");
			    	ResultSet rst1=stmt1.executeQuery();
			    	//if query has results, add to all
			    	if(rst1.first()){
						//all.add(dao.convertToCRSI(rst1));
						ArrayList<String> temp=new ArrayList<>();
						rst1.beforeFirst();
						while(rst1.next()){
							temp.add(rst1.getString("cid"));
						}
					}
					
					//clastname
					PreparedStatement stmt2 = con.prepareStatement("SELECT cid FROM "+DataAccessObject.CANDIDATE+" WHERE clastname LIKE ?"+ARGS);
					stmt2.setString(1, "%"+tokens[i]+"%");
			    	ResultSet rst2=stmt2.executeQuery();
			    	//if query has results, add to all
			    	if(rst2.first()){
						//all.add(dao.convertToCRSI(rst1));
						ArrayList<String> temp=new ArrayList<>();
						rst2.beforeFirst();
						while(rst2.next()){
							temp.add(rst2.getString("cid"));
						}
					}
					
					//cemail
					PreparedStatement stmt3 = con.prepareStatement("SELECT cid FROM "+DataAccessObject.CANDIDATE+" WHERE cemail LIKE ?"+ARGS);
					stmt3.setString(1, "%"+tokens[i]+"%");
			    	ResultSet rst3=stmt3.executeQuery();
			    	//if query has results, add to all
			    	if(rst3.first()){
						//all.add(dao.convertToCRSI(rst1));
						ArrayList<String> temp=new ArrayList<>();
						rst3.beforeFirst();
						while(rst3.next()){
							temp.add(rst3.getString("cid"));
						}
					}
				
					//cjobhistory
					PreparedStatement stmt4 = con.prepareStatement("SELECT cid FROM "+DataAccessObject.CANDIDATE+" WHERE cjobhistory LIKE ?"+ARGS);
					stmt4.setString(1, "%"+tokens[i]+"%");
			    	ResultSet rst4=stmt4.executeQuery();
			    	//if query has results, add to all
			    	if(rst4.first()){
						//all.add(dao.convertToCRSI(rst1));
						ArrayList<String> temp=new ArrayList<>();
						rst4.beforeFirst();
						while(rst4.next()){
							temp.add(rst4.getString("cid"));
						}
					}
				
				
				
				} catch (SQLException e) {
					e.printStackTrace();
				}
				
				
			}//1 or 0	
			
		}//i: Step 3
		
		
		//Result
		return collateResults(alls);
	}
	
	//helper method
	private CachedRowSetImpl collateResults(ArrayList<ArrayList<String>> in){
		
		//using a HashSet<string> for no duplicates
		HashSet<String> h=new HashSet<>();
		
		//for all of the CSRI's inside in
		for(int i=0;i<in.size();i++){
//			//and for each of the rows inside each CSRI(CSRI=in.get(i))
			for(int j=0;j<in.get(i).size();j++){
				String s=in.get(i).get(j);
				h.add(s);
					
			}//j
		}//i
		
		
		
		//TEST PRINT
		System.out.println("HashSet h:");		
		for(String s: h){
			System.out.println(s+".");
		}
		
		return null;
	}

*/