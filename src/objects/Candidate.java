package objects;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * A java object representing a Candidate in the database
 * @author Barrett Sharpe
 *
 */
public class Candidate implements Serializable {

	//Serializable ID
	private static final long serialVersionUID = 1L;

	//Candidate Variables
	private String cid="";
	private String cFirstName="";
	private String cLastName="";
	private Timestamp dob=Timestamp.valueOf("1000-1-1 00:00:00");
	private Integer cYear=0;
	public Gender gender=Gender.NotDeclared;
	public Degree degree=Degree.None_Of_Above;
	private String cEmail="";
	private String cResumeLink="";
	private String cPhoneNumber="";
	private String cDescription="";
	private String cJobHistory="";
	private Timestamp cDateCreated=Timestamp.valueOf("1000-1-1 00:00:00");
	private Timestamp cDateLastModified=Timestamp.valueOf("1000-1-1 00:00:00");
	
	//Constructors
	public Candidate(){}
	
	public Candidate(String cid){
		this.cid=cid;
		
		//!@#  new java.sql.Date().valueOf(LocalDate.of(year, month, dayOfMonth))
		//LocalDate.parse(String)
	}
	
	
	//Print, formatTimestamp, and Helper Methods
	/**
	 * Helps to form a timestamp. Month from 1-12. Returns null if values are bad
	 * @param year
	 * @param month
	 * @param day
	 * @return Timestamp
	 */
	public static Timestamp formTimestamp(int year, int month, int day){
		
		//check values
		if(year>9999||year<1000){
			return null;
		}
		if(month<1||month>12){
			return null;
		}
		if(day<1||day>31){
			return null;
		}
		
		//String
		String date=String.valueOf(year)+"-"+String.valueOf(month)+"-"+String.valueOf(day)+" 00:00:00";
		
		//TEST
		System.out.println(date);
		
		//timestamp
		Timestamp ts=Timestamp.valueOf(date);
		return ts;
	}
	
	/**
	 * Helps to form a timestamp, with a given string of the date (most likely the oputput of the Candidate.formStringDate() method)
	 * @param stringDate
	 * @return Timestamp
	 */
	public static Timestamp formTimestamp(String stringDate){
		Timestamp ts=Timestamp.valueOf(stringDate+" 00:00:00");
		return ts;
	}
	
	/**
	 * Parses a String, containing the date, from an input Timestamp
	 * @param Timestamp
	 * @return String
	 */
	@SuppressWarnings("deprecation")
	public static String formStringDate(Timestamp t){
		String result="";
		result+=t.getYear()+1900;
		result+="-";
		result+=t.getMonth()+1;
		result+="-";
		result+=t.getDate();
		return result;
	}
	
	public void printToConsole(){
		System.out.println(printoutString(true));
	}
		
	public String printoutString(boolean advancedView){
		String result="";
		if(advancedView){
		//1234567;(M:26)
		//	Last, First Mid
		//		B.Sc ; [email;URL;description]
		//dates
		//	
			
			result+= cid+";"+"("+(gender.toString().substring(0, 1).toUpperCase())+":"+dob.toString()+")"
					+"\n\t"+cLastName+", "+cFirstName
					+"\n\t\t"+degree+"["+cEmail+";"+cResumeLink+";"+cDescription+"]"
					+"\n"+cDateCreated.toString()+"||"+cDateLastModified.toString()+".";
			
//			result+=cid+";"+degree+"("
//					+(gender.toString().substring(0, 1).toUpperCase())
//					+":"+dob.toString()+")"+cLastName+", "+cFirstName
//					+"["+cEmail+";"
//					+cResumeLink+";"+cDescription+"]"
//					+cDateCreated.toString()+"||"+cDateLastModified.toString()+".";
		}else{
		//1234567;B.Sc(M:26)Last, First
			result+=cid+";"+degree.toString()+"("
			+(gender.toString().substring(0, 1).toUpperCase())
			+":"+dob.toString()+")"+cLastName+", "+cFirstName;
		}				
		//return		
		return result;
	}

	
	
