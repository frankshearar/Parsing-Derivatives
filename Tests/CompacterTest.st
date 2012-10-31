TestCase subclass: #CompacterTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Support-Tests'!

!CompacterTest methodsFor: 'testing - recursive grammars' stamp: 'fbs 10/3/2012 09:34'!
testCycleStartingWithDelegateCanCompact
	| ones d Dones|
	d := DelegateParser new.
	ones := DerivingParser emptyString or: (1 asParser then: d).
	d parser: ones.
	Dones := ones d: 1.
	"(a) It can actually compact. (b) The compacted form still defines the same language."
	self assert: Dones parseNull equals: (SutureCompacter value: Dones) parseNull.! !

!CompacterTest methodsFor: 'testing - recursive grammars' stamp: 'fbs 10/3/2012 09:34'!
testRightRecursiveGrammarsCanCompact
	| ones d |
	d := DelegateParser new.
	ones := DerivingParser emptyString or: (1 asParser then: d).
	d parser: ones.
	self assert: ones equals: (SutureCompacter value: ones).! !
