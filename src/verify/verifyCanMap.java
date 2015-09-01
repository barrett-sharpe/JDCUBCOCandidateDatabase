package verify;

import java.sql.Timestamp;
import java.util.ArrayList;

import objects.CanMap;
import objects.Degree;
import objects.Gender;

public class verifyCanMap {

	public static void VerifiyCanMap(){
		
	}

	/**
	 * Used to verify that information inside the CanMap is syntaxically valid, and able to be added to the database.
	 * @param CanMap can
	 * @return ArrayList<String> problems
	 */
	public static ArrayList<String> verify(CanMap can){
		//List of problems to return
		ArrayList<String> problems=new ArrayList<>();
		//Unacceptable Characters Array
		Character[] unacceptable=new Character[]{'-','!','@','#','$','%','^','&','*','(',')','_','+','=','{','}',':',';','\\','"','?','<','>',',','.','|'};
		
		// 1) CID
		
		//not an number
		try{
			Integer cid=Integer.parseInt((String)can.get("cid"));	
			//length
			if(cid<1000000||cid>9999999){
				problems.add("The Candidate ID ('cid') entered is invalid. Must be an integer between 1000000 and 9999999.");
			}	
		}catch(NumberFormatException n){
			problems.add("The Candidate ID ('cid') entered is invalid. Must be an integer.");
		}
		
		// 2) CFIRSTNAME (varchar30)
		String cfirstname=(String)can.get("cFirstName");
		
		//null or empty
		if(cfirstname==null){
			problems.add("The First Name provided is invalid. A first name must be given and cannot be left null.");
		}else if(cfirstname.isEmpty()){
			problems.add("The First Name provided is invalid. A first name must be given, and the field may not be left empty.");
		}else{		
			//>30 chars
			if(cfirstname.length()>30){
				problems.add("The First Name provided is invalid. A first name may only be up to 30 characters long. Consider shortening your first name (of "+cfirstname.length()+" characters) down to a nickname, or unique subset of your name."); 
			}
			//unacceptable characters
			for(Character c: unacceptable){
				if(cfirstname.contains(c.toString())){
					problems.add("The First Name provided is invalid. A first name can not contain '"+c+"', or any of the following symbols: !@#$%^&*()_+={}:;\"?<>,.|");
				}
			}
		}
		// 3) CLASTNAME (varchar30)
		String clastname=(String)can.get("cLastName");
				
		//null or empty
		if(clastname==null){
			problems.add("The Last Name provided is invalid. A last name must be given and may not be null.");
		}else if(clastname.isEmpty()){
			problems.add("The Last Name provided is invalid. A last name must be given, and the field may not be left empty.");
		}else{
			//>30 chars
			if(clastname.length()>30){
				problems.add("The Last Name provided is invalid. A last name may only be up to 30 characters long. Consider shortening your last name (of "+clastname.length()+" characters) down to the first 30 letters of your last name. In your case, '"+clastname.substring(0,30)+"'."); 
			}
			//unacceptable characters
					for(Character c: unacceptable){
						if(clastname.contains(c.toString())){
							problems.add("The Last Name provided is invalid. A last name can not contain '"+c+"', or any of the following symbols: !@#$%^&*()_+={}:;\"?<>,.|");
						}
					}
		}
		// 4) DOB (DATE OF BIRTH; yyyy-mm-dd)
		
		//variables
		//String dobString=(String)can.get("dob"); //remote pointed to this line. Unhappy with cast: timestamp cant cast to string
		Timestamp ts=(Timestamp) can.get("dob");
		String dobString=ts.toString();
		String[] arr=dobString.split("-", 3); //!@# ?3 necessary
		
		//TEST //!@#
//		for(String a: arr){
//			//System.out.println("arr: '"+a+"'");
//		}
		
		boolean valid=true;
		
		for(int i=0;i<3;i++){
			String unit="";
			Integer min = null;
			Integer max = null;
			//choose y,m,d
			switch(i){
				case 0:
					unit="year";
					min=1900;
					max=2015; //!@# //hardcodedYear
					break;
				case 1:
					unit="month";
					min=1;
					max=12;
					break;
				case 2:
					unit="day";
					min=1;
					max=31;
					break;
			}
			//CHECK integer
			try{
				Integer val=Integer.parseInt(arr[i]);
		
				//CHECK bounded values
				if(val<min||val>max){
					problems.add("The Date of Birth provided is invalid. The value of '"+val+"' for "+unit+" is outside of its bounds, from '"+min+"' to '"+max+"'.");
					valid=false;//!@# ? testing this
				}
			}catch(NumberFormatException n){
				problems.add("The Date of Birth provided is invalid. The value \""+arr[i]+"\" for "+unit+" must be an integer.");
				valid=false;
			}catch(ArrayIndexOutOfBoundsException n){
				problems.add("The Date of Birth provided is invalid. A value must be provided for the "+unit+".");
				valid=false;
			}
		}//for
		
		if(valid){
		//CHECK now > dateOfBirth
			
			//!@#Ignoring the now !> dateOfBirth issue for the moment. See "//hardcodedYear" above
			
//		LocalDate givenDOB=LocalDate.of(Integer.parseInt(arr[0]), Integer.parseInt(arr[1]), Integer.parseInt(arr[2]));
//			if(givenDOB.isAfter(now)){
//				problems.add("The Date of Birth provided is invalid. It defines a date that hasn't occured yet ("+givenDOB.toString()+" [yyyy-mm-dd]).");
//			}
	
		}	
		
		
		// 5) CYEAR (of study) (yyyy)  //!@# later remove all invalid characters
		
		String cyearString=null;
		cyearString=(String)can.get("cYear");
		
		
		if(cyearString==null){
			problems.add("The Year of Study provided is invalid. The year field information is required (in 'yyyy' form), and can not be null.");
		}else if(cyearString.isEmpty()){
			problems.add("The Year of Study provided is invalid. The year field information is required (in 'yyyy' form), and can not be empty.");
		}else{
			try{
				//CHECK Integer
				Integer cyear=Integer.parseInt(cyearString);
			}catch(NumberFormatException n){
				problems.add("The Year of Study provided is invalid. The year can only contain numbers (in 'yyyy' form).");
			}
		}
		
	
		// 6) GENDER 
		
		String gender=(String)can.get("gender");
		//change "null" to none of the above
		if(gender==null){
			problems.add("The gender provided is invalid. Null gender should be represented as NotDeclared.");
		}else{
			//"null" to None_Of_Above
			if(gender.equalsIgnoreCase("null")){
				gender="NotDeclared";
			}
			//Check Gender enums
			Boolean genValid=false;
			for (Gender g : Gender.values()) {
				if(gender.equalsIgnoreCase(g.toString())){
					genValid=true;
					break;
				}
			}
			if(!genValid){
				problems.add("The Gender provided is invalid. Please select one of the gender options from the drop down list.");
			}	
		}
		
		
//		String gender=(String)can.get("gender");
//		//CHECK for enum value
//		if(gender.equalsIgnoreCase("Male")||
//				gender.equalsIgnoreCase("Female")||
//				gender.equalsIgnoreCase("Transgendered")||
//				gender.equalsIgnoreCase("Other")||
//				gender.equalsIgnoreCase("NotDeclared")){
//		}else{
//			problems.add("The Gender provided is invalid. Please select one of the gender options from the drop down list.");
//		}
		
		// 7) DEGREE
		
		String degree=(String)can.get("degree");
		//change "null" to none of the above
		if(degree==null){
			problems.add("The Degree provided is invalid. You can't get a degree in null! Please select a degree listed in the drop down box.");
		}else{
			//"null" to None_Of_Above
			if(degree.equalsIgnoreCase("null")){
				degree="None_Of_Above";
			}
			//Check Degree enums
			Boolean degValid=false;
			for (Degree d : Degree.values()) {
				if(degree.equalsIgnoreCase(d.toString())){
					degValid=true;
					break;
				}
			}
			if(!degValid){
				problems.add("The Degree provided is invalid. \""+degree+"\" is not a vaild degree. Please select a degree listed in the drop down box.");
			}
		}
		
		// 8) CEMAIL
		
		String cemail=(String)can.get("cEmail");
		
		//CHECK length
		if(cemail.length()>100){
			problems.add("The Email Address given is invalid. Email addresses must be less than 100 characters in length. ("+cemail.length()+"/100).");
		}
		
		// 9) CRESUMELINK
		
		String cresumelink=(String)can.get("cResumeLink");
		
		//CHECK length
		if(cresumelink.length()>400){
			problems.add("The Resume Link provided is invalid. Maximim length of ("+cresumelink.length()+"/400) characters");
		}
		
		
		// 10) CPHONENUMBER //!@#later, remove all invalid chars
		
		String cphonenumberString=(String)can.get("cPhoneNumber");
		
		
		//check null
		if(cphonenumberString==null){
			problems.add("The Phone Number provided is invalid. A Phone Number is required, and can not be null.");
		}else if(cphonenumberString.isEmpty()){
			problems.add("The Phone Number provided is invalid. A Phone Number is required, and can not be left empty.");
		}else{
			//remove all symbols
			for(Character c: unacceptable){
				if(cphonenumberString.contains(c.toString())){
					cphonenumberString=cphonenumberString.replace(c.toString(),"");
				}
			}
			//TEST System.out.println("cphonenumber looks like this: "+cphonenumberString);
			
			//SKIPPING INTEGER CHECK
			
//			//CHECK integer
//			try{
//				Integer ph=Integer.parseInt(cphonenumberString);
//			}catch(NumberFormatException n){
//				problems.add("The Phone Number provided is invalid. Phone Number must be an integer.");
//			}
			
			
			//Length check
			if(cphonenumberString.length()>20){
				problems.add("The Phone Number provided is invalid. A Phone Number can only be 20 characters long, not "+cphonenumberString.length()+".");
			}
		}
			
		
		
		// 11) CDESCRIPTION
		
		String cdescription=(String)can.get("cDescription");
		//CHECK length
		if(cdescription.length()>1000){
			problems.add("The Biography provided is invalid. Biography may only be 1000 characters in length. ("+cdescription.length()+"/1000).");
		}
		
		// 12) CJOBHISTORY
		
		String cjobhistory=(String)can.get("cJobHistory");
		//CHECK length
		if(cjobhistory.length()>1000){
			problems.add("The Job History provided is invalid. Job History may only be 1000 character in length. ("+cjobhistory.length()+"/1000).");
		}
		
		
		/*
	user.put("degree", request.getParameter("area"));
	
		 */
		
		
		
		
		return problems;
	}
	
}//class
