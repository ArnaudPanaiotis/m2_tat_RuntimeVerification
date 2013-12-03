import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;
import java.util.Vector;


public class Test {

	public static void main(String[] args) throws IOException {
		ArrayList<Integer> list = new ArrayList();
		Vector<Integer> vect;
		Iterator<Integer> iter;
		Enumeration<Integer> en;
		Set<Collection<Integer>> set = new HashSet<Collection<Integer>>();
		File file = new File("test");
		FileWriter out;
		long start, end;
		int i;
		
		for (i=0 ; i<60 ; i++)
			list.add(i);
		vect = new Vector(list);
		
		// test Iterator
		start = new Date().getTime();
		for (i=0 ; i<1000000 ; i++) {
			iter = list.iterator();
			while(iter.hasNext()) {
				iter.next();
			}
		}
		end = new Date().getTime();
		System.out.println("Iterator: "+(end-start)+"ms");
		
		// test Enumerator
		start = new Date().getTime();
		for (i=0 ; i<100000 ; i++) {
			en = vect.elements();
			while(en.hasMoreElements()) {
				en.nextElement();
			}
		}
		end = new Date().getTime();
		System.out.println("Enumeration: "+(end-start)+"ms");
		
		// test HashSet
		start = new Date().getTime();
		for (i=0 ; i<100000 ; i++) {
			set.add(list);
			set.add(vect);
			set.remove(list);
			set.remove(vect);
		}
		end = new Date().getTime();
		System.out.println("HashSet: "+(end-start)+"ms");
		
		// test File
		start = new Date().getTime();
		for (i=0 ; i<10000 ; i++) {
			out = new FileWriter(file);
			out.close();
		}
		end = new Date().getTime();
		System.out.println("File: "+(end-start)+"ms");
		
	}

}
