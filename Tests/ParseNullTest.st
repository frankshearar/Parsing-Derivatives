TestCase subclass: #ParseNullTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Support-Tests'!

!ParseNullTest methodsFor: 'as yet unclassified' stamp: 'fbs 10/23/2012 09:42'!
testEmptyStringIsEmptyString
	| parseNull |
	parseNull := DerivingParser parseNullBlock.
	self assert: #(()) asSet equals: (parseNull value: DerivingParser emptyString).! !

!ParseNullTest methodsFor: 'as yet unclassified' stamp: 'fbs 10/19/2012 20:57'!
testParseNullOfEpsStarIsItsTreeSet
	| p |
	p := EpsStar treeSet: {1. 2}.
	self assert: p treeSet equals: (DerivingParser parseNullBlock value: p).! !
