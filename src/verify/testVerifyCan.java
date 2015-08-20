package verify;

import java.util.ArrayList;

import objects.CanMap;

public class testVerifyCan {
	
	//methods
	public static CanMap reset(CanMap map){
		//replace with acceptable values
		map.put("cid","1000124");
		map.put("cFirstName","Dave");
		map.put("cLastName", "Smith");
		map.put("dob", "1993-08-10");
		map.put("cYear", "2001");
		map.put("gender", "Male");
		map.put("degree", "Bachelors_Of_Science");
		map.put("cEmail", "myemail@email.com");
		map.put("cResumeLink", "htttp://www.?");
		map.put("cPhoneNumber", "98765432");
		map.put("cDescription","This is a description");
		map.put("cJobHistory", "this is a job history");
		
		return map;
	}

	//print messages
	public static ArrayList<String> verify(CanMap map){
		//verify
		ArrayList<String> prob=verifyCanMap.verify(map);
		
		//print problems
		if(prob.size()>0){
			System.out.println("\tPrinting problems below:");
		}
		for(String s: prob){
			System.out.println("\t\t~ "+s);
		}

		return prob;
	}
	
//	public static void va(boolean assertion, ArrayList<String> prob){
//		
//		
//	}
	public static void main(String[] args) {
		
		//vars
		CanMap map=new CanMap();
		
		//reset for initial values
		map=reset(map);
		
		//initial values check
		System.out.println("Checking initial values");
		verify(map);
		
		//1 CID
		
		//1.1 not a number //YES
			reset(map);
			System.out.println("CASE: CID NaN");
			map.put("cid","788de99");
			verify(map);
		
		//1.2 length less than 1000000
				reset(map);
				System.out.println("CASE: CID <1000000");
				map.put("cid","999999");
				verify(map);
		//1.3 length more than 9999999
				reset(map);
				System.out.println("CASE: CID >9999999");
				map.put("cid","10000000");
				verify(map);		
		
		//2 CFIRSTNAME
				
		//2.1 cfirstname null
				reset(map);
				System.out.println("CASE: CFIRSTNAME = null");
				map.put("cFirstName", null);
				verify(map);
		//2.2 cfirstname = ""
				reset(map);
				System.out.println("CASE: CFIRSTNAME = \"\" (empty string)");
				map.put("cFirstName", "");
				verify(map);
		//2.3 cf > 30 chars
				reset(map);
				System.out.println("CASE: CFIRSTNAME size > 30");
				map.put("cFirstName", "zxcvbnmasdfghjklqwertyuiopzxcvb");
				verify(map);
		//2.4 cf unacceptable chars
				reset(map);
				System.out.println("CASE: CFIRSTNAME unacceptable chars");
				map.put("cFirstName", "dog$z!");
				verify(map);
		//3 CLASTNAME
		
		//3.1 cl null
				reset(map);
				System.out.println("CASE: CLASTNAME = null");
				map.put("cLastName", null);
				verify(map);
		//3.2 clastname = ""
				reset(map);
				System.out.println("CASE: CLASTNAME = \"\" (empty string)");
				map.put("cLastName", "");
				verify(map);
		//3.3 cl > 30 chars
				reset(map);
				System.out.println("CASE: CLASTNAME size > 30");
				map.put("cLastName", "zxcvbnmasdfghjklqwertyuiopzxcvb");
				verify(map);
		//3.4 cl unacceptable chars
				reset(map);
				System.out.println("CASE: CLASTNAME unacceptable chars");
				map.put("cLastName", "dog$z!");
				verify(map);
				
		//4 DOB DATE OF BIRTH
		
		//4.1 YEAR
				//4.1.1 year NaN
				reset(map);
				System.out.println("CASE: DOB: year NaN");
				map.put("dob", "19G0-08-10");
				verify(map);
				//4.1.2 year < range
				reset(map);
				System.out.println("CASE: DOB: year < min");
				map.put("dob", "1899-08-10");
				verify(map);
				//4.1.3 year > max
				reset(map);
				System.out.println("CASE: DOB: year > max");
				map.put("dob", "2016-08-10");
				verify(map);
				
		//4.2 MONTH
				//4.2.1 month NaN
				reset(map);
				System.out.println("CASE: DOB: month NaN");
				map.put("dob", "1993-0e-10");
				verify(map);
				//4.2.2 month < range
				reset(map);
				System.out.println("CASE: DOB: month < min");
				map.put("dob", "1993-00-10");
				verify(map);
				//4.2.3 month > max
				reset(map);
				System.out.println("CASE: DOB: month > max");
				map.put("dob", "1993-13-10");
				verify(map);
				//4.2.4 month no param
				reset(map);
				System.out.println("CASE: DOB: month no param. ie, just year given");
				map.put("dob", "1993");
				verify(map);
		//4.3 DAY
				//4.3.1 day NaN
				reset(map);
				System.out.println("CASE: DOB: month NaN");
				map.put("dob", "1993-08-e0");
				verify(map);
				//4.3.2 day < range
				reset(map);
				System.out.println("CASE: DOB: month < min");
				map.put("dob", "1993-08-00");
				verify(map);
				//4.3.3 day > max
				reset(map);
				System.out.println("CASE: DOB: month > max");
				map.put("dob", "1993-08-42");
				verify(map);
				//4.3.4 day no param
				reset(map);
				System.out.println("CASE: DOB: day no param. ie, just year and month given");
				map.put("dob", "1993-08");
				verify(map);
		
		//4.4 SPECIAL
				reset(map);
				System.out.println("CASE: DOB: NOTHING GIVEN \"\"");
				map.put("dob", "");
				verify(map);
					
		//5 CYEAR
		
		//5.1 cyear = null
				reset(map);
				System.out.println("CASE: CYEAR = null");
				map.put("cYear", null);
				verify(map);
		//5.2 cyear = ""
				reset(map);
				System.out.println("CASE: CYEAR = \"\" (empty)");
				map.put("cYear", "");
				verify(map);
		//5.3 cyear NaN
				reset(map);
				System.out.println("CASE: CYEAR NaN");
				map.put("cYear", "199!");
				verify(map);
				
		
		//6 GENDER //!@# come back to this
		
		//6.1 gender = null
				reset(map);
				System.out.println("CASE: GENDER null");
				map.put("gender", null);
				verify(map);
		//6.2 gender = ""
				reset(map);
				System.out.println("CASE: GENDER = \"\" ");
				map.put("gender", "");
				verify(map);
		//6.3 gender valid
				reset(map);
				System.out.println("CASE: GENDER valid");
				map.put("gender", "Other");
				verify(map);
		//6.4 gender invalid
				reset(map);
				System.out.println("CASE: GENDER invalid");
				map.put("gender", "Clingon");
				verify(map);
				
		//7 DEGREE
		
		//7.1 degree = null (converted ot none of above)
				reset(map);
				System.out.println("CASE: DEGREE null");
				map.put("degree", null);
				verify(map);
		//7.2 degree valid
				reset(map);
				System.out.println("CASE: DEGREE valid");
				map.put("degree", "Bachelors_Of_Science");
				verify(map);
		//7.3 degree invalid
				reset(map);
				System.out.println("CASE: DEGREE invalid");
				map.put("degree", "I hate unit testing...");
				verify(map);
				
				
		//8 CEMAIL
		//8.1 length < 100
				reset(map);
				System.out.println("CASE: CEMAIL valid length");
				map.put("cEmail", "myfirstthenlastname12@reallylongstring.email.com");
				verify(map);
		//8.2 length > 100
				reset(map);
				System.out.println("CASE: CEMAIL invalid length");
				map.put("cEmail", "myfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12myfirstthenlastname12myfirstthenlastname12myfirstthenlastname12myfirstthenlastname12");
				verify(map);
				
		//9 CRESUMELINK
		//9.1 length < 400
				reset(map);
				System.out.println("CASE: CRESUMELINK valid length");
				map.put("cResumeLink", "myfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.com");
				verify(map);
		//9.2 length > 400
				reset(map);
				System.out.println("CASE: CRESUMELINK invalid length");
				map.put("cResumeLink", "myfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.com");
				verify(map);
		
		//10 CPHONENUMBER
		//10.1 phone valid
				reset(map);
				System.out.println("CASE: PHONE valid");
				map.put("cPhoneNumber", "12345678");
				verify(map);
		//10.2 phone null
				reset(map);
				System.out.println("CASE: PHONE null");
				map.put("cPhoneNumber", null);
				verify(map);
		//10.3 phone empty
				reset(map);
				System.out.println("CASE: PHONE \"\" (empty)");
				map.put("cPhoneNumber", "");
				verify(map);
		//10.4 phone sym1
				reset(map);
				System.out.println("CASE: PHONE special 1");
				map.put("cPhoneNumber", "+1(234)-5678");
				verify(map);
		//10.5 phone big number		
				reset(map);
				System.out.println("CASE: PHONE big number");
				map.put("cPhoneNumber", "135223562623683516046587864");
				verify(map);
				
				//!@#$resume here
				
				
		//11 CDESCRIPTION
		//11.1 Length < 1000
				reset(map);
				System.out.println("CASE: DESCRIPTION valid length");
				map.put("cDescription", "myfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.com");
				verify(map);
		//11.2 Length <1000
				reset(map);
				System.out.println("CASE: DESCRIPTION invalid length");
				map.put("cDescription","myfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.com");
				verify(map);
				
		//12 CJOBHISTORY
		//12.1 Length < 1000
				reset(map);
				System.out.println("CASE: JOBHISTORY valid length");
				map.put("cJobHistory", "myfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.com");
				verify(map);
		//12.2 Length <1000
				reset(map);
				System.out.println("CASE: JOBHISTORY invalid length");
				map.put("cJobHistory","myfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.com");
				verify(map);		
		//TEST COMPLETED
		System.out.println("TEST COMPLETED.");
		
	}//main

}//class
