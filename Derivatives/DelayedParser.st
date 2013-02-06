DerivingParser subclass: #DelayedParser
	instanceVariableNames: 'parser'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives'!
!DelayedParser commentStamp: 'fbs 9/6/2012 09:13' prior: 0!
I prevent a parser from being processed prematurely. I act much like a BlockClosure, in that I delay the evaluation of something until asked (via #force).

Parsers that use me often replace me with my forced parser, so my presence in a structure is usually temporary. That makes me look a bit like a Promise.!


!DelayedParser methodsFor: 'initialize-release' stamp: 'fbs 8/30/2012 21:15'!
block: aBlock
	parser := aBlock.! !


!DelayedParser methodsFor: 'testing' stamp: 'fbs 8/30/2012 21:15'!
isDelayed
	^ true.! !


!DelayedParser methodsFor: 'accessing' stamp: 'fbs 8/31/2012 08:09'!
parser
	parser isBlock ifTrue: [parser := parser value].
	^ parser.! !

!DelayedParser methodsFor: 'accessing' stamp: 'fbs 9/5/2012 19:41'!
subParsers
	^ {self force}.! !


!DelayedParser methodsFor: 'delaying' stamp: 'fbs 9/5/2012 09:40'!
delay
	^ self.! !

!DelayedParser methodsFor: 'delaying' stamp: 'fbs 2/1/2013 08:49'!
force
	parser isBlock ifTrue: [parser := parser value].
	^ parser.! !


!DelayedParser methodsFor: 'printing' stamp: 'fbs 9/6/2012 09:41'!
dotLabel
	^ 'Delay'! !

!DelayedParser methodsFor: 'printing' stamp: 'fbs 9/14/2012 21:08'!
printAsDotNode: parserIntegerMap
	^ ('{1}',
	'{2} -> {3}', Character cr) format: {
		super printAsDotNode: parserIntegerMap.
		(parserIntegerMap at: self) printString.
		(parserIntegerMap at: self parser) printString.
	}.! !


!DelayedParser methodsFor: 'generating' stamp: 'fbs 10/25/2012 18:56'!
generate
	^ self force generate.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

DelayedParser class
	instanceVariableNames: ''!

!DelayedParser class methodsFor: 'instance creation' stamp: 'fbs 8/30/2012 21:14'!
on: aBlock
	^ self new block: aBlock! !
