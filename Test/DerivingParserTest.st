TestCase subclass: #DerivingParserTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Test'!

!DerivingParserTest methodsFor: 'testing - instance creation' stamp: 'fbs 9/4/2012 08:55'!
testEmptyIsEmpty
	self assert: DerivingParser empty isEmpty.! !

!DerivingParserTest methodsFor: 'testing - instance creation' stamp: 'fbs 9/4/2012 08:55'!
testEmptyIsMemoized
	self assert: DerivingParser empty == DerivingParser empty.! !

!DerivingParserTest methodsFor: 'testing - instance creation' stamp: 'fbs 10/12/2012 18:52'!
testEmptyStringIsEmptyString
	| parseNull |
	parseNull := DerivingParser parseNullBlock.
	self assert: {DerivingParser emptyString} asSet equals: (parseNull value: DerivingParser emptyString).! !

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

lf deny: DerivingParser isEmptyBlock == DerivingParser isEmptyBlock.! !

!DerivingParserTest methodsFor: 'testing' stamp: 'fbs 10/24/2012 21:34'!
testParseNullBlockReturnsNewBlock
	self deny: DerivingParser parseNullBlock == DerivingParser parseNullBlock.! !

!DerivingParserTest methodsFor: 'testing' stamp: 'fbs 10/24/2012 09:47'!
testUsesSpecialInspector
	self assert: ParserInspector equals: DerivingParser empty inspectorClass! !
