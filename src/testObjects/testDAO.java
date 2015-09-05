package testObjects;

import objects.CanMap;
import objects.DataAccessObject;

public class testDAO {

	public static void pl(String g){
		System.out.println(g);
	}
	
	public static CanMap newMap(){
		//TEST updateCandidate() 
				CanMap map=new CanMap();
				map.put("cid","1000217");
				map.put("cFirstName","test");
				map.put("cLastName", "genderDefault");
				map.put("dob", "1993-08-10");
				map.put("cYear", "2011");
				map.put("gender", "NotDeclared");
				map.put("degree", "Bachelors_Of_Science");
				map.put("cEmail", "barrettsharpe25@gmail.com");
				map.put("cResumeLink", "updated");
				map.put("cPhoneNumber", "7782140522");
				map.put("cDescription", "the update method works");
				map.put("cJobHistory", "updated my history to this fucking job...");
				//cDateLastModified and cDatecreated not used in update
				return map;
	}
	
	public static void main(String[] args) {
		
		//New Data Access Object w/ Connection
		DataAccessObject access=new DataAccessObject();
		
		//String NAME = "AVeryLongSeriesOfCharactersOutsideOfSize24Like!@#$%^&*()_+}{:?><,.;'[]'"; //technically, this went through despite the errors. Look into special character handling.
		
//		//TEST Get User
//		CanMap c1=access.getUser("NAME2"); //ben stu
//		Candidate c=new Candidate();
//		Boolean result=c.setUser(c1);
//		System.out.println(result+")"+c.getcFirstName()+" "+c.getcLastName()+".");
			
		//TEST next CID
		//System.out.println(access.nextAvailableCID());
		
		Integer CID=1000402;
		String Username="tokenBugTest1";
		String Password="password";
		String Token="forgot";
		
		//TEST addCredCandidate
		Integer cid=access.addCredentialsCandidate(Username, Password, Token, CID.toString());
		System.out.println("added CID:"+cid);//cid
		//Update recoveryString
		access.createAndAddRecoveryString(Username, Token);
		
		//Validate rocoveryString
		boolean result=access.validateRecoveryToken(Username,Token);
				
		//Print Results
		System.out.println("Token accepted?:"+result);
		
		//CLOSE CONNECTION
		access.closeConnection();
	}//main

}
