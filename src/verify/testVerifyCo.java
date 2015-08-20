package verify;

import java.util.ArrayList;
import objects.CoMap;

public class testVerifyCo {
	
	//methods
	public static CoMap reset(CoMap map){
		//replace with acceptable values
		map.put("coid","100025");
		map.put("coName", "Vague Name Ltd.");
		map.put("coYearEstablished", "1986");
		map.put("coEmail", "vague.nam3@email.com");
		map.put("coUrl", "http://_name!@#$%^&*()-+=");
		map.put("coContactName", "Dave Un derHill blahbalg");
		map.put("coAddress", "1234 Fake address, Fake city, country, postal-code");
		map.put("coTel", "+01(789)-456-1230");
		map.put("coDescription", "We're fake, deal with it :)");
		map.put("coSocial", "http://_name!@#$%^&*()-+=");
		
		return map;
	}

	//print messages
	public static ArrayList<String> verify(CoMap map){
		//verify
		ArrayList<String> prob=verifyCoMap.verify(map);
		
		//print problems
		if(prob.size()>0){
			System.out.println("\tPrinting problems below:");
		}
		for(String s: prob){
			System.out.println("\t\t~ "+s);
		}

		return prob;
	}
	

	public static void main(String[] args) {
		
		//vars
		CoMap map=new CoMap();
		
		//reset for initial values
		map=reset(map);
		
		//initial values check
		System.out.println("Checking initial values");
		verify(map);
		
		//1 COID
		
		//1.1 not a number //YES
			reset(map);
			System.out.println("CASE: coid NaN");
			map.put("coid","78de99");
			verify(map);
		
		//1.2 length less than 100000
				reset(map);
				System.out.println("CASE: coid <100000");
				map.put("coid","99999");
				verify(map);
		//1.3 length more than 999999
				reset(map);
				System.out.println("CASE: coid >999999");
				map.put("coid","1000000");
				verify(map);		
		
		//2 CONAME
				
		//2.1 coName null
				reset(map);
				System.out.println("CASE: coName = null");
				map.put("coName", null);
				verify(map);
		//2.2 coName = ""
				reset(map);
				System.out.println("CASE: coName = \"\" (empty string)");
				map.put("coName", "");
				verify(map);
		//2.3 cn > 30 chars
				reset(map);
				System.out.println("CASE: coName size > 50");
				map.put("coName", "zxcvbnmasdfghjklqwertyuiopzxcvbzxcvbnmasdfghjklqwertyuiopzxcvb");
				verify(map);
//		//2.4 cn unacceptable chars
//				reset(map);
//				System.out.println("CASE: coName unacceptable chars");
//				map.put("coName", "dog$z!");
//				verify(map);
//			
					
		//3 coYearEstablished
		
		//3.1 coYearEstablished = null
				reset(map);
				System.out.println("CASE: coYearEstablished = null");
				map.put("coYearEstablished", null);
				verify(map);
		//3.2 coYearEstablished = ""
				reset(map);
				System.out.println("CASE: coYearEstablished = \"\" (empty)");
				map.put("coYearEstablished", "");
				verify(map);
		//3.3 coYearEstablished NaN
				reset(map);
				System.out.println("CASE: coYearEstablished NaN");
				map.put("coYearEstablished", "199!");
				verify(map);				
				
		//4 coEmail
				
		//4.1 length < 100
				reset(map);
				System.out.println("CASE: coEmail valid length");
				map.put("coEmail", "myfirstthenlastname12@reallylongstring.email.com");
				verify(map);
		//4.2 length > 100
				reset(map);
				System.out.println("CASE: coEmail invalid length");
				map.put("coEmail", "myfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12myfirstthenlastname12myfirstthenlastname12myfirstthenlastname12myfirstthenlastname12");
				verify(map);
				
		//5 coUrl
		//5.1 length < 400
				reset(map);
				System.out.println("CASE: coUrl valid length");
				map.put("coUrl", "myfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.com");
				verify(map);
		//5.2 length > 400
				reset(map);
				System.out.println("CASE: coUrl invalid length");
				map.put("coUrl", "myfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.com");
				verify(map);
		
		//6 coContactName
		
		//6.1 length < 100
				reset(map);
				System.out.println("CASE: coContactName valid length");
				map.put("coContactName", "myfirstthenlastname12@reallylongstring.email.com");
				verify(map);
		//6.2 length > 100
				reset(map);
				System.out.println("CASE: coContactName invalid length");
				map.put("coContactName", "myfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12myfirstthenlastname12myfirstthenlastname12myfirstthenlastname12myfirstthenlastname12");
				verify(map);
				
		//7 coAddress
				
		//7.1 length < 200
				reset(map);
				System.out.println("CASE: coAddress valid length");
				map.put("coAddress", "myfirstthenlastname12@reallylongstring.email.com");
				verify(map);
		//7.2 length > 200
				reset(map);
				System.out.println("CASE: coAddress invalid length");
				map.put("coAddress", "myfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12myfirstthenlastname12myfirstthenlastname12myfirstthenlastname12myfirstthenlastname1myfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12myfirstthenlastname12myfirstthenlastname12myfirstthenlastname12myfirstthenlastname122");
				verify(map);		
				
		//8 coTel
		//8.1 phone valid
				reset(map);
				System.out.println("CASE: PHONE valid");
				map.put("coTel", "12345678");
				verify(map);
		//8.2 phone null
				reset(map);
				System.out.println("CASE: PHONE null");
				map.put("coTel", null);
				verify(map);
		//8.3 phone empty
				reset(map);
				System.out.println("CASE: PHONE \"\" (empty)");
				map.put("coTel", "");
				verify(map);
		//8.4 phone sym1
				reset(map);
				System.out.println("CASE: PHONE special 1");
				map.put("coTel", "+1(234)-5678");
				verify(map);
		//8.5 phone big number		
				reset(map);
				System.out.println("CASE: PHONE big number");
				map.put("coTel", "135223562623683516046587864");
				verify(map);		
				
		//9 coDescription
		//9.1 Length < 1000
				reset(map);
				System.out.println("CASE: DESCRIPTION valid length");
				map.put("coDescription", "myfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.com");
				verify(map);
		//9.2 Length <1000
				reset(map);
				System.out.println("CASE: DESCRIPTION invalid length");
				map.put("coDescription","myfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12@reallylongstring.email.com");
				verify(map);
				
		//10 coSocial	
		//10.1 length < 100
				reset(map);
				System.out.println("CASE: coSocial valid length");
				map.put("coSocial", "myfirstthenlastname12@reallylongstring.email.com");
				verify(map);
		//10.2 length > 100
				reset(map);
				System.out.println("CASE: coSocial invalid length");
				map.put("coSocial", "myfirstthenlastname12@reallylongstring.emaimyfirstthenlastname12@reallylongstring.email.commyfirstthenlastname12myfirstthenlastname12myfirstthenlastname12myfirstthenlastname12myfirstthenlastname12l.commyfirstthenlastname12myfirstthenlastname12myfirstthenlastname12myfirstthenlastname12myfirstthenlastname12");
				verify(map);
				
		//TEST COMPLETED
		System.out.println("TEST COMPLETED.");
		
	}//main

}//class
