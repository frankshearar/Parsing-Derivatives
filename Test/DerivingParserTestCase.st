TestCase subclass: #DerivingParserTestCase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Test'!

!DerivingParserTestCase methodsFor: 'fixtures' stamp: 'fbs 8/30/2012 16:04'!
sampleParser
	self subclassResponsibility.! !


!DerivingParserTestCase methodsFor: 'testing - testing' stamp: 'fbs 8/30/2012 16:36'!
testIsCat
	self deny: self sampleParser isCat.! !

!DerivingParserTestCase methodsFor: 'testing - testing' stamp: 'fbs 8/30/2012 21:14'!
testIsDelayed
	self deny: self sampleParser isDelayed.! !

!DerivingParserTestCase methodsFor: 'testing - testing' stamp: 'fbs 9/11/2012 19:55'!
testIsDelegate
	self deny: self sampleParser isDelegate.! !

!DerivingParserTestCase methodsFor: 'testing - testing' stamp: 'fbs 8/30/2012 16:03'!
testIsEmpty
	self deny: self sampleParser isEmpty.! !

!DerivingParserTestCase methodsFor: 'testing - testing' stamp: 'fbs 8/30/2012 16:03'!
testIsEps
	self deny: self sampleParser isEps.! !

!DerivingParserTestCase methodsFor: 'testing - testing' stamp: 'fbs 9/4/2012 09:04'!
testIsEpsStar
	self deny: self sampleParser isEpsStar.! !

!DerivingParserTestCase methodsFor: 'testing - testing' stamp: 'fbs 8/30/2012 16:29'!
testIsLazy
	self deny: self sampleParser isLazy.! !

!DerivingParserTestCase methodsFor: 'testing - testing' stamp: 'fbs 8/30/2012 16:13'!
testIsLiteral
	self deny: self sampleParser isLiteral.! !

!DerivingParserTestCase methodsFor: 'testing - testing' stamp: 'fbs 10/24/2012 21:40'!
testIsNullable
	self deny: (DerivingParser isNullableBlock value: self sampleParser).! !

!DerivingParserTestCase methodsFor: 'testing - testing' stamp: 'fbs 8/30/2012 16:43'!
testIsRed
	self deny: self sampleParser isRed.! !

!DerivingParserTestCase methodsFor: 'testing - testing' stamp: 'fbs 9/13/2012 19:34'!
testIsStar
	self deny: self sampleParser isStar.! !

!DerivingParserTestCase methodsFor: 'testing - testing' stamp: 'fbs 8/30/2012 16:48'!
testIsUnion
	self deny: self sampleParser isUnion.! !

!DerivingParserTestCase methodsFor: 'testing - testing' stamp: 'fbs 10/11/2012 09:30'!
testNeverIsChildOfSelf
	| p |
	p := self sampleParser.
	self deny: (p isChildOf: p).! !


!DerivingParserTestCase methodsFor: 'testing - deriving' stamp: 'fbs 10/25/2012 09:31'!
testDReturnsDerivative
	| d pn |
	d := DerivingParser deriverBlock.
	pn := DerivingParser parseNullBlock.
	self
		assert: (pn value: (d value: $1 value: self sampleParser))
		equals: (self sampleParser d: $1) parseNull.! !


!DerivingParserTestCase methodsFor: 'testing - parsing' stamp: 'fbs 8/30/2012 18:14'!
testAnythingOrEmptyIsItself
	| p |
	p := self sampleParser.
	self assert: (p or: DerivingParser empty) == p.! !

!DerivingParserTestCase methodsFor: 'testing - parsing' stamp: 'fbs 8/31/2012 09:23'!
testAnythingThenEmptyIsEmpty
	| p |
	p := self sampleParser.
	self assert: (p then: DerivingParser empty) isEmpty.! !

!DerivingParserTestCase methodsFor: 'testing - parsing' stamp: 'fbs 10/10/2012 18:58'!
testCompact
	| p |
	"Most parsers are already compact."
	p := self sampleParser.
	self assert: p equals: (SutureCompacter value: p).! !

!DerivingParserTestCase methodsFor: 'testing - parsing' stamp: 'fbs 8/30/2012 18:16'!
testEmptyOrAnythingIsItself
	| p |
	p := self sampleParser.
	self assert: (DerivingParser empty or: p) == p.! !

!DerivingParserTestCase methodsFor: 'testing - parsing' stamp: 'fbs 8/31/2012 09:23'!
testEmptyThenAnythingIsEmpty
	| p |
	p := self sampleParser.
	self assert: (DerivingParser empty then: p) isEmpty.! !

!DerivingParserTestCase methodsFor: 'testing - parsing' stamp: 'fbs 8/30/2012 17:33'!
testForce
	| p |
	p := self sampleParser.
	self assert: p force == p.! !


!DerivingParserTestCase methodsFor: 'testing' stamp: 'fbs 10/11/2012 19:13'!
expectedFailures
	^ self class == EmptyTest
		ifTrue: [#()]
		ifFalse: [#(testAnythingOrEmptyIsItself)]! !


!DerivingParserTestCase methodsFor: 'testing - printing' stamp: 'fbs 10/24/2012 09:35'!
testDotLabelDescribesParser
	| p |
	p := self sampleParser.
	self assert: (p dotLabel includesSubString: p className).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

DerivingParserTestCase class
	instanceVariableNames: ''!

!DerivingParserTestCase class methodsFor: 'as yet unclassified' stamp: 'fbs 8/30/2012 16:06'!
isAbstract
	^ self name = #DerivingParserTestCase! !
