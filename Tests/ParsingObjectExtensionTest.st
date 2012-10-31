TestCase subclass: #ParsingObjectExtensionTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Support-Tests'!


!ParsingObjectExtensionTest methodsFor: 'test - instance creation' stamp: 'fbs 8/30/2012 16:07'!
testAsParserReturnsLiteral
	self assert: $a asParser isLiteral.
	self assert: 1 asParser isLiteral.
	self assert: Object new asParser isLiteral.! !
 instance creation' stamp: 'fbs 8/30/2012 16:07'!
testAsParserReturnsLiteral
	self assert: $a asParser isLiteral.
	self assert: 1 asParser isLiteral.
	self assert: Object new asParser isLiteral.! !
