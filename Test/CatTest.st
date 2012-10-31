DerivingParserTestCase subclass: #CatTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Test'!

!CatTest methodsFor: 'testing - instance creation' stamp: 'fbs 8/30/2012 16:34'!
testWithWithCreatesParser
	Cat with: $a asParser with: $b asParser.! !


!CatTest methodsFor: 'fixtures' stamp: 'fbs 8/30/2012 16:34'!
sampleParser
	^ $a asParser then: $b asParser.! !


!CatTest methodsFor: 'testing - testing' stamp: 'fbs 8/30/2012 16:37'!
testIsCat
	self assert: self sampleParser isCat.! !

!CatTest methodsFor: 'testing - testing' stamp: 'fbs 10/11/2012 09:31'!
testSubParserIsChildOfCat
	| p |
	p := self sampleParser.
	self assert: (p first isChildOf: p).
	self assert: (p second isChildOf: p).! !

!CatTest methodsFor: 'testing - testing' stamp: 'fbs 10/11/2012 09:36'!
testSubSubParserIsChildOfCat
	| c p |
	c := $a asParser.
	p := (c then: $b asParser) then: $c asParser.
	self assert: (c isChildOf: p).! !


!CatTest methodsFor: 'testing - accessing' stamp: 'fbs 8/30/2012 22:17'!
testFirst
	| p p1 p2 |
	p1 := $a asParser.
	p2 := $b asParser.
	p := p1 then: p2.
	self assert: p1 equals: p first.! !

!CatTest methodsFor: 'testing - accessing' stamp: 'fbs 8/30/2012 22:19'!
testSecond
	| p p1 p2 |
	p1 := $a asParser.
	p2 := $b asParser.
	p := p1 then: p2.
	self assert: p2 equals: p second.! !

!CatTest methodsFor: 'testing - accessing' stamp: 'fbs 9/5/2012 19:28'!
testSubParsersReturnsFirstAndSecond
	| p |
	p := $a asParser then: $b asParser.
	self assert: {p first. p second} equals: p subParsers.! !


!CatTest methodsFor: 'testing - deriving' stamp: 'fbs 10/15/2012 09:45'!
testDerivativeFirstParserNullable
	| p d r |
	r := 1 asParser.
	p := (EpsStar treeSet: #(1)) then: r.
	d := DerivingParser deriverBlock value: 1 value: p.
	self assert: d isUnion.
	self assert: d left isCat.
	self assert: d left first isEpsStar.
	self assert: #(1) asSet equals: d left second treeSet.
	self assert: d right isCat.
	self assert: d right first isEmpty.
	self assert: r equals: d right second.! !

!CatTest methodsFor: 'testing - deriving' stamp: 'fbs 10/16/2012 17:08'!
testDerivativeFollowsLeibniz
	"(ab)' = a'b + ab'."
	| p d |
	p := 1 asParser then: 2 asParser.
	d := DerivingParser deriverBlock value: 1 value: p.
	self assert: d isCat.
	self assert: d first isEpsStar.
	self assert: #(1) asSet equals: d first treeSet.
	self assert: d second isLiteral.
	self assert: 2 equals: d second token.! !


!CatTest methodsFor: 'testing - parsing' stamp: 'fbs 10/18/2012 21:47'!
testCompactionCompactsSubparsers
	| c p l r |
	l := $a asParser.
	r := $b asParser.
	p := (DelegateParser new parser: l) then: (DelegateParser new parser: r).
	c := SutureCompacter value: p.
	self assert: c isCat.
	self assert: l equals: c first.
	self assert: r equals: c second.! !

!CatTest methodsFor: 'testing - parsing' stamp: 'fbs 9/10/2012 21:15'!
testCompactionOfCompactParsersIsItself
	| p |
	p := $a asParser then: $b asParser.
	self assert: p == (Compacter value: p).! !

!CatTest methodsFor: 'testing - parsing' stamp: 'fbs 9/10/2012 21:15'!
testCompactionWithSingleElementFirstParseTreeIsRed
	| c p |
	p := (EpsStar treeSet: {$a}) then: $b asParser.
	c := Compacter value: p.
	self assert: c isRed.! !

!CatTest methodsFor: 'testing - parsing' stamp: 'fbs 9/10/2012 21:18'!
testCompactionWithSingleElementSecondParseTreeIsRed
	| c p |
	p := $a asParser then: (EpsStar treeSet: {$b}).
	c := Compacter value: p.
	self assert: c isRed.! !


ert: c isRed.! !

!CatTest methodsFor: 'testing - parsing' stamp: 'fbs 9/10/2012 21:18'!
testCompactionWithSingleElementSecondParseTreeIsRed
	| c p |
	p := $a asParser then: (EpsStar treeSet: {$b}).
	c := Compacter value: p.
	self assert: c isRed.! !


(digraph includesSubString: f dotLabel) description: 'digraph doesn''t mention first subparser'.
	self assert: (digraph includesSubString: s dotLabel) description: 'digraph doesn''t mention second subparser'.! !


!CatTest methodsFor: 'testing - generating' stamp: 'fbs 10/26/2012 09:48'!
testGenerateProducesCartesianProduct
	| p |
	p := ($a asParser or: $b asParser) then: ($c asParser or: $d asParser).
	self assert: #(($a $c) ($a $d) ($b $c) ($b $d)) equals: (p generate read: 4).
	self should: [p generate read: 5] raise: Incomplete.! !

!CatTest methodsFor: 'testing - generating' stamp: 'fbs 10/26/2012 18:50'!
testGenerateProducesConcatenationsOfParses
	| p |
	p := $a asParser then: $b asParser.
	self assert: #(($a $b)) equals: (p generate read: 1).
	self should: [p generate read: 2] raise: Incomplete.! !
