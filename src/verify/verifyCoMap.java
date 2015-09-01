package verify;

import java.util.ArrayList;

import objects.CoMap;


public class verifyCoMap {

	public static void VerifiyCoMap(){
		
	}

	/**
	 * Used to verify that information inside the CoMap is syntaxically valid, and able to be added to the database.
	 * @param CoMap can
	 * @return ArrayList<String> problems
	 */
	public static ArrayList<String> verify(CoMap can){
		//List of problems to return
		ArrayList<String> problems=new ArrayList<>();
		//Unacceptable Characters Array
		Character[] unacceptable=new Character[]{'-','!','@','#','$','%','^','&','*','(',')','_','+','=','{','}',':',';','\\','"','?','<','>',',','.','|'};
		
		// 1) COID
		
		//not an number
		try{
			Integer coid=Integer.parseInt((String)can.get("coid"));	
			//length
			if(coid<100000||coid>999999){
				problems.add("The Company ID ('coid') entered is invalid. Must be an integer between 100000 and 999999.");
			}	
		}catch(NumberFormatException n){
			problems.add("The Company ID ('coid') entered is invalid. Must be an integer.");
		}
		
		// 2) CONAME (varchar 50)
		String coname=(String)can.get("coName");
		
		//null or empty
		if(coname==null){
			problems.add("The Company Name provided is invalid. A company name must be given and cannot be left null.");
		}else if(coname.isEmpty()){
			problems.add("The Company Name provided is invalid. A company name must be given, and the field may not be left empty.");
		}else{		
			//>50 chars
			if(coname.length()>50){
				problems.add("The Company Name provided is invalid. A company name may only be up to 50 characters long. Consider using a unique shorthand for your company's name (of "+coname.length()+" characters)."); 
			}
			//SKIPPING UNACCEPTABLE CHARACTERS
			
//			//unacceptable characters
//			for(Character c: unacceptable){
//				if(coname.contains(c.toString())){
//					problems.add("The Company Name provided is invalid. A company name can not contain '"+c+"', or any of the following symbols: !@#$%^&*()_+={}:;\"?<>,.|");
//				}
//			}
		}
		
		// 3) COYEARESTABLISHED (yyyy)
		
				String coyearestablished=null;
				coyearestablished=(String)can.get("coYearEstablished");
				
				
				if(coyearestablished==null){
					problems.add("The Company's Established Year provided is invalid. The year field information is required (in 'yyyy' form, ex. '2000'), and can not be null.");
				}else if(coyearestablished.isEmpty()){
					problems.add("The Company's Established Year provided is invalid. The year field information is required (in 'yyyy' form, ex. '2000'), and can not be empty.");
				}else{
					try{
						//CHECK Integer
						Integer cyear=Integer.parseInt(coyearestablished);
					}catch(NumberFormatException n){
						problems.add("The Company's Established Year provided is invalid. The year can only contain numbers (in 'yyyy' form, ex. '2000').");
					}
				}
		
		// 4) COEMAIL
		
		String coemail=(String)can.get("coEmail");
		//CHECK length
		if(coemail.length()>100){
			problems.add("The Company Email Address given is invalid. Email addresses must be less than 100 characters in length. ("+coemail.length()+"/100).");
		}		
				
		// 5) COURL
		
		String courl=(String)can.get("coUrl");
		//CHECK length
		if(courl.length()>400){
			problems.add("The Company Website Link provided is invalid. Maximim length of 400 characters allowed. ("+courl.length()+"/400). Consider using 'https://goo.gl/' to shorten the URL.");
		}		
		
		
		// 6) COCONTACTNAME
		
		String cocontactname=(String)can.get("coContactName");
		//CHECK length
		if(cocontactname.length()>100){
			problems.add("The Company Email Address given is invalid. Email addresses must be less than 100 characters in length. ("+cocontactname.length()+"/100).");
		}
		
		// 7) COADDRESS
		
		String coaddress=(String)can.get("coAddress");
		//CHECK length
		if(coaddress.length()>200){
			problems.add("The Company Address given is invalid. Addresses must be less than 200 characters in length. ("+coaddress.length()+"/200).");
		}
		
		// 8) COTEL
		
		String cotelString=(String)can.get("coTel");
					
		//check null
		if(cotelString==null){
			problems.add("The Company Telephone Number provided is invalid. A number is required, and can not be null.");
		}else if(cotelString.isEmpty()){
			problems.add("The Company Telephone Number provided is invalid. A number is required, and can not be left empty.");
		}else{
			//remove all symbols
			for(Character c: unacceptable){
				if(cotelString.contains(c.toString())){
					cotelString=cotelString.replace(c.toString(),"");
				}
			}
			//TEST System.out.println("cphonenumber looks like this: "+cphonenumberString);
			
			//SKIPPING INTEGER CHECK
//			//CHECK integer
//					try{
//						Integer ph=Integer.parseInt(cphonenumberString);
//					}catch(NumberFormatException n){
//						problems.add("The Phone Number provided is invalid. Phone Number must be an integer.");
//					}		
			//Length check
			if(cotelString.length()>20){
				problems.add("The Company Telephone Number provided is invalid. A Company Telephone Number can only be 20 characters long, not "+cotelString.length()+".");
			}
		}
		
		
		// 9) CODESCRIPTION
		
		String codescription=(String)can.get("coDescription");
		//CHECK length
		if(codescription.length()>1000){
			problems.add("The Company Description given is invalid. The description must be less than 1000 characters in length. ("+codescription.length()+"/1000).");
		}		
				
		// 10) COSOCIAL
		
		String cosocial=(String)can.get("coSocial");
		//CHECK length
		if(cosocial.length()>200){
			problems.add("The Company Social Link provided is invalid. Maximim length of 200 characters allowed. ("+cosocial.length()+"/200). Consider using 'https://goo.gl/' to shorten the URL.");
		}
		
		//METHOD RETURN
		return problems;
	}
	
}//class
