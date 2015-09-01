package testObjects;

import objects.DataAccessObject;
import objects.Search;

public class testSearch {

	public static void main(String[] args) {
	
		//Vars
		DataAccessObject dao=new DataAccessObject();
		
		//Search Strings
		String queryFirst="";
		String queryLast="Monaling";
		String queryID="1000200";
		String queryPhone="889472010";
		String area="";  
		String yearInt=""; 
		String yearLogic="lessThan"; 
		//From Result Options
		int[] attrindex=new int[]{1,2,3,4,6,7};
		int orderBy=1; //cid=1
		String orderByDirection="asc";
		Integer numResults=25;	
		
		//Search object
		Search s=new Search(queryFirst,queryLast,queryID,queryPhone, area, yearInt, yearLogic);
			
		
		//getResults Test
		//System.out.println("\ngetResultsSQLQuery() Test: ___________________________");
		String output=s.getResultSQLQuery(attrindex, orderBy, 0, numResults, orderByDirection);
		System.out.println(output);
		
	}//main

}//class
