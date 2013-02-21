TestCase subclass: #DerivingParserTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Test'!

!DerivingParserTest methodsFor: 'testing - instance creation' stamp: 'fbs 9/4/2012 08:55'!
testEmptyIsEmpty
	self assert: DerivingParser empty isEmpty.! !

!DerivingParserTest methodsFor: 'testing - instance creation' stamp: 'fbs 2/15/2013 09:29'!
testEmptyIsEmptyParser
	self assert: DerivingParser empty isEmptyParser.! !

!DerivingParserTest methodsFor: 'testing - instance creation' stamp: 'fbs 9/4/2012 08:55'!
testEmptyIsMemoized
	self assert: DerivingParser empty == DerivingParser empty.! !

!DerivingParserTest methodsFor: 'testing - instance creation' stamp: 'fbs 9/4/2012 08:55'!
testEmptyStringIsMemoized
	self assert: DerivingParser emptyString == DerivingParser emptyString.! !


!DerivingParserTest methodsFor: 'testing - testing' stamp: 'fbs 10/11/2012 09:41'!
testInADelegateCycleAllParsersAreChildren
	| p d |
	d := DelegateParser new.
	p := DerivingParser emptyString or: ($a asParser then: d).
	d parser: p.
	self assert: (p isChildOf: d).
	self assert: (d isChildOf: p).! !


!DerivingParserTest methodsFor: 'testing' stamp: 'fbs 10/24/2012 21:34'!
testDeriverBlockReturnsNewBlock
	self deny: DerivingParser deriverBlock == DerivingParser deriverBlock.! !

!DerivingParserTest methodsFor: 'testing' stamp: 'fbs 10/24/2012 21:33'!
testIsEmptyBlockReturnsNewBlock
	self deny: DerivingParser isEmptyBlock == DerivingParser isEmptyBlock.! !

!DerivingParserTest methodsFor: 'testing' stamp: 'fbs 10/24/2012 21:34'!
testParseNullBlockReturnsNewBlock
	self deny: DerivingParser parseNullBlock == DerivingParser parseNullBlock.! !

!DerivingParserTest methodsFor: 'testing' stamp: 'fbs 10/24/2012 09:47'!
testUsesSpecialInspector
	self assert: ParserInspector equals: DerivingParser empty inspectorClass! !
