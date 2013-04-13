TestCase subclass: #ParserCompacterTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Support-Tests'!

!ParserCompacterTest methodsFor: 'testing' stamp: 'fbs 2/8/2013 08:44'!
testCanCompactCatWithCyclicSubparser
"	| c d p sub |
	d := DelegateParser new.
	sub := DerivingParser emptyString or: (1 asParser then: d).
	d parser: sub.
	p := Cat
			with: DerivingParser empty delay
			with: d.
	c := ParserCompacter value: p.
	
	self assert: c isDelegate."! !

!ParserCompacterTest methodsFor: 'testing' stamp: 'fbs 2/8/2013 08:43'!
testCanCompactDelegateContainingCyclicParsers
	| ones c d D Dones DDones parseNull |
	D := DerivingParser deriverBlock.
	parseNull := DerivingParser parseNullBlock.
	d := DelegateParser new.
	ones := DerivingParser emptyString or: (1 asParser then: d).
	d parser: ones.
	Dones := (D value: 1 value: ones).
	DDones := (D value: 1 value: Dones).
	c := ParserCompacter value: DDones.
	self assert: c isRed.
	self assert: #((1 1)) asSet equals: c parseNull.! !

!ParserCompacterTest methodsFor: 'testing' stamp: 'fbs 2/8/2013 08:43'!
testCanCompactNestedReds
	| c p |
	p := ((EpsStar treeSet: {2}) reduce: [:x | x + 1]) reduce: [:y | y * 2].
	c := ParserCompacter value: p.
	self assert: c isRed.
	self assert: c parser isEpsStar.
	self assert: #(6) asSet equals: c parseNull.! !

!ParserCompacterTest methodsFor: 'testing' stamp: 'fbs 2/8/2013 08:43'!
testCanCompactRedDelegateRed
	| c p |
	p := ((DelegateParser new parser: ((EpsStar treeSet: {1}) reduce: [:x | x + 2])) reduce: [:x | x + 1]).
	c := ParserCompacter value: p.
	self assert: c isRed.
	self assert: c parser isEpsStar.
	self assert: #(4) asSet equals: c parseNull.! !

!ParserCompacterTest methodsFor: 'testing' stamp: 'fbs 2/15/2013 14:18'!
testCanCompactRedEmpty
	| c p |
	"Red -> Empty => Empty"
	p := (DerivingParser emptyExpected: 1 actual: 2) reduce: #yourself.
	c := ParserCompacter value: p.
	self assert: c isEmpty.
	self assert: 1 equals: c expected.
	self assert: 2 equals: c actual.! !

!ParserCompacterTest methodsFor: 'testing' stamp: 'fbs 2/15/2013 09:28'!
testCanCompactStarEmpty
	| c p |
	"Empty star -> Empty"
	p := (DerivingParser emptyExpected: 1 actual: 2) star.
	c := ParserCompacter value: p.
	self assert: c isEmpty.
	self assert: 1 equals: c expected.
	self assert: 2 equals: c actual.! !

!ParserCompacterTest methodsFor: 'testing' stamp: 'fbs 2/8/2013 08:43'!
testCanCompactUnionDeeply
	| c p |
	"#then: and #or: are smart about dropping empty parsers. Since these may occur during derivation, construct the Cats and Unions by hand."
	p := Union left: DerivingParser empty delay right: (Union left: $a asParser delay right: (Cat with: DerivingParser empty delay with: $b asParser delay) delay) delay.
	c := ParserCompacter value: p.
	self assert: c isLiteral.
	self assert: $a equals: c token.! !

!ParserCompacterTest methodsFor: 'testing' stamp: 'fbs 2/8/2013 08:44'!
testCanCompactUnionWithCyclicSubparser
"	| c d p sub |
	d := DelegateParser new.
	sub := DerivingParser emptyString or: (1 asParser then: d).
	d parser: sub.
	p := 2 asParser
		or: (Cat
			with: DerivingParser empty delay
			with: d).
	c := ParserCompacter value: p.
	
	self assert: c isLiteral.
	self assert: 2 equals: c token."! !

