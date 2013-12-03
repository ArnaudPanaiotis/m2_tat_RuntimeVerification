import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Enumeration;
import java.util.HashSet;
import java.util.Iterator;
import java.util.NoSuchElementException;
import java.util.Set;
import java.util.Vector;


public class TestCollections {

	public static void main(String[] args) {
		validateIter();
		violateIter();/**/
/*		validateEnum();
		violateEnum();/**/
/*		validateHash();
		violateHash();/**/
	}

	static private void violateIter() {
		Iterator<String> iter = Arrays.asList("un", "deux", "trois", "quatre").iterator();
		
		try {
			while(true) {
				System.out.println("> "+iter.next());
			}
		} catch (NoSuchElementException e) {;}
	}

	static private void validateIter() {
		Iterator<Integer> iter1 = Arrays.asList(1, 2, 3, 4, 5).iterator();
		Iterator<String> iter2 = Arrays.asList("un", "deux", "trois", "quatre").iterator();
		
		while(iter1.hasNext() && iter2.hasNext()) {
			System.out.println("> "+iter1.next()+" "+iter2.next());
		}
	}
	
	static private void violateEnum() {
		Vector<String> vec = new Vector<String>(Arrays.asList("un", "deux", "trois", "quatre"));
		Enumeration<String> en = vec.elements();
		
		while (en.hasMoreElements()) {
			String toto = en.nextElement();
			System.out.println(toto);
			vec.add(toto);
		}
	}
	
	static private void validateEnum() {
		Vector<String> vec = new Vector<String>(Arrays.asList("un", "deux", "trois", "quatre"));
		Enumeration<String> en = vec.elements();
		
		while (en.hasMoreElements()) {
			String toto = en.nextElement();
			System.out.println(toto);
		}
		vec.add("toto");
		System.out.println(vec);
	}
	
	static private void violateHash() {
		Set<Collection<String>> s = new HashSet<Collection<String>>();
		Collection<String> c = new ArrayList<String>();

		c.add("this is ok");
		s.add(c);
		c.add("don’t do this");
		System.out.println(s);
	}
	
	static private void validateHash() {
		Set<Collection<String>> s = new HashSet<Collection<String>>();
		Collection<String> c = new ArrayList<String>();

		c.add("this is ok");
		s.add(c);
		s.remove(c);
		c.add("do this");
		System.out.println(c);
	}
}
