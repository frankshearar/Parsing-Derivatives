DerivingParser subclass: #Suture
	instanceVariableNames: 'reference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives'!
!Suture commentStamp: 'fbs 10/1/2012 17:02' prior: 0!
I am used as a placeholder during compaction. I point to some parser's compacted form and, once the nodes of a parser graph have been compacted, I _become_ (in the sense of #becomeForward:) that compacted form.!


!Suture methodsFor: 'accessing' stamp: 'fbs 10/1/2012 09:34'!
reference
	^ reference.! !

!Suture methodsFor: 'accessing' stamp: 'fbs 10/1/2012 16:34'!
reference: anObject
	reference := anObject.! !


!Suture methodsFor: 'initialize-release' stamp: 'fbs 10/1/2012 16:34'!
pointingAt: anObject
	self reference: anObject.! !


!Suture methodsFor: 'printing' stamp: 'fbs 10/4/2012 09:24'!
dotLabel
	^ self className, '!!'! !

!Suture methodsFor: 'printing' stamp: 'fbs 10/4/2012 09:16'!
printAsDotNode: parserIntegerMap
	^ ('{1}',
	'{2} -> {3}', Character cr) format: {
		super printAsDotNode: parserIntegerMap.
		(parserIntegerMap at: self) printString.
		(parserIntegerMap at: self reference) printString.
	}.! !

!Suture methodsFor: 'printing' stamp: 'fbs 10/10/2012 09:32'!
printOn: aStream
	aStream nextPutAll: 'a Suture (-> '.
	reference printOn: aStream.
	aStream nextPut: $).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Suture class
	instanceVariableNames: ''!

!Suture class methodsFor: 'instance creation' stamp: 'fbs 10/4/2012 09:27'!
pointingAt: anObject
	^ self new pointingAt: anObject.! !
Suture class methodsFor: 'instance creation' stamp: 'fbs 10/4/2012 09:27'!
pointingAt: anObject
	^ self new pointingAt: anObject.! !
