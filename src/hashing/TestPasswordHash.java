package hashing;
import hashing.PasswordHash;

import java.util.Arrays;
import java.util.Scanner;
import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;


public class TestPasswordHash {

	//vars
	static Scanner scan = new Scanner(System.in);
	
	
	//helpers
	public static void pl(String str){
		System.out.println(str);
	}
	public static void p(String str){
		System.out.print(str);
	}
	
	//methods
	public static void test(){
		//Collect credentials
				pl("Please Enter your username:");
				String username=scan.nextLine();
				pl("Please Enter your password:");
				String password=scan.nextLine();
				
				
				
				//Generate a Hex Salt
				byte[] salt = PasswordHash.generateSaltPublic();
				pl("\nGenerating a hexidecimal salt [length:"+salt.length+"]:");
				pl("toHex:\t\t"+PasswordHash.toHexPublic(salt));
				//pl("toDec:\t\t"+PasswordHash.toDecPublic(salt));
				//pl("saltToString:\t"+PasswordHash.saltToString(salt));
				
				
				
				//Generating password hash with salt
				pl("\nGenerating a hexidecimal hash of the password \""+password+ "\" and the salt:");
				//pbkdf2
				byte[] hash = null;
				try {
					hash=PasswordHash.pbkdf2Public(password.toCharArray(), salt, PasswordHash.PBKDF2_ITERATIONS, PasswordHash.HASH_BYTE_SIZE); //!@# 24 (the constant "*_BYTE_SIZE" in PasswordHash) for 4th param
				} catch (NoSuchAlgorithmException e) {
					e.printStackTrace();
				} catch (InvalidKeySpecException e) {
					e.printStackTrace();
				} 
				pl("hash:\t"+PasswordHash.toHexPublic(hash));
				
				
				
				//Results:
				pl("\nAttempting to validate the user.");
				String oldHash=PasswordHash.toHexPublic(hash);
				byte[] hash2=null;
				try {
					hash2 = PasswordHash.pbkdf2Public(password.toCharArray(), salt, PasswordHash.PBKDF2_ITERATIONS, PasswordHash.HASH_BYTE_SIZE);
				} catch (NoSuchAlgorithmException e) {	
					e.printStackTrace();
				} catch (InvalidKeySpecException e) {
					e.printStackTrace();
				}
				String newHash = PasswordHash.toHexPublic(hash2);
				
				pl("\tHex Comparison Results:\n"+oldHash+"\n"+newHash);
				pl("Equal?:"+(oldHash.equalsIgnoreCase(newHash)));
				
				pl("\n\tByte[] Comparison Results:\n"+"hashcode:"+hash.hashCode()+"\nhashcode:"+hash2.hashCode());
				pl("Byte[] Equal?:"+(Arrays.equals(hash, hash2)));
				
				
				//TEsting the recovery of byte[] from a hex string
				pl("\nTesting the conversion of byte[] -> hex string -> byte[]:");
				pl("Byte1[]:"+salt.hashCode()+" | "+salt.toString());
				String testHex=PasswordHash.toHexPublic(salt);
				pl("String hEx:"+testHex);
				byte[] testByte=PasswordHash.fromHexPublic(testHex);
				pl("Byte2[]:"+testByte.hashCode()+" | "+testByte.toString());
				pl("salt equals testBytes?:"+(Arrays.equals(salt, testByte)));
				
				pl("\n");
	}//test
	
	
	public static void test2(){
		String _salt="9350a6f663683b6466b82ba5d1f91cc0ad315393e8d85a2f";
		String _hash="e3503c52f1f42b7a6febba4507f4638b8ab307328b6bb2d6";
		pl("Starting test2.");
		pl("_salt: "+_salt);
		pl("_hash: "+ _hash);
		
		//Hash string --> Hash byte[]
		byte[] byteHash=_hash.getBytes();
		String stringHash1=PasswordHash.toHexPublic(byteHash);
		String stringHash2=new String(byteHash); //this is IT!!
		pl("stringHash1: "+stringHash1);
		pl("stringHash2: "+stringHash2); //this is IT!!!
		
		pl("Computing hash:");
		byte[] s=_salt.getBytes();
		byte[] h=null;
		try {
			h=PasswordHash.pbkdf2Public("groot".toCharArray(),s,1000,24);
		} catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		pl("type1(new string): "+new String(h));
		pl("type2(ph.tohex(): "+PasswordHash.toHexPublic(h));
		
		
		
		
		//REMEMBER TO USE SLOW EQUALS
	}//test2
	

	public static void test3(){
		//user hello db answers
		String _salt="dd24541e370af1b397ac39f5307963e42914be543c6ea689";
		String _hash="0909a54dba77c3012a26bc1dbf3b8d5b92b0443547b14c3e";
		
		//compute hash
		byte[] hash = null;
		try {
			hash=PasswordHash.pbkdf2Public("hello".toCharArray(),_salt.getBytes(),PasswordHash.ITERATION_INDEX,PasswordHash.HASH_BYTE_SIZE);
		} catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
			e.printStackTrace();
		}
		
		//TEST PRINT
		String tp=PasswordHash.toHexPublic(hash);
		pl("tp: "+tp);
		
		//compare hashes
		boolean result=false;
		result=PasswordHash.slowEqualsPublic(hash, PasswordHash.fromHexPublic(_hash));		
		pl("slowEquals "+result+".");
		pl("Arr equals "+Arrays.equals(hash, PasswordHash.fromHexPublic(_hash))+".");
		
		//IIIIIIIITTTTTTTTTTTTT    WWWWWWOOOOOOOOOORRRRRRRRRKKKKKKKSSSSSSSSSSSSS!!!!!!!!!
	}//test3
	
	
	
	public static void hexCrypto() throws UnsupportedEncodingException{
		//Collect credentials
		pl("Please Enter the username:");
		String username=scan.nextLine();
		pl("Please Enter the password:");
		String password=scan.nextLine();
		
		//Return String of salt and hash
		byte[] salt=PasswordHash.generateSaltPublic();
		byte[] hash = null;
		try {
			hash=PasswordHash.pbkdf2Public(password.toCharArray(), salt, PasswordHash.PBKDF2_ITERATIONS, PasswordHash.HASH_BYTE_SIZE);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (InvalidKeySpecException e) {
			e.printStackTrace();
		}
		String saltString=PasswordHash.toHexPublic(salt);
		String passwordHashString=PasswordHash.toHexPublic(hash);
		
		
		pl("Here's the salt and hash, respectively:");
		pl(saltString);
		pl(passwordHashString);
		
		pl("\n");
		
	}//crypto
	
	
	//main
	public static void main(String[] args) throws UnsupportedEncodingException {
		 test3();
		
		//test();
		
	}//main

}//class

/* for Byte[] to string
String coolString = "cool string";

byte[] byteArray = coolString.getBytes();

String reconstitutedString = new String(byteArray);

System.out.println(reconstitutedString);
		 */