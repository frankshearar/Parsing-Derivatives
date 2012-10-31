TestCase subclass: #GeneratingTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Test'!

!GeneratingTest methodsFor: 'testing - generating' stamp: 'fbs 10/31/2012 14:59'!
testRightRecursiveGrammar
	| ones d g |
	d := DelegateParser new.
	ones := DerivingParser emptyString or: (1 asParser then: d).
	d parser: ones.
	g := ones generate.
	self assert: #(()) equals: (g read: 1).
	self assert: #((1 ())) equals: (g read: 1).
	self assert: #((1 (1 ()))) equals: (g read: 1).! !
