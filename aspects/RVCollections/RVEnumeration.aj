package RVCollections;

import java.util.Enumeration;
import java.util.HashMap;

import RVHelper.RVException;


public aspect RVEnumeration {

	private HashMap<Enumeration, Integer> EnumState = new HashMap();
	private HashMap<Enumeration, Object> EnumDs = new HashMap();
//	private HashMap<Object, Integer> DsState = new HashMap();

//	after() : call(* *.*(..)) {
//		DsState.put(thisJoinPoint.getThis(), thisJoinPoint.getThis().hashCode());
//	}
	
	after() returning (Enumeration en) : call(Enumeration+ *.*(..)) {
		EnumDs.put(en, thisJoinPoint.getTarget());
		EnumState.put(en, thisJoinPoint.getTarget().hashCode());
	}
	
	before() : call(* Enumeration+.nextElement()) {
		if (EnumDs.get(thisJoinPoint.getTarget()).hashCode() != EnumState.get(thisJoinPoint.getTarget()))
			throw new RVException ("Structure being enumerated changed");
	}
	
}
