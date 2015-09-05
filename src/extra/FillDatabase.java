package extra;

import java.util.Random;

import objects.Candidate;
import objects.Company;
import objects.DataAccessObject;

public class FillDatabase {

	//Vars
	private static String PASSWORD="password"; //ALL PASSWORDS ARE "password" !!!
	private static String RECOVERY="forgot"; //ALL RECOVERYSTRINGS ARE "forgot" !!!
	private static Integer NUM_CANDIDATES=1;
	private static Integer NUM_COMPANIES=1;
	public static DataAccessObject dao2=new DataAccessObject();
	
	//Constructor
	public FillDatabase(){}
	
	//Methods
	public static void fill(boolean isCompany, int number){
		DataAccessObject dao=new DataAccessObject();
		Company[] arr=null;
		Candidate[] arr2 = null;
		Random rand=new Random();
		Integer count=number;
		if(isCompany){
			arr=GeneratorCompany.generateCompanies(number, dao.nextAvailableCOID());
			//for each company
			for(Company c: arr){
				//username:(lowercase/nospaces anywhere)name+[random number 0-99]
				dao.addCredentialsCompany(c.getCoName().toLowerCase().replaceAll(" ", "")+(rand.nextInt(100)), PASSWORD, RECOVERY, c.getCoid());
				if(!dao.addCompany(c.getCompany())){
					count--;
				}
			}
		}else{
			arr2=GeneratorCandidate.generateCandidates(number, dao.nextAvailableCID());
			//for each candidate
			for(Candidate c: arr2){
				//username:(lowercase)firstlast+[random number 0-999]
				dao.addCredentialsCandidate(c.getcFirstName().toLowerCase()+c.getcLastName().toLowerCase()+(rand.nextInt(1000)), PASSWORD, RECOVERY, c.getCid());
				if(!dao.addCandidate(c.getCandidate())){
					count--;
				}
			}
		}
		
		//Printout
		if(!isCompany){
			System.out.println("\n\nCandidates: ("+count+"/"+arr2.length+")");
			for(Candidate c: arr2){
				System.out.println(c.getcFirstName()+" "+c.getcLastName()+": "+c.getCid());
			}
		}else{
			System.out.println("\n\nCompanies: ("+count+"/"+arr.length+")");
			for(Company c:arr){
				System.out.println(c.getCoName()+ ": "+c.getCoid());
			}
		}
	}//fill
	
	
	
	//main
	public static void main(String[] args) {
		FillDatabase.fill(true,NUM_COMPANIES);
		FillDatabase.fill(false,NUM_CANDIDATES);
		//System.out.println(dao2.nextAvailableCID());
		//System.out.println(dao2.nextAvailableCOID());
	}//main

}//class
