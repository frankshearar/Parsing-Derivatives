DerivingParser subclass: #DelegateParser
	instanceVariableNames: 'parser'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives'!
!DelegateParser commentStamp: 'fbs 8/31/2012 12:08' prior: 0!
I represent a reference to another parser. Use me to construct cycles in the parser structure:

	s := DelegateParser new.
	aStar := ($a asParser then: s) or: EmptyString new.
	s parser: aStar.!


!DelegateParser methodsFor: 'accessing' stamp: 'fbs 10/10/2012 19:07'!
parser
	parser ifNil: [UnresolvedDelegate accessing: self].
	^ parser.! !

!DelegateParser methodsFor: 'accessing' stamp: 'fbs 8/31/2012 12:10'!
parser: aParser
	parser := aParser.! !

!DelegateParser methodsFor: 'accessing' stamp: 'fbs 9/12/2012 09:28'!
subParsers
	^ parser
		ifNil: [#()]
		ifNotNil: [{parser}].! !


!DelegateParser methodsFor: 'printing' stamp: 'fbs 9/6/2012 09:23'!
dotLabel
	^ 'Delegate'! !

!DelegateParser methodsFor: 'printing' stamp: 'fbs 10/15/2012 19:43'!
printAsDotNode: parserIntegerMap
	| result |
	result := '{1}' format: {super printAsDotNode: parserIntegerMap}.
	self parser ifNotNil: [
		result := result , ('{1} -> {2}', Character cr) format: {
		(parserIntegerMap at: self) printString.
		(parserIntegerMap at: self parser) printString}].
	^ result.! !


!DelegateParser methodsFor: 'testing' stamp: 'fbs 9/11/2012 19:56'!
isDelegate
	^ true.! !

!DelegateParser methodsFor: 'testing' stamp: 'fbs 9/12/2012 09:33'!
isResolved
	^ parser notNil.! !


!DelegateParser methodsFor: 'evaluating' stamp: 'fbs 9/12/2012 18:57'!
whenNullable: aUnaryBlock
	"Usually a DelegateParser will have a subparser. During compaction, the delegates in the compacted form might not be resolved because compaction hasn't completed. In that case, we treat the delegate as not being nullable (i.e., its parseNull collection isn't a single element)."
	self isResolved ifTrue:
		[super whenNullable: aUnaryBlock].! !


!DelegateParser methodsFor: 'generating' stamp: 'fbs 10/26/2012 09:30'!
generate
	^ parser generate.! !
