package objects;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

public class CanMap implements Map<String, java.lang.Object>{

	//Vars
	private HashMap<String, java.lang.Object> map=new HashMap<String, Object>(14);
	
	//Constructor
	public CanMap(){
		initalizeCanMap();
	}
	
	
	//Helpers
	private void initalizeCanMap(){
		//set of Candidate attributes
		map.put("cid",null);
		map.put("cFirstName",null);
		map.put("cLastName", null);
		map.put("dob", null);  //should be put back as a timestamp
		map.put("cYear", null);
		map.put("gender", null);
		map.put("degree", null);
		map.put("cEmail", null);
		map.put("cResumeLink", null);
		map.put("cPhoneNumber", null);
		map.put("cDescription", null);
		map.put("cJobHistory", null);
		map.put("cDateCreated", null);
		map.put("cDateLastModified", null);
	}

	//Custom toString
	@Override
	public String toString(){
		String result="";
		result+="\n"+(String)map.get("cid");
		result+="\n"+(String)map.get("cFirstName");
		result+="\n"+(String)map.get("cLastName");
		result+="\n"+(String)map.get("dob");
		result+="\n"+(String)map.get("cYear");
		result+="\n"+(String)map.get("gender");
		result+="\n"+(String)map.get("degree");
		result+="\n"+(String)map.get("cEmail");
		result+="\n"+(String)map.get("cResumeLink");
		result+="\n"+(String)map.get("cPhoneNumber");
		result+="\n"+(String)map.get("cDescription");
		result+="\n"+(String)map.get("cJobHistory");
		result+="\n"+(String)map.get("cDateCreated");
		result+="\n"+(String)map.get("cDateLastModified");
		return result;
	}
	
	//HashMap Methods
	
	@Override
	public void clear() {
		map.clear();	
	}


	@Override
	public boolean containsKey(Object key) {
		return map.containsKey(key);
	}


	@Override
	public boolean containsValue(Object value) {
		return map.containsValue(value);
	}


	@Override
	public Set<java.util.Map.Entry<String, Object>> entrySet() {
		return map.entrySet();
	}


	@Override
	public Object get(Object key) {
		return map.get(key);
	}


	@Override
	public boolean isEmpty() {
		return map.isEmpty();
	}


	@Override
	public Set<String> keySet() {
		return map.keySet();
	}


	@Override
	public Object put(String key, Object value) {
		return map.put(key, value);
	}

	@Override
	public Object putIfAbsent(String key,Object value){
		return map.putIfAbsent(key, value);
	}
	
	@Override
	public void putAll(Map<? extends String, ? extends Object> m) {
		map.putAll(m);
	}


	@Override
	public Object remove(Object key) {
		return map.remove(key);
	}


	@Override
	public int size() {
		return map.size();
	}


	@Override
	public Collection<Object> values() {
		return map.values();
	}

	//getters setters
	
}//class
