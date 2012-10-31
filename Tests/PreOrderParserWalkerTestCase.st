ParserWalkerTestCase subclass: #PreOrderParserWalkerTestCase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Support-Tests'!

!PreOrderParserWalkerTestCase methodsFor: 'testing - enumerating' stamp: 'fbs 9/7/2012 17:36'!
testParserWalkerUsesPreorderTraversal
	| p |
	p := $a asParser then: ($b asParser or: $c asParser).
	self assert: #('Cat' 'Literal' 'Union' 'Literal' 'Literal') equals: (ParserWalker walk: p collecting: #className).! !


!PreOrderParserWalkerTestCase methodsFor: 'fixtures' stamp: 'fbs 9/8/2012 23:20'!
walker
	^ PreOrderParserWalker.! !
