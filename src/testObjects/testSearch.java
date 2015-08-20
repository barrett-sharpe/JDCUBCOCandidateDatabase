package testObjects;

import objects.DataAccessObject;
import objects.Search;

public class testSearch {

	public static void main(String[] args) {
	
		//Vars
		DataAccessObject dao=new DataAccessObject();
		String[] argus=new String[5];
		argus[0]="null"; //m
		argus[1]="on"; //f
		argus[2]="null"; //t
		argus[3]="null"; //o
		argus[4]="Bachelors_Of_Management_Other"; //job
		String query="ben";
		
				
		//search
		Search s=new Search(dao, query, argus);
		
		s.getResults();
		
		
		
		
		
		
		

	}//main

}//class
