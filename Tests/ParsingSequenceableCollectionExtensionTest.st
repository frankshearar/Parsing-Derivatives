TestCase subclass: #ParsingSequenceableCollectionExtensionTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Support-Tests'!

!ParsingSequenceableCollectionExtensionTest methodsFor: 'as yet unclassified' stamp: 'fbs 4/15/2013 21:21'!
testAsSequenceParserOfEmptyCollectionReturnsEmpty
	| e |
	e := DerivingParser isEmptyBlock.
	self assert: (e value: #() asSequenceParser).! !

!ParsingSequenceableCollectionExtensionTest methodsFor: 'as yet unclassified' stamp: 'fbs 4/15/2013 21:02'!
testAsSequenceParserReturnsaCatParserOnCollectionElements
	| pn p |
	pn := DerivingParser parseNullBlock.
	p := ('nil' reading parsing: ('nil' asSequenceParser)) rest last.
	self assert: #($n $i $l) equals: (pn value: p) anyOne.! !
