package objects;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

public class CoMap implements Map<String, java.lang.Object>{

	//Vars
	private HashMap<String, java.lang.Object> map=new HashMap<String, Object>(12);
	
	//Constructor
	public CoMap(){
		initalizeCoMap();
	}
	
	
	//Helpers
	private void initalizeCoMap(){
		//set of Candidate attributes
		map.put("coid",null);
		map.put("coName", null);
		map.put("coYearEstablished", null);
		map.put("coEmail", null);
		map.put("coUrl", null);
		map.put("coContactName", null);
		map.put("coAddress", null);
		map.put("coTel", null);
		map.put("coDescription", null);
		map.put("coSocial", null);
		map.put("coDateCreated", null);
		map.put("coDateLastModified", null);
	}

	//Custom toString
	@Override
	public String toString(){
		String result="";
		result+=(String)map.get("coid");
		result+="\n"+(String)map.get("coName");
		result+="\n"+(String)map.get("coYearEstablished");
		result+="\n"+(String)map.get("coEmail");
		result+="\n"+(String)map.get("coUrl");
		result+="\n"+(String)map.get("coContactName");
		result+="\n"+(String)map.get("coAddress");
		result+="\n"+(String)map.get("coTel");
		result+="\n"+(String)map.get("coDescription");
		result+="\n"+(String)map.get("coSocial");
		result+="\n"+(String)map.get("coDateCreated");
		result+="\n"+(String)map.get("coDateLastModified");
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
