TestCase subclass: #ParseTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Test'!

!ParseTests methodsFor: 'testing - parsers' stamp: 'fbs 8/30/2012 16:49'!
testOrCreatesAUnionParser
	self assert: ($a asParser or: $b asParser) isUnion.! !

!ParseTests methodsFor: 'testing - parsers' stamp: 'fbs 10/16/2012 17:02'!
testRightRecursiveGrammar
	| ones d D Dones DDones parseNull |
	D := DerivingParser deriverBlock.
	parseNull := DerivingParser parseNullBlock.
	d := DelegateParser new.
	ones := DerivingParser emptyString or: (1 asParser then: d).
	d parser: ones.
	Dones := (D value: 1 value: ones).
	DDones := (D value: 1 value: Dones).
	self assert: {{1. DerivingParser emptyString}} asSet equals: (parseNull value: Dones).
	self assert: {{1. 1. DerivingParser emptyString}} asSet equals: (parseNull value: DDones).! !

!ParseTests methodsFor: 'testing - parsers' stamp: 'fbs 8/30/2012 16:32'!
testThenCreatesACatParser
	self assert: ($a asParser then: $b asParser) isCat.! !
