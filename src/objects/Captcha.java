package objects;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Random;

public class Captcha {

	//Variables
	DataAccessObject dao;
	Connection con=null;
	//Variables
	byte[] imageBytes;
	Integer capid=0;
	
	
	//Constructor
	public Captcha(){
		dao=new DataAccessObject();
		con=dao.getCon();
		//System.out.println("Captcha Object created.");
	}
	
	//METHODS
	/**
	 * Counts and selects a random capid from the database (So long as the capid's continue to start at 1, and increase consecutively). An error is id=0;
	 * @return Integer capid
	 */
	public Integer getRandomCaptchaID(){
		Random rand=new Random();
		Integer count=0;
		try {
			PreparedStatement ps=con.prepareStatement("SELECT COUNT(*) AS count FROM captcha");
			ResultSet rs=ps.executeQuery();
			rs.first();
			count=rs.getInt("count");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		capid=rand.nextInt(count)+1;
		return capid;
	}
	
	
	//fetchImageBytes
	/**
	 * Returns the captcha image as a byte[], given the captcha id
	 * @param imageID
	 * @return
	 */
	public byte[] fetchImageBytes(Integer imageID){
		//contact db for byte[]
		try {
			PreparedStatement ps=con.prepareStatement("SELECT capimg FROM captcha WHERE capid = ?");
			ps.setInt(1, imageID);
			ResultSet rs=ps.executeQuery();
			rs.first();
			imageBytes=rs.getBytes("capimg");
	
			//System.out.println("capid:"+capid+"\nimageBytes.length:"+imageBytes.length); //TEST
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			close();
		}
		return imageBytes;
	}//method
	
	public boolean validateCaptchaAnswer(String userInput, Integer capid){
		
		//contact db for capval
		String capval="";
				try {
					PreparedStatement ps=con.prepareStatement("SELECT capval FROM captcha WHERE capid = ?");
					ps.setInt(1, capid);
					ResultSet rs=ps.executeQuery();
					rs.first();
					capval=rs.getString("capval");
				} catch (SQLException e) {
					e.printStackTrace();
				} finally{
					close();
				}
		
		//compare (case INSENSITIVE)
				if(userInput.equalsIgnoreCase(capval)){
					return true;
				}else{
					return false;
				}
	}
	
	/**
	 * closes connections
	 */
	private void close(){
		try {
			con.close();
		} catch (SQLException e) {
		}
		dao.closeConnection();
	}
	
	//getters
	public Integer getCapId(){
		return capid;
	}
	
	
}//class

/*
 * Assistance from: https://akiraly.github.io/cage/quickstart.html
*/