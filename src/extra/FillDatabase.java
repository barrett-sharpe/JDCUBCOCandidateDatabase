package extra;

import objects.Candidate;
import objects.Company;
import objects.DataAccessObject;

public class FillDatabase {

	//Vars
	private static String PASSWORD="password"; //ALL PASSWORDS ARE "password" !!!
	private static Integer NUM_CANDIDATES=5;
	private static Integer NUM_COMPANIES=5;
	
	//Constructor
	public FillDatabase(){}
	
	//Methods
	public static void fill(boolean isCompany, int number){
		DataAccessObject dao=new DataAccessObject();
		Company[] arr=null;
		Candidate[] arr2 = null;
		if(isCompany){
			arr=GeneratorCompany.generateCompanies(number, 100100);
			//for each company
			for(Company c: arr){
				//username:(lowercase/nospaces anywhere)name
				dao.addCredentialsCompany(c.getCoName().toLowerCase().replaceAll(" ", ""), PASSWORD,c.getCoid());
				dao.addCompany(c.getCompany());
			}
		}else{
			arr2=GeneratorCandidate.generateCandidates(number, 1000100);
			//for each candidate
			for(Candidate c: arr2){
				//username:(lowercase)firstlast
				dao.addCredentialsCandidate(c.getcFirstName().toLowerCase()+c.getcLastName().toLowerCase(), PASSWORD,c.getCid());
				dao.addCandidate(c.getCandidate());
			}
		}
		
		//Printout
		if(!isCompany){
			System.out.println("\n\nCandidates: ("+arr2.length+"/"+NUM_CANDIDATES+")");
			for(Candidate c: arr2){
				System.out.println(c.getcFirstName()+" "+c.getcLastName()+": "+c.getCid());
			}
		}else{
			System.out.println("\n\nCompanies: ("+arr.length+"/"+NUM_COMPANIES+")");
			for(Company c:arr){
				System.out.println(c.getCoName()+ ": "+c.getCoid());
			}
		}
	}//fill
	
	
	
	//main
	public static void main(String[] args) {
		FillDatabase.fill(true,NUM_COMPANIES);
		FillDatabase.fill(false,NUM_CANDIDATES);
	}//main

}//class
