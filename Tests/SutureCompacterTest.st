TestCase subclass: #SutureCompacterTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Support-Tests'!

!SutureCompacterTest methodsFor: 'testing' stamp: 'fbs 10/18/2012 21:04'!
testCanCompactCatWithCyclicSubparser
"	| c d p sub |
	d := DelegateParser new.
	sub := DerivingParser emptyString or: (1 asParser then: d).
	d parser: sub.
	p := Cat
			with: DerivingParser empty delay
			with: d.
	c := SutureCompacter value: p.
	
	self assert: c isDelegate."! !

!SutureCompacterTest methodsFor: 'testing' stamp: 'fbs 10/18/2012 21:41'!
testCanCompactDelegateContainingCyclicParsers
	| ones c d D Dones DDones parseNull |
	D := DerivingParser deriverBlock.
	parseNull := DerivingParser parseNullBlock.
	d := DelegateParser new.
	ones := DerivingParser emptyString or: (1 asParser then: d).
	d parser: ones.
	Dones := (D value: 1 value: ones).
	DDones := (D value: 1 value: Dones).
	c := SutureCompacter value: DDones.
	self assert: c isCat.
	self assert: {{1. 1. DerivingParser emptyString}} asSet equals: c parseNull.! !

!SutureCompacterTest methodsFor: 'testing' stamp: 'fbs 10/17/2012 21:19'!
testCanCompactUnionDeeply
	| c p |
	"#then: and #or: are smart about dropping empty parsers. Since these may occur during derivation, construct the Cats and Unions by hand."
	p := Union left: DerivingParser empty delay right: (Union left: $a asParser delay right: (Cat with: DerivingParser empty delay with: $b asParser delay) delay) delay.
	c := SutureCompacter value: p.
	self assert: c isLiteral.
	self assert: $a equals: c token.! !

!SutureCompacterTest methodsFor: 'testing' stamp: 'fbs 10/18/2012 21:12'!
testCanCompactUnionWithCyclicSubparser
"	| c d p sub |
	d := DelegateParser new.
	sub := DerivingParser emptyString or: (1 asParser then: d).
	d parser: sub.
	p := 2 asParser
		or: (Cat
			with: DerivingParser empty delay
			with: d).
	c := SutureCompacter value: p.
	
	self assert: c isLiteral.
	self assert: 2 equals: c token."! !

!SutureCompacterTest methodsFor: 'testing' stamp: 'fbs 10/18/2012 09:20'!
testCompactionDiscardsEmptyUnionSubparsers
	| c p |
	p := Union
		left: (Cat
			with: (EpsStar treeSet: #(1)) delay
			with: (Cat
				with: (EpsStar treeSet: #(2)) delay
				with: DerivingParser emptyString delay) delay)
		right: (Cat "This subparse is discarded."
			with: DerivingParser empty delay
			with: DerivingParser emptyString delay) delay.
	c := SutureCompacter value: p.
	self assert: c isCat.
	self assert: c first isEpsStar.
	self assert: #(1) asSet equals: c first treeSet! !

!SutureCompacterTest methodsFor: 'testing' stamp: 'fbs 10/17/2012 20:56'!
testCompactionOfAnythingOrEmptyIsAnything
	self assert: (SutureCompacter value: ($a asParser or: DerivingParser empty)) isLiteral.
	self assert: (SutureCompacter value: ((EpsStar treeSet: {1}) or: DerivingParser empty)) isEpsStar.! !

!SutureCompacterTest methodsFor: 'testing' stamp: 'fbs 10/17/2012 20:54'!
testCompactionOfAnythingThenEmptyIsEmpty
	self assert: (SutureCompacter value: ($a asParser then: DerivingParser empty)) isEmpty.
	self assert: (SutureCompacter value: ((EpsStar treeSet: {1}) then: DerivingParser empty)) isEmpty.! !

!SutureCompacterTest methodsFor: 'testing' stamp: 'fbs 10/17/2012 20:55'!
testCompactionOfEmptyOrAnythingIsAnything
	self assert: (SutureCompacter value: (DerivingParser empty or: $a asParser)) isLiteral.
	self assert: (SutureCompacter value: (DerivingParser empty or: (EpsStar treeSet: {1}))) isEpsStar.! !

!SutureCompacterTest methodsFor: 'testing' stamp: 'fbs 10/17/2012 20:53'!
testCompactionOfEmptyThenAnythingIsEmpty
	self assert: (SutureCompacter value: (DerivingParser empty then: $a asParser)) isEmpty.
	self assert: (SutureCompacter value: (DerivingParser empty then: (EpsStar treeSet: {1}))) isEmpty.! !

!SutureCompacterTest methodsFor: 'testing' stamp: 'fbs 10/18/2012 09:39'!
testCompactionRemovesUnnecessaryDelegates
	"If a delegate doesn't form part of a cycle, it does no harm to point to the delegate's reference instead of the delegate. This also makes the parser one node smaller, potentially."
	| c p |
	p := $a asParser then: (DelegateParser new parser: $b asParser).
	c := SutureCompacter value: p.
	self assert: c isCat.
	self assert: c second isLiteral.! !

!SutureCompacterTest methodsFor: 'testing' stamp: 'fbs 10/17/2012 21:13'!
testWtf
	| c d ones DDones D |
	D := DerivingParser deriverBlock.
	d := DelegateParser new.
	ones := DerivingParser emptyString or: (1 asParser then: d).
	d parser: ones.
	DDones := D value: 1 value: (D value: 1 value: ones).
	c := SutureCompacter value: DDones.
	self assert: c isCat.
	self assert: c first isEpsStar.
	self assert: #(1) asSet equals: c first treeSet.! !
rt of a cycle, it does no harm to point to the delegate's reference instead of the delegate. This also makes the parser one node smaller, potentially."
	| c p |
	p := $a asParser then: (DelegateParser new parser: $b asParser).
	c := SutureCompacter value: p.
	self assert: c isCat.
	self assert: c second isLiteral.! !

!SutureCompacterTest methodsFor: 'testing' stamp: 'fbs 10/25/2012 09:26'!
testOnes
	| c d ones DDones D |
	D := DerivingParser deriverBlock.
	d := DelegateParser new.
	ones := DerivingParser emptyString or: (1 asParser then: d).
	d parser: ones.
	DDones := D value: 1 value: (D value: 1 value: ones).
	c := SutureCompacter value: DDones.
	self assert: c isRed.
	self assert: c parser isDelegate.
	self assert: #((1 1)) asSet equals: c parseNull.! !
