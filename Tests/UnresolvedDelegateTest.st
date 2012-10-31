TestCase subclass: #UnresolvedDelegateTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Support-Tests'!

!UnresolvedDelegateTest methodsFor: 'testing' stamp: 'fbs 10/18/2012 09:23'!
testCanRaiseThrougConvenienceMethod
	self
		should: [UnresolvedDelegate accessing: DerivingParser empty]
		raise: UnresolvedDelegate.! !

!UnresolvedDelegateTest methodsFor: 'testing' stamp: 'fbs 10/18/2012 09:22'!
testCanStoreParserReference
	| p e |
	p := DerivingParser empty.
	e := UnresolvedDelegate new parser: p.
	self assert: p equals: e parser.! !

!UnresolvedDelegateTest methodsFor: 'testing' stamp: 'fbs 10/18/2012 09:25'!
testExposesUnresolvedDelegate
	[UnresolvedDelegate accessing: DerivingParser empty]
		on: UnresolvedDelegate
		do: [:e | self assert: DerivingParser empty equals: e parser].! !