	//HashCode and Equals Methods
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((cDateCreated == null) ? 0 : cDateCreated.hashCode());
		result = prime
				* result
				+ ((cDateLastModified == null) ? 0 : cDateLastModified
						.hashCode());
		result = prime * result
				+ ((cDescription == null) ? 0 : cDescription.hashCode());
		result = prime * result + ((cEmail == null) ? 0 : cEmail.hashCode());
		result = prime * result
				+ ((cFirstName == null) ? 0 : cFirstName.hashCode());
		result = prime * result
				+ ((cJobHistory == null) ? 0 : cJobHistory.hashCode());
		result = prime * result
				+ ((cLastName == null) ? 0 : cLastName.hashCode());
		result = prime * result
				+ ((cPhoneNumber == null) ? 0 : cPhoneNumber.hashCode());
		result = prime * result
				+ ((cResumeLink == null) ? 0 : cResumeLink.hashCode());
		result = prime * result + ((cYear == null) ? 0 : cYear.hashCode());
		result = prime * result + ((cid == null) ? 0 : cid.hashCode());
		result = prime * result + ((degree == null) ? 0 : degree.hashCode());
		result = prime * result + ((dob == null) ? 0 : dob.hashCode());
		result = prime * result + ((gender == null) ? 0 : gender.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Candidate other = (Candidate) obj;
		if (cDateCreated == null) {
			if (other.cDateCreated != null)
				return false;
		} else if (!cDateCreated.equals(other.cDateCreated))
			return false;
		if (cDateLastModified == null) {
			if (other.cDateLastModified != null)
				return false;
		} else if (!cDateLastModified.equals(other.cDateLastModified))
			return false;
		if (cDescription == null) {
			if (other.cDescription != null)
				return false;
		} else if (!cDescription.equals(other.cDescription))
			return false;
		if (cEmail == null) {
			if (other.cEmail != null)
				return false;
		} else if (!cEmail.equals(other.cEmail))
			return false;
		if (cFirstName == null) {
			if (other.cFirstName != null)
				return false;
		} else if (!cFirstName.equals(other.cFirstName))
			return false;
		if (cJobHistory == null) {
			if (other.cJobHistory != null)
				return false;
		} else if (!cJobHistory.equals(other.cJobHistory))
			return false;
		if (cLastName == null) {
			if (other.cLastName != null)
				return false;
		} else if (!cLastName.equals(other.cLastName))
			return false;
		if (cPhoneNumber == null) {
			if (other.cPhoneNumber != null)
				return false;
		} else if (!cPhoneNumber.equals(other.cPhoneNumber))
			return false;
		if (cResumeLink == null) {
			if (other.cResumeLink != null)
				return false;
		} else if (!cResumeLink.equals(other.cResumeLink))
			return false;
		if (cYear == null) {
			if (other.cYear != null)
				return false;
		} else if (!cYear.equals(other.cYear))
			return false;
		if (cid == null) {
			if (other.cid != null)
				return false;
		} else if (!cid.equals(other.cid))
			return false;
		if (degree != other.degree)
			return false;
		if (dob == null) {
			if (other.dob != null)
				return false;
		} else if (!dob.equals(other.dob))
			return false;
		if (gender != other.gender)
			return false;
		return true;
	}


	
	//Get and Set Candidate Methods
	
	
	public boolean setCandidate(CanMap map){
		boolean completed=true;
		try{
			setCid(map.get("cid").toString());
			setcFirstName(map.get("cFirstName").toString());
			setcLastName(map.get("cLastName").toString());
			
			if(map.get("dob").toString().equalsIgnoreCase(Timestamp.valueOf("1000-1-1 00:00:00").toString())){
				setDob(Timestamp.valueOf("1000-1-1 00:00:00"));
			}else{
				setDob(Timestamp.valueOf(map.get("dob").toString()));
			}
			
// java.time.LocalDate		
//			if(LocalDate.parse(map.get("dob").toString()).equals(LocalDate.MIN)){ //LocalDate.Min
//				setDob(LocalDate.MIN);
//			}else{
//				setDob(LocalDate.parse(map.get("dob").toString()));
//			}
			
			setcYear((Integer)map.get("cYear"));
			setGender(Gender.valueOf(map.get("gender").toString()));
			setDegree(Degree.valueOf(map.get("degree").toString()));
			setcEmail(map.get("cEmail").toString());
			setcResumeLink(map.get("cResumeLink").toString());
			setcPhoneNumber(map.get("cPhoneNumber").toString());
			setcDescription(map.get("cDescription").toString());
			setcJobHistory(map.get("cJobHistory").toString());	
			
			if(map.get("cDateCreated").toString().equalsIgnoreCase(Timestamp.valueOf("1000-1-1 00:00:00").toString())){
				setcDateCreated(Timestamp.valueOf("1000-1-1 00:00:00"));
			}else{
				setcDateCreated(Timestamp.valueOf(map.get("cDateCreated").toString()));
			}
			if(map.get("cDateLastModified").toString().equalsIgnoreCase(Timestamp.valueOf("1000-1-1 00:00:00").toString())){
				setcDateLastModified(Timestamp.valueOf("1000-1-1 00:00:00"));
			}else{
				setcDateLastModified(Timestamp.valueOf(map.get("cDateLastModified").toString()));
			}
		}catch(Exception x){
			x.printStackTrace();
			completed=false;
		}
		return completed;
	}

	
	public CanMap getCandidate(){
		//String.valueOf( takes care of "null" or "string"
		CanMap c=new CanMap();
		c.put("cid", String.valueOf(getCid()));
		c.put("cFirstName", String.valueOf(getcFirstName()));
		c.put("cLastName", String.valueOf(getcLastName()));
		//c.put("dob", getDob().toString());
		c.put("dob", (getDob()==null)? "1000-1-1 00:00:00" : getDob().toString());
		c.put("cYear",Integer.valueOf(getcYear()));
		c.put("gender",getGender().toString());
		c.put("degree",getDegree().toString());
		c.put("cEmail",String.valueOf(getcEmail()));
		c.put("cResumeLink",String.valueOf(getcResumeLink()));
		c.put("cPhoneNumber",String.valueOf(getcPhoneNumber()));
		c.put("cDescription",String.valueOf(getcDescription()));
		c.put("cJobHistory",String.valueOf(getcJobHistory()));
		c.put("cDateCreated",(getcDateCreated()==null)? "1000-1-1 00:00:00" : getcDateCreated().toString());
		c.put("cDateLastModified",(getcDateLastModified()==null)? "1000-1-1 00:00:00" : getcDateLastModified().toString());
		return c;
	}
	
