package testObjects;

import objects.DataAccessObject;
import objects.Search;

public class testSearch {

	public static void main(String[] args) {
	
		//Vars
		DataAccessObject dao=new DataAccessObject();
		
		//Search Strings
		String queryString=""; //f  //l   //fl   //lf
		String queryNum="";  //cid  //phone#
		String area="Masters_Of_Arts";  //
		String yearInt=""; //
		String yearLogic="equal"; 
		//From Result Options
		String orderBy="cid";
		String orderByDirection="asc";
		Integer numResults=25;	
		
		//Search object
		Search s=new Search(queryString, queryNum, area, yearInt, yearLogic, orderBy, orderByDirection, numResults);
		
//		//Length test
//		System.out.println("Length Test:");
//		String test=queryString;
//		String[] testa=test.split(" ");
//		System.out.println(testa.length);
		
//		//countAttribute Test
//		System.out.println("\nCountAttribute Test:");
//		Integer[] indexes=new Integer[]{3};
//		String[] values=new String[]{"ethan"};
//		System.out.println("count:"+s.countAttribute(indexes, values));
		
		
		
		//getResults Test
		System.out.println("\ngetResults() Test: ___________________________");
		s.getResults(0);
		
		//showAll
				s.showAll();

	}//main

}//class
