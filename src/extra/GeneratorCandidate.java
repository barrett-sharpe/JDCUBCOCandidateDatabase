package extra;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Random;
import objects.Candidate;
import objects.Degree;
import objects.Gender;

public class GeneratorCandidate {

	private static String[] first={"Ava","Bill","Charles","Devon","Earl","Franz","George","Hailey","Ingrid","James","Kenny", "Liam","Max","Noah","Oliver","Peter","Questlove","Riccardo","Steve","Tom","Ursila","Victoria","Wesley","Xian","Yan","Zander"};
	private static String[] last={"Monaling", "Nelson", "Onigion", "Peterson", "Qailson", "Reeves", "Sharp", "Timmins", "Ulysses", "Victoria", "Welderson", "Xianping", "Yelnatz", "Zoddercalf", "Alberts", "Brown", "Charlston", "Defo", "Ethan", "Fletcher"};
	
	public GeneratorCandidate(){
		
	}
	
	public static Candidate[] generateCandidates(int numCandidates){
		return generateCandidates(numCandidates, 1000000);
	}
	
	public static Candidate[] generateCandidates(int numCandidates, Integer sequentialCIDstart){
		Candidate[] arr=new Candidate[numCandidates];
		Random random=new Random();
		
		for(int i=0;i<numCandidates;i++){
			Integer cid=sequentialCIDstart+i;
			Candidate c=new Candidate(cid.toString());
			
			c.setcFirstName(first[random.nextInt(first.length)]);
			c.setcLastName(last[random.nextInt(last.length)]);
			//c.setDob(LocalDate.of(random.nextInt(40)+1970, random.nextInt(11)+1, random.nextInt(28)+1)); //original
			//c.setDob(Timestamp.valueOf(LocalDateTime.now())); //works as well
			c.setDob(Timestamp.valueOf(LocalDateTime.of(random.nextInt(40)+1970, random.nextInt(11)+1, random.nextInt(27)+1, random.nextInt(24), random.nextInt(60), random.nextInt(60))));
			c.setcYear(random.nextInt(40)+1980);
			c.setGender((random.nextBoolean()==true)? Gender.Male : Gender.Female);
			c.setDegree((random.nextBoolean()==true)? Degree.Bachelors_Of_Management_Accounting : Degree.Masters_Of_Arts);
			c.setcEmail(c.getcLastName()+"_"+c.getcFirstName()+random.nextInt(10)+"@email.com");
			c.setcResumeLink("http://www."+c.getcLastName()+"_"+c.getcFirstName()+random.nextInt(10)+"email.com");
			c.setcPhoneNumber((random.nextInt(900000000)+100000000)+"");
			c.setcDescription("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vitae ex mattis, convallis velit vel, volutpat ex. Nulla egestas lorem quis ullamcorper semper. Curabitur feugiat ligula non nisi elementum hendrerit. Fusce ut tortor ut sapien sollicitudin volutpat eu vitae tellus. Mauris non diam eget nisl luctus pretium. Nulla rutrum congue venenatis. Vivamus vitae maximus enim. Donec venenatis at turpis sit amet aliquet. Sed in sapien rutrum quam maximus molestie. Aliquam erat volutpat.Quisque nunc ante, commodo in cursus in, euismod ut magna. Vivamus ut leo eget diam malesuada luctus ac non nisi. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi efficitur lacinia nunc, non vestibulum velit bibendum vel. Fusce at orci sagittis, blandit augue in, iaculis nulla. Cras elementum varius quam, quis blandit ante faucibus nec. Integer ac diam in leo venenatis tincidunt. Aenean malesuada rhoncus quam, eu rhoncus enim condimentum dignissim. In finibus eros vel orci sag");
			c.setcJobHistory("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vitae ex mattis, convallis velit vel, volutpat ex. Nulla egestas lorem quis ullamcorper semper. Curabitur feugiat ligula non nisi elementum hendrerit. Fusce ut tortor ut sapien sollicitudin volutpat eu vitae tellus. Mauris non diam eget nisl luctus pretium. Nulla rutrum congue venenatis. Vivamus vitae maximus enim. Donec venenatis at turpis sit amet aliquet. Sed in sapien rutrum quam maximus molestie. Aliquam erat volutpat.Quisque nunc ante, commodo in cursus in, euismod ut magna. Vivamus ut leo eget diam malesuada luctus ac non nisi. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi efficitur lacinia nunc, non vestibulum velit bibendum vel. Fusce at orci sagittis, blandit augue in, iaculis nulla. Cras elementum varius quam, quis blandit ante faucibus nec. Integer ac diam in leo venenatis tincidunt. Aenean malesuada rhoncus quam, eu rhoncus enim condimentum dignissim. In finibus eros vel orci sag");
			Timestamp ts=Timestamp.valueOf(LocalDateTime.of(random.nextInt(40)+1970, random.nextInt(11)+1, random.nextInt(27)+1, random.nextInt(24), random.nextInt(60), random.nextInt(60)));
			c.setcDateCreated(ts);
			c.setcDateLastModified(ts);
			//add
			arr[i]=c;
		}//for
		
		return arr;
	}
	
	
}//class
