
!Symbol methodsFor: '*Parsing-Derivatives-Support' stamp: 'fbs 7/18/2012 18:55'!
arity
	"A Symbol without a : takes one argument - the receiver."
	^ self numArgs + 1.! !

!Symbol methodsFor: '*Parsing-Derivatives-Support' stamp: 'fbs 7/20/2012 22:07'!
lfpWithBottom: anObject
	(self arity = 1) ifFalse: [(ArityMismatch actual: self arity expected: 1) signal].
	^ [:x | self value: x] lfpWithBottom: anObject.! !
