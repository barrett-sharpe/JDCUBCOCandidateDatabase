package objects;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Search {

	//VARIABLES FOR CLASS
	DataAccessObject dao;
	Connection con;
	Character[] unacceptable=new Character[]{'-','!','@','#','$','%','^','&','*','(',')','_','+','=','{','}',':',';','\\','"','?','<','>',',','.','|'};
	String finalQuery=null; 
	
	//VARIABLES FOR QUERY
	
	//From Candidate Options
	String queryFirst="";
	String queryLast="";
	String queryID="";
	String queryPhone="";
	String area="";
	String yearInt="";
	String yearLogic="";
	//From Result Options (Defaults; .getResults() take these params in
	String orderBy="cid";  //
	String orderByDirection="asc";
	Integer numResults=25;
	
	//!@#$Thnigs for later
	/*
	 * Sanatizing queryNum of symbols +()- 
	 * fix all error conditions so they return null or something.
	 * 
	 */
	
	
	
	
	//Constructor
	/**
	 * Constructor
	 * @param queryString
	 * @param queryNum
	 * @param area
	 * @param yearInt
	 * @param yearLogic
	 */
	public Search(String queryFirst, String queryLast, String queryID, String queryPhone, String area, String yearInt, String yearLogic){
		this.queryFirst=queryFirst;
		this.queryLast=queryLast;
		this.queryID=queryID;
		this.queryPhone=queryPhone;
		this.area=area;
		this.yearInt=yearInt;
		this.yearLogic=yearLogic;
		
		//instantiate dao and con
		dao=new DataAccessObject();
		con=dao.getCon();
	}

	//helper methods
	/**
	 * Prints out the Search object's Candidate's Options
	 * @return
	 */
	public String showAll(){
		String result="ALL CURRENT QUERY VALUES:\n";
		result+="queryFirst:"+queryFirst;
		result+="\nqueryLast:"+queryLast;
		result+="\nqueryID:"+queryID;
		result+="\nqueryPhone:"+queryPhone;
		result+="\narea:"+area;
		result+="\nyearInt:"+yearInt;
		result+="\nyearLogic:"+yearLogic;

		//print
		System.out.println(result);
		//and return
		return result;
	}
	
	/**
	 * Validates and sanitizes the input to the search method. Returns a boolean, indicating whether or not it can proceded with given inputs.
	 * @return boolean
	 */
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
	 *Returns the counted integer, given the selected attribute index, and the value of that attribute
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
	 * 11) cresumelink
	 * 12) cdescription
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
				attr[i]="cresumelink";
				break;
			case 12:
				attr[i]="cdescription";
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
	 * This method returns a String SQL query, which contains all of the CID's of candidates that match the user's inputs. That query can then be launched by {@link getREsultsFromQuery()} method. 
	 * @param attributeIndex
	 * @param orderByIndex
	 * @param startOffset
	 * @param totalNumber
	 * @param orderByDirection
	 * @return
	 */
	public String getResultSQLQuery(int[] attributeIndex, int orderByIndex, int startOffset, int totalNumber, String orderByDirection){
		
		String sql="";
		
		//STEP 1: VALIDATE VARIABLES _______________________________________________________________________________

		boolean valid=validateInput();
		
		
		
		//STEP 2: FIGURE OUT WHAT QUERIES TO BE DONE, BY ESTABLISHING WHAT FIELDS ARE EMPTY.  __________________________________
		
		boolean hasQueryFirst=true;
		boolean hasQueryLast=true;
		boolean hasQueryID=true;
		boolean hasQueryPhone=true;
		boolean hasYearInt=true;
		boolean hasArea=true;
		Boolean[] has=new Boolean[6]; 
		Integer qCount=6;
		
		//If The Given Inputs Were Valid
		if(valid){		
			System.out.println("Inputs Valid"); //TEST
			
			if(queryFirst==null||queryFirst.isEmpty()||queryFirst.length()==0||queryFirst.equalsIgnoreCase("")){
				//nothing was input to queryFirst, so no first name
				hasQueryFirst=false;
				qCount--;
			}
			if(queryLast==null||queryLast.isEmpty()||queryLast.length()==0||queryLast.equalsIgnoreCase("")){
				//nothing was input to queryLast, so no first name
				hasQueryLast=false;
				qCount--;
			}
			if(queryID==null||queryID.isEmpty()||queryID.length()==0||queryID.equalsIgnoreCase("")){
				//nothing entered for queryID, so no specific cid
				hasQueryID=false;
				qCount--;
			}
			if(queryPhone==null||queryPhone.isEmpty()||queryPhone.length()==0||queryPhone.equalsIgnoreCase("")){
				//nothing entered for queryPhone, so no specific phone number
				hasQueryPhone=false;
				qCount--;
			}
			if(area==null||area=="null"||area.isEmpty()||area.length()==0||area.equalsIgnoreCase("")){
				//no area was input, OR, "Any Area" (with a value of "null", the default option) was input.
				//Either way, it means we do not have to specify a particular area.
				hasArea=false;
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
		has[0]=hasQueryFirst;
		has[1]=hasQueryLast;
		has[2]=hasQueryID;
		has[3]=hasQueryPhone;
		has[4]=hasYearInt;
		has[5]=hasArea;
		
		//Only Need Attribute 'cid' For Inner Join Selects
		String attrs="cid";
		
		
		//STEP 3: DETERMINE AND COMPILE QUERIES  _______________________________________________________________________________
		
		System.out.println("Determining Query:\n"+qCount+ " attributes used."); //TEST
		
		//Based On the Number Of Fields Filled In By The User, The Formation Of The SQL Query Is Different. Observe the following 3 cases:
		//CASE 1: (1 FIELD). A simple query like: "SELECT cid FROM candidate WHERE cfirstname='devon' UNION DISTINCT SELECT cid FROM candidate WHERE clastname='devon'" may be used.
		//CASE 2: (2+ FIELDs). A JOIN is need to assure that rows in the final output meet ALL of the conditions of the query. This involves using aliases to do joins, and the variable nature of the input make this complicated. Example:
		//CASE 3: (0 fields). Show no results.
		
	
		if(qCount>1){		
			//CASE 2: (2+ FIELDs). An INNER JOIN is need
			
			//ALPHA: alias, attrName and values ArrayLists
			ArrayList<String> alias=new ArrayList<String>();
			ArrayList<String> attrName=new ArrayList<String>();
			ArrayList<String> values=new ArrayList<String>();
			
			for(int i=0;i<has.length;i++){
				switch(i){
				case 0: //queryFirst
					if(has[i]){
						alias.add("queryFirst");
						attrName.add("cfirstname");
						values.add(queryFirst);
					}
					break;
				case 1: //queryLast
					if(has[i]){
						alias.add("queryLast");
						attrName.add("clastname");
						values.add(queryLast);
					}
					break ;
				case 2: //queryID
					if(has[i]){
						alias.add("queryID");
						attrName.add("cid");
						values.add(queryID);
					}
					break;
				case 3: //queryPhone
					if(has[i]){
						alias.add("queryPhone");
						attrName.add("cphonenumber");
						values.add(queryPhone);
					}
					break;
				case 4: //yearInt
					if(has[i]){
						alias.add("yearInt");
						attrName.add("cyearofstudy");
						values.add(yearInt);
					}
					break;
				case 5: //area
					if(has[i]){
						alias.add("area");
						attrName.add("cdegreeprogram");
						values.add(area);
					}	
					break;
				default:
					break;
				}
			}//for
			
			
			//BRAVO: Create INNER JOIN SQL
			boolean first=true;
			for(int i=0;i<alias.size();i++){
				if(first){
					sql+=""+DataAccessObject.CANDIDATE+" AS "+alias.get(i);
					first=false;
				}else{
					sql+=" INNER JOIN "+DataAccessObject.CANDIDATE+" AS "+alias.get(i)+" ON ";
					sql+=""+alias.get(i-1)+".cid = "+alias.get(i)+".cid";
				}
			}//Bfor
			
			//CHARLIE: WHERE conditions
			sql+=" WHERE";
			for(int i=0;i<alias.size();i++){
				//if it's an integer (alias: yearInt)
				if(alias.get(i).equalsIgnoreCase("yearInt")){
					String sign="";
					if(yearLogic.equalsIgnoreCase("equal")){
						sign="=";
					}else if(yearLogic.equalsIgnoreCase("lessThan")){
						sign="<";
					}else{
						sign=">";
					}
					sql+=" "+alias.get(i)+"."+attrName.get(i)+" "+sign+" "+values.get(i)+" AND";
				}else{
					//not an integer, normal.
					sql+=" "+alias.get(i)+"."+attrName.get(i)+"='"+values.get(i)+"' AND";
				}
			}
			sql=sql.substring(0,sql.length()-4); //check 4
			
			
			//DELTA: Form Beginning of SQL
			sql="SELECT "+alias.get(0)+".cid FROM "+sql;;
				
			//!@#%ERROR TESTING
			System.out.println("INITIAL QUERY:\n"+sql);
			
			
			
			
			
			
		}else if(qCount==1){
			// Case 1: (1 Field) Only a single field was entered by the user.
					
			//ALPHA: alias, attrName and values ArrayLists
			ArrayList<String> alias=new ArrayList<String>();
			ArrayList<String> attrName=new ArrayList<String>();
			ArrayList<String> values=new ArrayList<String>();
			
			for(int i=0;i<has.length;i++){
				switch(i){
				case 0: //queryFirst
					if(has[i]){
						alias.add("queryFirst");
						attrName.add("cfirstname");
						values.add(queryFirst);
					}
					break;
				case 1: //queryLast
					if(has[i]){
						alias.add("queryLast");
						attrName.add("clastname");
						values.add(queryLast);
					}
					break ;
				case 2: //queryID
					if(has[i]){
						alias.add("queryID");
						attrName.add("cid");
						values.add(queryID);
					}
					break;
				case 3: //queryPhone
					if(has[i]){
						alias.add("queryPhone");
						attrName.add("cphonenumber");
						values.add(queryPhone);
					}
					break;
				case 4: //yearInt
					if(has[i]){
						alias.add("yearInt");
						attrName.add("cyearofstudy");
						values.add(queryPhone);
					}
					break;
				case 5: //area
					if(has[i]){
						alias.add("area");
						attrName.add("cdegreeprogram");
						values.add(area);
					}	
					break;
				default:
					break;
				}
			}//for
			
			//BRAVO: Make statement
			sql="SELECT "+attrs+" FROM "+DataAccessObject.CANDIDATE+" WHERE "+attrName.get(0)+"='"+values.get(0)+"'";
			
						
		//1 or More Fields
		}else{
			//0 Fields
			System.out.println("0 fields used. No entries.");	
			//show all from database
			sql+="SELECT cid FROM "+DataAccessObject.CANDIDATE+" WHERE 0";

		}//0 Fields

		
		
		//STEP 4: Launch Results and Populate cidList _______________________________________________________________________________________________
		
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
				String attributes="";
				for(int i: attributeIndex){
					switch(i){
					case 1:
						attributes+="cid, ";
						break;
					case 2:
						attributes+="cfirstname, ";
						break;
					case 3:
						attributes+="clastname, ";
						break;
					case 4:
						attributes+="gender, ";
						break;
					case 5:
						attributes+="cdateofbirth, ";
						break;
					case 6:
						attributes+="cyearofstudy, ";
						break;
					case 7:
						attributes+="cdegreeprogram, ";
						break;
					case 8:
						attributes+="cjobhistory, ";
						break;
					case 9:
						attributes+="cemail, ";
						break;
					case 10:
						attributes+="cphonenumber, ";
						break;
					case 11:
						attributes+="cresumelink, ";
						break;
					case 12:
						attributes+="cdescription, ";
						break;
					}
				}
				attributes=attributes.substring(0, attributes.length()-2); //check
				
				
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
				resultOptions+="ORDER BY ";
				switch(orderByIndex){
				case 1:
					resultOptions+="cid";
					break;
				case 2:
					resultOptions+="cfirstname";
					break;
				case 3:
					resultOptions+="clastname";
					break;
				case 4:
					resultOptions+="gender";
					break;
				case 5:
					resultOptions+="cdateofbirth";
					break;
				case 6:
					resultOptions+="cyearofstudy";
					break;
				case 7:
					resultOptions+="cdegreeprogram";
					break;
				case 8:
					resultOptions+="cjobhistory";
					break;
				case 9:
					resultOptions+="cemail";
					break;
				case 10:
					resultOptions+="cphonenumber";
					break;
				case 11:
					resultOptions+="cresumelink";
					break;
				case 12:
					resultOptions+="cdescription";
					break;
				default:
					resultOptions+="cid";
					System.out.println("shouldnt hell naw be here");
					break;
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
				resultOptions+=" LIMIT "+startOffset+", "+totalNumber;
				
				//5.4 Add to sql
				newSQL+=" "+resultOptions;
				
				
				//STEP 6: REturn SQL
				
				//set final sql query to finalquery
				finalQuery=newSQL;
				return newSQL;	
	}//method
	
	
	public ArrayList<CanMap> getResultsFromQuery(String sql, int[] attributeIndex, int orderByIndex, int startOffset, int totalNumber, String orderByDirection){
	
		
		//Collect candidates
		ArrayList<CanMap> result= new ArrayList<CanMap>();
		try {
			PreparedStatement ps2=con.prepareStatement(sql);
			ResultSet rs2=ps2.executeQuery();
			
			//iterate through each result
			while(rs2.next()){
				
				CanMap can=new CanMap();
				
				//and pick/add only the specified attrs
				for(int i: attributeIndex){
					switch(i){
					case 1:
						can.put("cid", rs2.getString("cid"));
						break;
					case 2:
						can.put("cFirstName", rs2.getString("cfirstname"));
						break;
					case 3:
						can.put("cLastName", rs2.getString("clastname"));
						break;
					case 4:
						can.put("gender", rs2.getString("gender"));
						break;
					case 5:
						can.put("dob", rs2.getString("cdateofbirth"));
						break;
					case 6:
						can.put("cYear", rs2.getString("cyearofstudy"));
						break;
					case 7:
						can.put("degree", rs2.getString("cdegreeprogram"));
						break;
					case 8:
						can.put("cJobHistory", rs2.getString("cjobhistory"));
						break;
					case 9:
						can.put("cEmail", rs2.getString("cemail"));
						break;
					case 10:
						can.put("cPhoneNumber", rs2.getString("cphonenumber"));
						break;
					case 11:
						can.put("cResumeLink", rs2.getString("cresumelink"));
						break;
					case 12:
						can.put("cDescription", rs2.getString("cdescription"));
						break;
					default:
						System.out.println("Nope nope nope.");
						break;
					
					}//switch
				}
				
				//add can to result
				result.add(can);
				
			}//while			
			
		}catch(SQLException x){
			x.printStackTrace();			
		}
		
		//TEST
//		System.out.println("FINAL QUERIES:");
//		System.out.println(finalQuery);
		
		//return Candidate List
		return result;
		
		
	}//Method
	
	//
	//GETTERS AND SETTERS______________________________________-
	//
	
	public String getFinalQuery(){
		return finalQuery;
	}
	
}//class

/*

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


*/














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