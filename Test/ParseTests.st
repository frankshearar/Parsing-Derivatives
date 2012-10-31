TestCase subclass: #ParseTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Test'!

!ParseTests methodsFor: 'testing - parsers' stamp: 'fbs 8/30/2012 16:49'!
testOrCreatesAUnionParser
	self assert: ($a asParser or: $b asParser) isUnion.! !

!ParseTests methodsFor: 'testing - parsers' stamp: 'fbs 10/12/2012 10:19'!
testRightRecursiveGrammar
	| ones d Dones DDones parseNull |
	parseNull := DerivingParser parseNullBlock.
	d := DelegateParser new.
	ones := DerivingParser emptyString or: (1 asParser then: d).
	d parser: ones.
	Dones := (ones d: 1).
	DDones := (Dones d: 1).
	self assert: {{1. DerivingParser emptyString}} asSet equals: (parseNull value: Dones).
	self assert: {{1. 1. DerivingParser emptyString}} asSet equals: (parseNull value: DDones).! !

!ParseTests methodsFor: 'testing - parsers' stamp: 'fbs 8/30/2012 16:32'!
testThenCreatesACatParser
	self assert: ($a asParser then: $b asParser) isCat.! !
Cat.! !
