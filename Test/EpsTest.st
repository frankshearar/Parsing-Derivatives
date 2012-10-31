DerivingParserTestCase subclass: #EpsTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Test'!

!EpsTest methodsFor: 'fixtures' stamp: 'fbs 8/30/2012 16:23'!
sampleParser
	^ EpsStar treeSet: {$a}.! !


!EpsTest methodsFor: 'testing - deriving' stamp: 'fbs 9/4/2012 09:19'!
testDerivativeIsItself
	self assert: ((EpsStar treeSet: {}) d: $a) isEpsStar.
	self assert: Set new equals: ((EpsStar treeSet: {}) d: $a) treeSet.
	self assert: {1. 2} asSet equals: ((EpsStar treeSet: {1. 2}) d: $a) treeSet.! !


!EpsTest methodsFor: 'testing - testing' stamp: 'fbs 9/4/2012 09:04'!
testIsEpsStar
	self assert: self sampleParser isEpsStar.! !

!EpsTest methodsFor: 'testing - testing' stamp: 'fbs 8/31/2012 08:05'!
testIsNullable
	self assert: self sampleParser isNullable.! !


!EpsTest methodsFor: 'testing - parsing' stamp: 'fbs 10/12/2012 18:53'!
testParseNullIsTreeSet
	| parseNull |
	parseNull := DerivingParser parseNullBlock.
	self assert: {1. 2} asSet equals: (parseNull value: (EpsStar treeSet: {1. 2})).! !


!EpsTest methodsFor: 'testing - accessing' stamp: 'fbs 9/5/2012 19:32'!
testSubParsersReturnsEmptySet
	self assert: {} equals: (EpsStar treeSet: {1}) subParsers.! !
