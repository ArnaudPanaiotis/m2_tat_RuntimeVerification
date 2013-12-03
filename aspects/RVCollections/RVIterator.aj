package RVCollections;

import java.util.HashMap;
import java.util.Iterator;

import RVHelper.RVException;

public aspect RVIterator {

	private enum State {
		DOHASNEXT, DONEXT;
	}

	private class IterState {
		private State state;
		
		public IterState () {
			state = State.DOHASNEXT;
		}
		
		public void hasNext() {
			state = State.DONEXT;
		}
		
		public void next() {
			switch(state) {
			case DONEXT:
				state = State.DOHASNEXT;
				break;
			case DOHASNEXT:
				throw new RVException("Iterator.next without Iterator.hasNext");
			}
		}
	}
			
	private static HashMap<Iterator, IterState> FSMs = new HashMap();
	
	before() : call (* Iterator+.next(..)) {
		IterState FSM = FSMs.get(thisJoinPoint.getTarget());
		if (FSM == null) {
			FSM = new IterState();
			FSMs.put(((Iterator)thisJoinPoint.getTarget()), FSM);
		}
		FSMs.get(thisJoinPoint.getTarget()).next();
	}
	
	before() : call (* Iterator+.hasNext(..)) {
		IterState FSM = FSMs.get(thisJoinPoint.getTarget());
		if (FSM == null) {
			FSM = new IterState();
			FSMs.put(((Iterator)thisJoinPoint.getTarget()), FSM);
		}
		FSMs.get(thisJoinPoint.getTarget()).hasNext();
	}
	
}