	//Getters and Setters
	
	
	public String getCid() {
		return cid;
	}

	public void setCid(String cid) {
		this.cid = cid;
	}

	public String getcFirstName() {
		return cFirstName;
	}

	public void setcFirstName(String cFirstName) {
		this.cFirstName = cFirstName;
	}

	public String getcLastName() {
		return cLastName;
	}

	public void setcLastName(String cLastName) {
		this.cLastName = cLastName;
	}

	public Timestamp getDob() {
		return dob;
	}

	public void setDob(Timestamp dob) {
		this.dob = dob;
	}

	public Integer getcYear() {
		return cYear;
	}

	public void setcYear(Integer cYear) {
		this.cYear = cYear;
	}

	public Gender getGender() {
		return gender;
	}

	public void setGender(Gender gender) {
		this.gender = gender;
	}

	public Degree getDegree() {
		return degree;
	}

	public void setDegree(Degree degree) {
		this.degree = degree;
	}

	public String getcEmail() {
		return cEmail;
	}

	public void setcEmail(String cEmail) {
		this.cEmail = cEmail;
	}

	public String getcResumeLink() {
		return cResumeLink;
	}

	public void setcResumeLink(String cResumeLink) {
		this.cResumeLink = cResumeLink;
	}

	public String getcPhoneNumber() {
		return cPhoneNumber;
	}

	public void setcPhoneNumber(String cPhoneNumber) {
		this.cPhoneNumber = cPhoneNumber;
	}

	public String getcDescription() {
		return cDescription;
	}

	public void setcDescription(String cDescription) {
		this.cDescription = cDescription;
	}

	public String getcJobHistory() {
		return cJobHistory;
	}

	public void setcJobHistory(String cJobHistory) {
		this.cJobHistory = cJobHistory;
	}

	public Timestamp getcDateCreated() {
		return cDateCreated;
	}

	public void setcDateCreated(Timestamp cDateCreated) {
		this.cDateCreated = cDateCreated;
	}

	public Timestamp getcDateLastModified() {
		return cDateLastModified;
	}

	public void setcDateLastModified(Timestamp cDateLastModified) {
		this.cDateLastModified = cDateLastModified;
	}



	
	
	
	
	
}//class

/*
 * Article this class is based from: DAO tutorial
 * http://balusc.blogspot.ca/2008/07/dao-tutorial-data-layer.html
 * 
 * Date chaos
 * http://stackoverflow.com/questions/24650186/choosing-between-java-util-date-or-java-sql-date
 * 
 */
