TestCase subclass: #ParsingBlockClosureExtensionTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Support-Tests'!

!ParsingBlockClosureExtensionTest methodsFor: 'testing' stamp: 'fbs 8/30/2012 21:08'!
testArityMatchesNumArgs
	self assert: 0 equals: [] arity.
	self assert: 1 equals: [:x | x] arity.
	self assert: 2 equals: [:x :y | x + y] arity.
	self assert: 4 equals: [:x :y :z :w | x + y + z + w] arity.! !

!ParsingBlockClosureExtensionTest methodsFor: 'testing' stamp: 'fbs 8/30/2012 21:13'!
testAsParserReturnsDelayedParser
	self assert: [1] asParser isDelayed.! !

!ParsingBlockClosureExtensionTest methodsFor: 'testing' stamp: 'fbs 7/20/2012 22:05'!
testLfpRequiresUnaryBlock
	self should: [[1] lfpWithBottom: 0] raise: ArityMismatch.! !

!ParsingBlockClosureExtensionTest methodsFor: 'testing' stamp: 'fbs 7/13/2012 18:50'!
testLfpReturnsALeastFixedPoint
	self assert: LeastFixedPoint equals: ([:x | x ] lfpWithBottom: 0) class.! !


!ParsingBlockClosureExtensionTest methodsFor: 'testing - memoizing' stamp: 'fbs 7/17/2012 20:20'!
testMemoizedBlockCachesResults
	self assert: [:x | x ] caches: #value: withArguments: #(1).! !

!ParsingBlockClosureExtensionTest methodsFor: 'testing - memoizing' stamp: 'fbs 7/17/2012 20:22'!
testMemoizedBlockCachesResultsFromValueValue
	| b run |
	b := [:x :y | run := true. x + y] memoized.
	b value: 1 value: 2.
	run := false.
	b value: 1 value: 2.
	self deny: run.
	b value: 1 value: 1.
	self assert: run.! !

!ParsingBlockClosureExtensionTest methodsFor: 'testing - memoizing' stamp: 'fbs 7/17/2012 20:22'!
testMemoizedBlockCachesResultsFromValueValueValue
	| b run |
	b := [:x :y :z | run := true. x + y + z] memoized.
	b value: 1 value: 2 value: 3.
	run := false.
	b value: 1 value: 2 value: 3.
	self deny: run.
	b value: 1 value: 2 value: 1.
	self assert: run.! !

!ParsingBlockClosureExtensionTest methodsFor: 'testing - memoizing' stamp: 'fbs 7/17/2012 20:22'!
testMemoizedBlockCachesResultsFromValueValueValueValue
	| b run |
	b := [:x :y :z :w | run := true. x + y + z + w] memoized.
	b value: 1 value: 2 value: 3 value: 4.
	run := false.
	b value: 1 value: 2 value: 3 value: 4.
	self deny: run.
	b value: 1 value: 2 value: 3 value: 1.
	self assert: run.! !

!ParsingBlockClosureExtensionTest methodsFor: 'testing - memoizing' stamp: 'fbs 7/17/2012 18:46'!
testMemoizedBlockReturnsExpectedValue
	| b |
	b := [:x | x] memoized.

	self assert: 1 equals: (b value: 1).
	self assert: 2 equals: (b value: 2)! !

!ParsingBlockClosureExtensionTest methodsFor: 'testing - memoizing' stamp: 'fbs 7/17/2012 18:44'!
testMemoizedReturnsMemoizingBlock
	self assert: ([:x | x] memoized isKindOf: MemoizingBlock).! !


!ParsingBlockClosureExtensionTest methodsFor: 'helpers' stamp: 'fbs 7/17/2012 20:23'!
assert: aBlock caches: aSelector withArguments: someObjects
	| b run |
	run := false.
	b := [:x | run := true. aBlock value: x] memoized.
	b perform: aSelector withArguments: someObjects.
	run := false.
	b perform: aSelector withArguments: someObjects.
	self deny: run.
	b perform: aSelector withArguments: (someObjects collect: [:x | x + 1]).
	self assert: run.! !
