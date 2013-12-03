package RVFiles;

import java.io.Closeable;
import java.util.ArrayList;

import RVHelper.RVException;

public aspect CloseAll {
	
	ArrayList<Closeable> opened = new ArrayList();
	
	after() returning (Closeable c): call(Closeable+.new(..)) {
		opened.add(c);
	}
	
	after() returning() : call(void Closeable+.close()) {
		opened.remove((Closeable)thisJoinPoint.getTarget());
	}
	
	after() returning(Closeable c) : call(* Closeable+.clone()) {
		if(opened.contains(thisJoinPoint.getTarget()))
			opened.add(c);
		else
			opened.remove(c);
	}
	
	after() returning : execution(void *.main(..)) {
		if (! opened.isEmpty())
			throw new RVException("Some files were not closed");
	}
}
