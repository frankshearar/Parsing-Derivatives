TestCase subclass: #ParsingObjectExtensionTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Support-Tests'!

!ParsingObjectExtensionTest methodsFor: 'testing - instance creation' stamp: 'fbs 10/24/2012 09:33'!
testAsArray
	self assert: #(1) equals: 1 asArray.
	self assert: #(1) equals: #(1) asArray.! !

!ParsingObjectExtensionTest methodsFor: 'testing - instance creation' stamp: 'fbs 8/30/2012 16:07'!
testAsParserReturnsLiteral
	self assert: $a asParser isLiteral.
	self assert: 1 asParser isLiteral.
	self assert: Object new asParser isLiteral.! !

