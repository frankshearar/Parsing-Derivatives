ParserWalkerTestCase subclass: #PostOrderParserWalkerTestCase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Support-Tests'!

!PostOrderParserWalkerTestCase methodsFor: 'testing - enumerating' stamp: 'fbs 9/7/2012 17:39'!
testParserWalkerUsesPostorderTraversal
	| p |
	p := $a asParser then: ($b asParser or: $c asParser).
	self assert: #('Literal' 'Literal' 'Literal' 'Union' 'Cat') equals: (PostOrderParserWalker walk: p collecting: #className).! !


!PostOrderParserWalkerTestCase methodsFor: 'fixtures' stamp: 'fbs 9/8/2012 23:19'!
walker
	^ PostOrderParserWalker.! !
