package testObjects;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.Map.Entry;
import java.util.Set;

import objects.CoMap;
import objects.UserDAO;

public class testUserDAO {

	public static void main(String[] args) {
		UserDAO ud =new UserDAO();
		int[] attributeIndex=new int[6];
		attributeIndex[0]=0;
		attributeIndex[1]=1;
		attributeIndex[2]=3;
		attributeIndex[3]=4;
		attributeIndex[4]=5;
		attributeIndex[5]=9;
		
		Integer orderByIndex=0;
		Integer startNum=0;
		Integer offset=900000;
		ArrayList<CoMap> result=ud.getCompanyDirectory(attributeIndex, orderByIndex, startNum, offset);
		
		//print
		System.out.println("Size of result="+result.size());
		
		
		CoMap c=result.get(0);
		ArrayList<String> columnNames=new ArrayList<>();
		for(int j: attributeIndex){
			switch(j){
			case 0: //coid
				columnNames.add("coid");
				break;
			case 1:  //coname
				columnNames.add("coname");
				break;
			case 2: //coyearestablished
				columnNames.add("coyearestablished");
				break;
			case 3: //coemail
				columnNames.add("coemail");
				break;
			case 4: //courl
				columnNames.add("courl");
				break;
			case 5:	//cocontactname
				columnNames.add("cocontactname");
				break;
			case 6: //coaddress
				columnNames.add("coaddress");
				break;
			case 7: //cotel
				columnNames.add("cotel");
				break;
			case 8: //codescription
				columnNames.add("codescription");
				break;
			case 9: //cosocial
				columnNames.add("cosocial");
				break;
			default:
				columnNames.add("coid");
				System.err.println("going to default coid. "+j+" not recognized");
				break;
			}//switch
		}
		//print
		System.out.println("Column Names:");
		for(String s: columnNames){
			System.out.print(s+" | ");
		}
		
		
		for(int i=0; i<result.size(); i++){
			System.out.print("\nCoMap #"+i+")___________________________________");
			//System.out.println(result.get(i).toString()); //this works!
			
					
		}
	}

}
