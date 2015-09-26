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
		Random random=new Random();
		
		for(int i=0;i<numCompanies;i++){
			Integer coid=startCOID+i;
			Company c=new Company(coid.toString());
			c.setCoName(first[random.nextInt(first.length)]+" "+(last[random.nextInt(last.length)]));
			c.setCoYearEstablished(random.nextInt(40)+1980);
			c.setCoEmail(c.getCoName()+"_"+random.nextInt(10)+"@email.com");
			c.setCoUrl("http://www."+c.getCoEmail());
			c.setCoContactName(first2[random.nextInt(first2.length)]+" "+(last2[random.nextInt(last2.length)]));
			c.setCoAddress("1234 Anywhere Street\nCity, Province\nPostal Code");
			c.setCoTel((random.nextInt(900000000)+100000000)+"");
			c.setCoDescription("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vitae ex mattis, convallis velit vel, volutpat ex. Nulla egestas lorem quis ullamcorper semper. Curabitur feugiat ligula non nisi elementum hendrerit. Fusce ut tortor ut sapien sollicitudin volutpat eu vitae tellus. Mauris non diam eget nisl luctus pretium. Nulla rutrum congue venenatis. Vivamus vitae maximus enim. Donec venenatis at turpis sit amet aliquet. Sed in sapien rutrum quam maximus molestie. Aliquam erat volutpat.Quisque nunc ante, commodo in cursus in, euismod ut magna. Vivamus ut leo eget diam malesuada luctus ac non nisi. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi efficitur lacinia nunc, non vestibulum velit bibendum vel. Fusce at orci sagittis, blandit augue in, iaculis nulla. Cras elementum varius quam, quis blandit ante faucibus nec. Integer ac diam in leo venenatis tincidunt. Aenean malesuada rhoncus quam, eu rhoncus enim condimentum dignissim. In finibus eros vel orci sag");
			c.setCoSocial(c.getCoUrl());
			Timestamp ts=Timestamp.valueOf(LocalDateTime.of(random.nextInt(40)+1970, random.nextInt(11)+1, random.nextInt(27)+1, random.nextInt(24), random.nextInt(60), random.nextInt(60)));
			c.setCoDateCreated(ts);
			c.setCoDateLastModified(ts);
			//add
			arr[i]=c;
		}		
		return arr;
	}
	
}//class
