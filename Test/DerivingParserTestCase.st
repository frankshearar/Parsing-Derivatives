TestCase subclass: #DerivingParserTestCase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Test'!

!DerivingParserTestCase methodsFor: 'fixtures' stamp: 'fbs 8/30/2012 16:04'!
sampleParser
	self subclassResponsibility.! !


!DerivingParserTestCase methodsFor: 'testing - testing' stamp: 'fbs 8/30/2012 16:36'!
testIsCat
	self deny: self sampleParser isCat.! !

!DerivingParserTestCase methodsFor: 'testing - testing' stamp: 'fbs 8/30/2012 21:14'!
testIsDelayed
	self deny: self sampleParser isDelayed.! !

!DerivingParserTestCase methodsFor: 'testing - testing' stamp: 'fbs 9/11/2012 19:55'!
testIsDelegate
	self deny: self sampleParser isDelegate.! !

!DerivingParserTestCase methodsFor: 'testing - testing' stamp: 'fbs 4/15/2013 21:14'!
testIsEmpty
	| e |
	e := DerivingParser isEmptyBlock.
	self deny: (e value: self sampleParser).! !

!DerivingParserTestCase methodsFor: 'testing - testing' stamp: 'fbs 2/15/2013 09:30'!
testIsEmptyParser
	self deny: self sampleParser isEmptyParser.! !

!DerivingParserTestCase methodsFor: 'testing - testing' stamp: 'fbs 8/30/2012 16:03'!
testIsEps
	self deny: self sampleParser isEps.! !

!DerivingParserTestCase methodsFor: 'testing - testing' stamp: 'fbs 9/4/2012 09:04'!
testIsEpsStar
	self deny: self sampleParser isEpsStar.! !

!DerivingParserTestCase methodsFor: 'testing - testing' stamp: 'fbs 8/30/2012 16:29'!
testIsLazy
	self deny: self sampleParser isLazy.! !

!DerivingParserTestCase methodsFor: 'testing - testing' stamp: 'fbs 8/30/2012 16:13'!
testIsLiteral
	self deny: self sampleParser isLiteral.! !

!DerivingParserTestCase methodsFor: 'testing - testing' stamp: 'fbs 10/24/2012 21:40'!
testIsNullable
	self deny: (DerivingParser isNullableBlock value: self sampleParser).! !

!DerivingParserTestCase methodsFor: 'testing - testing' stamp: 'fbs 8/30/2012 16:43'!
testIsRed
	self deny: self sampleParser isRed.! !

!DerivingParserTestCase methodsFor: 'testing - testing' stamp: 'fbs 9/13/2012 19:34'!
testIsStar
	self deny: self sampleParser isStar.! !

!DerivingParserTestCase methodsFor: 'testing - testing' stamp: 'fbs 8/30/2012 16:48'!
testIsUnion
	self deny: self sampleParser isUnion.! !

!DerivingParserTestCase methodsFor: 'testing - testing' stamp: 'fbs 10/11/2012 09:30'!
testNeverIsChildOfSelf
	| p |
	p := self sampleParser.
	self deny: (p isChildOf: p).! !


!DerivingParserTestCase methodsFor: 'testing - deriving' stamp: 'fbs 4/13/2013 23:38'!
testDReturnsDerivative
	| d pn |
	d := DerivingParser deriverBlock.
	pn := DerivingParser parseNullBlock.
	self
		assert: (pn value: (d value: $1 value: self sampleParser))
		equals: (d value: $1 value: self sampleParser) parseNull.! !


!DerivingParserTestCase methodsFor: 'testing - parsing' stamp: 'fbs 8/30/2012 18:14'!
testAnythingOrEmptyIsItself
	| p |
	p := self sampleParser.
	self assert: (p or: DerivingParser empty) == p.! !

!DerivingParserTestCase methodsFor: 'testing - parsing' stamp: 'fbs 4/15/2013 22:08'!
testAnythingThenEmptyIsEmpty
	| p e empty cat |
	e := DerivingParser isEmptyBlock.
	empty := DerivingParser emptyExpected: 1 actual: 2.
	p := self sampleParser.
	cat := p then: empty.
	self assert: (e value: cat).
	self assert: 1 equals: cat expected.
	self assert: 2 equals: cat actual.! !

!DerivingParserTestCase methodsFor: 'testing - parsing' stamp: 'fbs 2/8/2013 08:42'!
testCompact
	| p |
	"Most parsers are already compact."
	p := self sampleParser.
	self assert: p equals: (ParserCompacter value: p).! !

!DerivingParserTestCase methodsFor: 'testing - parsing' stamp: 'fbs 8/30/2012 18:16'!
testEmptyOrAnythingIsItself
	| p |
	p := self sampleParser.
	self assert: (DerivingParser empty or: p) == p.! !

!DerivingParserTestCase methodsFor: 'testing - parsing' stamp: 'fbs 4/15/2013 22:08'!
testEmptyThenAnythingIsEmpty
	| e p |
	e := DerivingParser isEmptyBlock.
	p := self sampleParser.
	self assert: (e value: (DerivingParser empty then: p)).! !

!DerivingParserTestCase methodsFor: 'testing - parsing' stamp: 'fbs 8/30/2012 17:33'!
testForce
	| p |
	p := self sampleParser.
	self assert: p force == p.! !

!DerivingParserTestCase methodsFor: 'testing - parsing' stamp: 'fbs 4/17/2013 17:38'!
testOptionalMeansItAcceptsEmptyInput
	| p pn |
	pn := DerivingParser parseNullBlock.
	p := self sampleParser optional.
	self assert: ((pn value: p) add: #(); yourself) equals: (pn value: p).! !

!DerivingParserTestCase methodsFor: 'testing - parsing' stamp: 'fbs 4/25/2013 17:20'!
testOptionalMeansItAcceptsSameLanguageAsNonOptional
	"Well, the first N generated sentences, at least."
	| p po pn num |
	num := 100.
	pn := DerivingParser parseNullBlock.
	p := self sampleParser.
	po := p optional.
	[(p generate collecting: [:o | | origParses optParses sentence |
		sentence := o asArray.
		origParses := ((sentence reading parsing: p) collecting: pn) read: num.
		optParses := ((sentence reading parsing: po) collecting: pn) read: num.
		self assert: origParses equals: optParses]) read: num]
		on: Incomplete do: ["expected"].! !



!DerivingParserTestCase methodsFor: 'testing - printing' stamp: 'fbs 10/24/2012 09:35'!
testDotLabelDescribesParser
	| p |
	p := self sampleParser.
	self assert: (p dotLabel includesSubString: p className).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

DerivingParserTestCase class
	instanceVariableNames: ''!

!DerivingParserTestCase class methodsFor: 'as yet unclassified' stamp: 'fbs 8/30/2012 16:06'!
isAbstract
	^ self name = #DerivingParserTestCase! !
