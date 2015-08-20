package objects;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;

import com.sun.rowset.CachedRowSetImpl;

public class Search {

	//Variables
	DataAccessObject dao;
	String query="";
	String[] args; 
	Connection con;
	
	
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
					PreparedStatement stmt1= con.prepareStatement("SELECT cid FROM "+dao.CANDIDATE+" WHERE cid=?"+ARGS);
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
					PreparedStatement stmt2= con.prepareStatement("SELECT cid FROM "+dao.CANDIDATE+" WHERE cyearofstudy=?"+ARGS);
			    	stmt2.setString(1, tokens[i]);
			    	ResultSet rst2=stmt2.executeQuery();
			    	//if query has results, add to all
					if(rst2.first()){
						all.add(dao.convertToCRSI(rst2)); 
					}
					
					//cphonenumber
					PreparedStatement stmt3= con.prepareStatement("SELECT cid FROM "+dao.CANDIDATE+" WHERE cphonenumber=?"+ARGS);
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
					PreparedStatement stmt1 = con.prepareStatement("SELECT cid FROM "+dao.CANDIDATE+" WHERE cfirstname LIKE ?"+ARGS); //!@#modifying
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
					PreparedStatement stmt2 = con.prepareStatement("SELECT cid FROM "+dao.CANDIDATE+" WHERE clastname LIKE ?"+ARGS);
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
					PreparedStatement stmt3 = con.prepareStatement("SELECT cid FROM "+dao.CANDIDATE+" WHERE cemail LIKE ?"+ARGS);
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
					PreparedStatement stmt4 = con.prepareStatement("SELECT cid FROM "+dao.CANDIDATE+" WHERE cjobhistory LIKE ?"+ARGS);
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
	
}//class
