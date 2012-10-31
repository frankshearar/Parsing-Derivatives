
!BlockClosure methodsFor: '*Parsing-Derivatives-Support' stamp: 'fbs 7/18/2012 18:55'!
arity
	^ self numArgs.! !

!BlockClosure methodsFor: '*Parsing-Derivatives-Support' stamp: 'fbs 8/30/2012 21:12'!
asParser
	^ DelayedParser on: self.! !

!BlockClosure methodsFor: '*Parsing-Derivatives-Support' stamp: 'fbs 7/20/2012 22:04'!
lfpWithBottom: anObject
	"Turn self (a unary BlockClosure) into a recursive (yet monotonic) function over a mutually recursive graph by computing its (least) fixed point."
	self numArgs = 1 ifFalse: [(ArityMismatch actual: self numArgs expected: 1) signal].
	^ LeastFixedPoint run: self bottom: anObject! !

!BlockClosure methodsFor: '*Parsing-Derivatives-Support' stamp: 'fbs 7/17/2012 18:45'!
memoized
	^ MemoizingBlock run: self.! !
