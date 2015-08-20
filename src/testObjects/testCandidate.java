package testObjects;



import extra.GeneratorCandidate;
import objects.*;

public class testCandidate {

	public static void main(String[] args) {
		//random gen
		Candidate[] arr=GeneratorCandidate.generateCandidates(2);
		for(Candidate c:arr){
			c.printToConsole();
			System.out.println("________________________________________________");
		}
		
		//copy Candidate
		System.out.println("################################################");
		System.out.println("Copying Candidates:");
		Candidate[] arr2=new Candidate[arr.length];
		for(int i=0;i<arr.length;i++){
			Candidate c=new Candidate();
			c.setCandidate(arr[i].getCandidate());
			arr2[i]=c;
		}
		for(Candidate c: arr2){
			System.out.println("________________________________________________");
			c.printToConsole();
		}
		
	}//main

}
