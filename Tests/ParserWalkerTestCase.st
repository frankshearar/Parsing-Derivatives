TestCase subclass: #ParserWalkerTestCase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Support-Tests'!

!ParserWalkerTestCase methodsFor: 'testing - enumerating' stamp: 'fbs 9/8/2012 23:19'!
testParserWalkerVisitsAllSubparsers
	| p |
	p := $a asParser then: ($b asParser or: $c asParser).
	self assert: 5 equals: (self walker walk: p collecting: #yourself) size.! !

!ParserWalkerTestCase methodsFor: 'testing - enumerating' stamp: 'fbs 9/8/2012 23:19'!
testWalkCollectingReturnsMappedValues
	| map p |
	p := $a asParser then: ($b asParser or: $c asParser).
	map := self walker walk: p collecting: #className.
	self assert: #('Union' 'Cat' 'Literal' 'Literal' 'Literal') sorted equals: map sorted.! !

!ParserWalkerTestCase methodsFor: 'testing - enumerating' stamp: 'fbs 9/8/2012 23:19'!
testWalkIsCycleSafe
	| p d |
	d := DelegateParser new.
	p := ($a asParser then: d) or: DerivingParser emptyString.
	d parser: p.
	self assert: 5 equals: (self walker walk: p collecting: #yourself) size.! !


!ParserWalkerTestCase methodsFor: 'fixtures' stamp: 'fbs 9/8/2012 23:19'!
walker
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

ParserWalkerTestCase class
	instanceVariableNames: ''!

!ParserWalkerTestCase class methodsFor: 'testing' stamp: 'fbs 9/8/2012 23:21'!
isAbstract
	^ self == ParserWalkerTestCase.! !
