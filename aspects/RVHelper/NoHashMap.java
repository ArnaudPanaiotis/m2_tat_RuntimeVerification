package RVHelper;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;


public class NoHashMap<K,V> {
	
	private class Couple {
		public K arg1;
		public V arg2;
		
		public Couple(K arg1, V arg2) {
			this.arg1 = arg1;
			this.arg2 = arg2;
		}
		
		public String toString() {
			return "("+arg1+", "+arg2+")";
		}
	}
	
	private ArrayList<Couple> mapping;
	
	public NoHashMap() {
		mapping = new ArrayList();
	}
	
	public V get(K key) {
		for (Couple c : mapping) {
			if (c.arg1.equals(key))
				return c.arg2;
		}
		return null;
	}
	
	public void put(K key, V value) {
		for (Couple c : mapping) {
			if (c.arg1.equals(key)) {
				c.arg2 = value;
				return;
			}
		}
		mapping.add(new Couple(key, value));
	}
	
	public Set<K> keySet() {
		Set<K> ret = new HashSet();
		for (Couple c : mapping) {
			ret.add(c.arg1);
		}
		return ret;
	}
	
	public String toString() {
		return mapping.toString();
	}
}
