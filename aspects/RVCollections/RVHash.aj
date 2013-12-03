package RVCollections;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

import RVHelper.NoHashMap;
import RVHelper.RVException;


public aspect RVHash {

	protected NoHashMap<Collection, ArrayList<HashSet>> sets = new NoHashMap();
	protected NoHashMap<Collection, Integer> hashs = new NoHashMap();
	
	before() : call(* Set+.add(*)) && !within(RVHash) {
		if (! (thisJoinPoint.getTarget() instanceof HashSet && thisJoinPoint.getArgs()[0] instanceof Collection))
			return;
		Collection coll = (Collection)thisJoinPoint.getArgs()[0];
		ArrayList<HashSet> set = sets.get(coll);
		if (set == null) {
			set = new ArrayList();
			sets.put(coll, set);
		}
		set.add((HashSet)thisJoinPoint.getTarget());
	}
	
	before() : call(* Set+.remove(*)) && !within(RVHash) {
		if (! (thisJoinPoint.getTarget() instanceof HashSet && thisJoinPoint.getArgs()[0] instanceof Collection))
			return;
		Collection coll = (Collection)thisJoinPoint.getArgs()[0];
		ArrayList<HashSet> set = sets.get(coll);
		if (set != null)
			set.remove(thisJoinPoint.getTarget());
	}
	
	before() : call(* Set+.clear()) && !within(RVHash) {
		if (! (thisJoinPoint.getTarget() instanceof HashSet))
			return;
		for (Collection coll : sets.keySet()) {
			ArrayList<HashSet> set = sets.get(coll);
			if (set != null) {
				set.remove(thisJoinPoint.getTarget());
			}
		}
	}
	
	after() returning(Set ret) : call(* Set+.clone()) && !within(RVHash) {
		if (! (thisJoinPoint.getTarget() instanceof HashSet))
			return;
		for (Collection coll : sets.keySet()) {
			ArrayList<HashSet> set = sets.get(coll);
			if (set != null && set.contains(thisJoinPoint.getTarget())) {
				set.add((HashSet)ret);
			}
		}
	}
	
	before() : call(* Set+.addAll(Collection)) && !within(RVHash) {
		if (! (thisJoinPoint.getTarget() instanceof HashSet))
			return;
		for (Object coll : (Collection)(thisJoinPoint.getArgs()[0])) {
			if (coll instanceof Collection) {
				ArrayList<HashSet> set = sets.get((Collection)coll);
				if (set == null) {
					set = new ArrayList();
					sets.put((Collection)coll, set);
				}
				set.add((HashSet)thisJoinPoint.getTarget());			
			}
		}
	}
	
	before() : call(* Set+.removeAll(Collection)) && !within(RVHash) {
		if (! (thisJoinPoint.getTarget() instanceof HashSet))
			return;
		for (Object coll : (Collection)(thisJoinPoint.getArgs()[0])) {
			if (coll instanceof Collection) {
				ArrayList<HashSet> set = sets.get((Collection)coll);
				if (set != null)
					set.remove(thisJoinPoint.getTarget());
			}
		}
	}
	
	before() : call(* Set+.retainAll(Collection)) && !within(RVHash) {
		if (! (thisJoinPoint.getTarget() instanceof HashSet))
			return;
		Collection<Collection> colls = (Collection)thisJoinPoint.getArgs()[0];
		for (Collection coll : sets.keySet()) {
			if (! colls.contains(coll)) {
				ArrayList<HashSet> set = sets.get(coll);
				set.remove(thisJoinPoint.getTarget());
			}
		}
	}
	
	after() : call(* Collection+.*(..)) && !within(RVHash) && !within(NoHashMap) {
		Collection coll = (Collection)thisJoinPoint.getTarget();
		Integer beforeHash = hashs.get(coll);
		if (beforeHash == null) {
			hashs.put(coll, coll.hashCode());
		} else {
			Integer afterHash = coll.hashCode();
			if (afterHash != beforeHash) {
				ArrayList<HashSet> set = sets.get(coll);
				if (!(set == null || set.isEmpty())) {
					throw new RVException("Modifying Collection included in an HashSet.");
				}
				hashs.put(coll, afterHash);
			}
		}
	}
}
