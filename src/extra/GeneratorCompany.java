package extra;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Random;

import objects.Candidate;
import objects.Company;
import objects.Degree;
import objects.Gender;

public class GeneratorCompany {

	private static String[] first={"Associated","Business","Crown","Dynamic","Eastern","Financial","Global","Hub","International","Johnson","Korgidson", "Logistic", "Material", "Non-Linear", "Oil and Gas", "Prosperious", "Quality", "Resources", "Static"};
	private static String[] last={"Mutual LLC", "National LLC", "Organizations Ltd", "Prosperity Ltd", "Qualities Co", "Representatives LLC", "Solutions Co", "Synergies Ltd", "Total Ltd", "Ultra Products", "Viabilities Co", "Weather Ltd", "XXX", "Yearly", "Zygotics"};
	private static String[] first2={"Ava","Bill","Charles","Devon","Earl","Franz","George","Hailey","Ingrid","James","Kenny", "Liam","Max","Noah","Oliver","Peter","Questlove","Riccardo","Steve","Tom","Ursila","Victoria","Wesley","Xian","Yan","Zander"};
	private static String[] last2={"Monaling", "Nelson", "Onigion", "Peterson", "Qailson", "Reeves", "Sharp", "Timmins", "Ulysses", "Victoria", "Welderson", "Xianping", "Yelnatz", "Zoddercalf", "Alberts", "Brown", "Charlston", "Defo", "Ethan", "Fletcher"};
	
	public GeneratorCompany(){
		
	}
	
	public static Company[] generateCompanies(int numCompanies){
		return generateCompanies(numCompanies, 100000);
	}
	
	public static Company[] generateCompanies(int numCompanies, Integer startCOID){
		Company[] arr=new Company[numCompanies];
		
		for(int i=0;i<numCompanies;i++){
			Integer coid=startCOID+i;
			Company c=new Company(coid.toString());
			Random random=new Random();
			c.setCoName(first[random.nextInt(first.length)]+" "+(last[random.nextInt(last.length)]));
			c.setCoYearEstablished(random.nextInt(40)+1980);
			c.setCoEmail(c.getCoName()+"_"+random.nextInt(10)+"@email.com");
			c.setCoUrl("http://www."+c.getCoEmail());
			c.setCoContactName(first2[random.nextInt(first2.length)]+" "+(last2[random.nextInt(last2.length)]));
			c.setCoAddress("1234 Anywhere Street\nCity, Province\nPostal Code");
			c.setCoTel((random.nextInt(900000000)+100000000)+"");
			c.setCoDescription("blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah");
			c.setCoSocial(c.getCoUrl());
			c.setCoDateCreated(Timestamp.valueOf(LocalDateTime.of(random.nextInt(40)+1970, random.nextInt(11)+1, random.nextInt(27)+1, random.nextInt(24), random.nextInt(60), random.nextInt(60))));
			c.setCoDateLastModified(Timestamp.valueOf(LocalDateTime.of(random.nextInt(40)+1970, random.nextInt(11)+1, random.nextInt(27)+1, random.nextInt(24), random.nextInt(60), random.nextInt(60))));
			//add
			arr[i]=c;
		}		
		return arr;
	}
	
}//class