!ParserCompacterTest methodsFor: 'testing' stamp: 'fbs 4/13/2013 23:23'!
testCompactedCatParsersPreserveErrorInformation
	| c p |
	p := Cat with: (DerivingParser emptyExpected: 'expected' actual: 'actual') with: ($2 asParser).
	c := ParserCompacter value: p.
	self assert: c isEmpty description: 'Compacted parser not empty'.
	self assert: 'expected' equals: c expected.
	self assert: 'actual' equals: c actual.! !

!ParserCompacterTest methodsFor: 'testing' stamp: 'fbs 4/13/2013 23:27'!
testCompactedCatParsersPreserveErrorInformationWithTrailingEmptyParser
	| c p |
	p := Cat with: ($2 asParser) with: (DerivingParser emptyExpected: 'expected' actual: 'actual').
	c := ParserCompacter value: p.
	self assert: c isEmpty description: 'Compacted parser not empty'.
	self assert: 'expected' equals: c expected.
	self assert: 'actual' equals: c actual.! !

!ParserCompacterTest methodsFor: 'testing' stamp: 'fbs 2/8/2013 08:44'!
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
	c := ParserCompacter value: p.
	"Because of the EpsStar, the Cat is reduced to a Red nesting the Cat's right subparser."
	self assert: c isRed.
	self assert: c parser isEps.
	self assert: #((1 2)) asSet equals: (DerivingParser parseNullBlock value: c).! !

!ParserCompacterTest methodsFor: 'testing' stamp: 'fbs 2/8/2013 08:44'!
testCompactionOfAnythingOrEmptyIsAnything
	self assert: (ParserCompacter value: ($a asParser or: DerivingParser empty)) isLiteral.
	self assert: (ParserCompacter value: ((EpsStar treeSet: {1}) or: DerivingParser empty)) isEpsStar.! !

!ParserCompacterTest methodsFor: 'testing' stamp: 'fbs 2/8/2013 08:44'!
testCompactionOfAnythingThenEmptyIsEmpty
	self assert: (ParserCompacter value: ($a asParser then: DerivingParser empty)) isEmpty.
	self assert: (ParserCompacter value: ((EpsStar treeSet: {1}) then: DerivingParser empty)) isEmpty.! !

!ParserCompacterTest methodsFor: 'testing' stamp: 'fbs 2/8/2013 08:44'!
testCompactionOfEmptyOrAnythingIsAnything
	self assert: (ParserCompacter value: (DerivingParser empty or: $a asParser)) isLiteral.
	self assert: (ParserCompacter value: (DerivingParser empty or: (EpsStar treeSet: {1}))) isEpsStar.! !

!ParserCompacterTest methodsFor: 'testing' stamp: 'fbs 2/8/2013 08:44'!
testCompactionOfEmptyThenAnythingIsEmpty
	self assert: (ParserCompacter value: (DerivingParser empty then: $a asParser)) isEmpty.
	self assert: (ParserCompacter value: (DerivingParser empty then: (EpsStar treeSet: {1}))) isEmpty.! !

!ParserCompacterTest methodsFor: 'testing' stamp: 'fbs 2/8/2013 08:44'!
testCompactionRemovesUnnecessaryDelegates
	"If a delegate doesn't form part of a cycle, it does no harm to point to the delegate's reference instead of the delegate. This also makes the parser one node smaller, potentially."
	| c p |
	p := $a asParser then: (DelegateParser new parser: $b asParser).
	c := ParserCompacter value: p.
	self assert: c isCat.
	self assert: c second isLiteral.! !

!ParserCompacterTest methodsFor: 'testing' stamp: 'fbs 2/15/2013 14:24'!
testOnes
	| c d ones DDones D |
	D := DerivingParser deriverBlock.
	d := DelegateParser new.
	"This parser differs from testCanCompactDelegateContainingCyclicParsers' in that it's 'middle recursive'."
	ones := DerivingParser emptyString or: (d then: 1 asParser).
	d parser: ones.
	DDones := D value: 1 value: (D value: 1 value: ones).
	c := ParserCompacter value: DDones.
"	self assert: c isRed.
	self assert: c parser isDelegate."
	self assert: #((1 1)) asSet equals: c parseNull.! !
