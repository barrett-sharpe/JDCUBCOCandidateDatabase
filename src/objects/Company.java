package objects;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * A java Object representing a Company in the database
 * @author Barrett Sharpe
 *
 */
public class Company implements Serializable{

	//Serializable ID
	private static final long serialVersionUID = 1L;
	
	//Company Variables
	private String coid="";
	private String coName="";
	private Integer coYearEstablished=0;
	private String coEmail="";
	private String coUrl="";
	private String coContactName="";
	private String coAddress="";
	private String coTel="";
	private String coDescription="";
	private String coSocial="";
	private Timestamp coDateCreated=Timestamp.valueOf("1970-01-01 00:00:01");
	private Timestamp coDateLastModified=Timestamp.valueOf("1970-01-01 00:00:01");
	
	//Constructor
	public Company(){}
	
	public Company(String coid){
		this.coid=coid;
	}
	
	
	//Print and Helper Methods
	public void printToConsole(){
		System.out.println(printoutString(true));
	}
	
	public String printoutString(boolean advancedView){
		String result="";
		
		//!@#finish
		if(advancedView){
			result+= coid+";"+"("+coYearEstablished.toString()+") "+coName
					+"\n\t\t"+coEmail+"["+coUrl+";"+coSocial+"]"
					+"\n\t\t"+coContactName+"["+coAddress+";"+coTel+";"+coDescription+"]"
					+"\n"+coDateCreated.toString()+"||"+coDateLastModified.toString()+".";
		}
		
		return result;
	}
	
	
	//Hashcode and Equals Methods
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((coAddress == null) ? 0 : coAddress.hashCode());
		result = prime * result
				+ ((coContactName == null) ? 0 : coContactName.hashCode());
		result = prime * result
				+ ((coDateCreated == null) ? 0 : coDateCreated.hashCode());
		result = prime
				* result
				+ ((coDateLastModified == null) ? 0 : coDateLastModified
						.hashCode());
		result = prime * result
				+ ((coDescription == null) ? 0 : coDescription.hashCode());
		result = prime * result + ((coEmail == null) ? 0 : coEmail.hashCode());
		result = prime * result + ((coName == null) ? 0 : coName.hashCode());
		result = prime * result
				+ ((coSocial == null) ? 0 : coSocial.hashCode());
		result = prime * result + ((coTel == null) ? 0 : coTel.hashCode());
		result = prime * result + ((coUrl == null) ? 0 : coUrl.hashCode());
		result = prime
				* result
				+ ((coYearEstablished == null) ? 0 : coYearEstablished
						.hashCode());
		result = prime * result + ((coid == null) ? 0 : coid.hashCode());
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
		Company other = (Company) obj;
		if (coAddress == null) {
			if (other.coAddress != null)
				return false;
		} else if (!coAddress.equals(other.coAddress))
			return false;
		if (coContactName == null) {
			if (other.coContactName != null)
				return false;
		} else if (!coContactName.equals(other.coContactName))
			return false;
		if (coDateCreated == null) {
			if (other.coDateCreated != null)
				return false;
		} else if (!coDateCreated.equals(other.coDateCreated))
			return false;
		if (coDateLastModified == null) {
			if (other.coDateLastModified != null)
				return false;
		} else if (!coDateLastModified.equals(other.coDateLastModified))
			return false;
		if (coDescription == null) {
			if (other.coDescription != null)
				return false;
		} else if (!coDescription.equals(other.coDescription))
			return false;
		if (coEmail == null) {
			if (other.coEmail != null)
				return false;
		} else if (!coEmail.equals(other.coEmail))
			return false;
		if (coName == null) {
			if (other.coName != null)
				return false;
		} else if (!coName.equals(other.coName))
			return false;
		if (coSocial == null) {
			if (other.coSocial != null)
				return false;
		} else if (!coSocial.equals(other.coSocial))
			return false;
		if (coTel == null) {
			if (other.coTel != null)
				return false;
		} else if (!coTel.equals(other.coTel))
			return false;
		if (coUrl == null) {
			if (other.coUrl != null)
				return false;
		} else if (!coUrl.equals(other.coUrl))
			return false;
		if (coYearEstablished == null) {
			if (other.coYearEstablished != null)
				return false;
		} else if (!coYearEstablished.equals(other.coYearEstablished))
			return false;
		if (coid == null) {
			if (other.coid != null)
				return false;
		} else if (!coid.equals(other.coid))
			return false;
		return true;
	}
	
	
	//Get and Set Company Methods
	
	public boolean setCompany(CoMap map){
		boolean completed=true;
		try{
			setCoid(map.get("coid").toString());
			setCoName(map.get("coName").toString());
			setCoYearEstablished(Integer.valueOf(map.get("coYearEstablished").toString()));
			setCoEmail(map.get("coEmail").toString());
			setCoUrl(map.get("coUrl").toString());
			setCoContactName(map.get("coContactName").toString());
			setCoAddress(map.get("coAddress").toString());
			setCoTel(map.get("coTel").toString());
			setCoDescription(map.get("coDescription").toString());
			setCoSocial(map.get("coSocial").toString());
			if(map.get("coDateCreated").toString().equalsIgnoreCase(Timestamp.valueOf("1970-01-01 00:00:01").toString())){
				setCoDateCreated(Timestamp.valueOf("1970-01-01 00:00:01"));
			}else{
				setCoDateCreated(Timestamp.valueOf(map.get("coDateCreated").toString()));
			}
			if(map.get("coDateLastModified").toString().equalsIgnoreCase(Timestamp.valueOf("1970-01-01 00:00:01").toString())){
				setCoDateLastModified(Timestamp.valueOf("1970-01-01 00:00:01"));
			}else{
				setCoDateLastModified(Timestamp.valueOf(map.get("coDateLastModified").toString()));
			}
		}catch(Exception x){
			x.printStackTrace();
			completed=false;
		}
		return completed;
	}
	
	public CoMap getCompany(){
		CoMap c=new CoMap();
		c.put("coid", String.valueOf(getCoid()));
		c.put("coName", String.valueOf(getCoName()));
		c.put("coYearEstablished", Integer.valueOf(getCoYearEstablished()));
		c.put("coEmail", String.valueOf(getCoEmail()));
		c.put("coUrl", String.valueOf(getCoUrl()));
		c.put("coContactName", String.valueOf(getCoContactName()));
		c.put("coAddress", String.valueOf(getCoAddress()));
		c.put("coTel", String.valueOf(getCoTel()));
		c.put("coDescription", String.valueOf(getCoDescription()));
		c.put("coSocial", String.valueOf(getCoSocial()));
		c.put("coDateCreated", (getCoDateCreated()==null)? "1970-01-01 00:00:01" : getCoDateCreated().toString());
		c.put("coDateLastModified", (getCoDateLastModified()==null)? "1970-01-01 00:00:01" : getCoDateLastModified().toString());
		return c;
	}


	//GETTERS AND SETTERS
	
	
	public String getCoid() {
		return coid;
	}

	public void setCoid(String coid) {
		this.coid = coid;
	}

	public String getCoName() {
		return coName;
	}

	public void setCoName(String coName) {
		this.coName = coName;
	}

	public Integer getCoYearEstablished() {
		return coYearEstablished;
	}

	public void setCoYearEstablished(Integer coYearEstablished) {
		this.coYearEstablished = coYearEstablished;
	}

	public String getCoEmail() {
		return coEmail;
	}

	public void setCoEmail(String coEmail) {
		this.coEmail = coEmail;
	}

	public String getCoUrl() {
		return coUrl;
	}

	public void setCoUrl(String coUrl) {
		this.coUrl = coUrl;
	}

	public String getCoContactName() {
		return coContactName;
	}

	public void setCoContactName(String coContactName) {
		this.coContactName = coContactName;
	}

	public String getCoAddress() {
		return coAddress;
	}

	public void setCoAddress(String coAddress) {
		this.coAddress = coAddress;
	}

	public String getCoTel() {
		return coTel;
	}

	public void setCoTel(String coTel) {
		this.coTel = coTel;
	}

	public String getCoDescription() {
		return coDescription;
	}

	public void setCoDescription(String coDescription) {
		this.coDescription = coDescription;
	}

	public String getCoSocial() {
		return coSocial;
	}

	public void setCoSocial(String coSocial) {
		this.coSocial = coSocial;
	}

	public Timestamp getCoDateCreated() {
		return coDateCreated;
	}

	public void setCoDateCreated(Timestamp coDateCreated) {
		this.coDateCreated = coDateCreated;
	}

	public Timestamp getCoDateLastModified() {
		return coDateLastModified;
	}

	public void setCoDateLastModified(Timestamp coDateLastModified) {
		this.coDateLastModified = coDateLastModified;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
}//class
