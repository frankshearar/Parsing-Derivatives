TestCase subclass: #ParsingSymbolExtensionTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Support-Tests'!

!ParsingSymbolExtensionTest methodsFor: 'testing' stamp: 'fbs 8/30/2012 21:06'!
testLfpRequiresUnarySymbol
	self should: [#+ lfpWithBottom: 0] raise: ArityMismatch.! !
