DerivingParser subclass: #Empty
	instanceVariableNames: 'expected actual'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives'!
!Empty commentStamp: 'fbs 8/30/2012 16:09' prior: 0!
I represent the empty parser.!


!Empty methodsFor: 'accessing' stamp: 'fbs 2/14/2013 19:09'!
actual
	^ actual.! !

!Empty methodsFor: 'accessing' stamp: 'fbs 2/14/2013 20:49'!
error
	^ (expected isCollection and: [expected isString not])
		ifTrue: [| collDesc |
			collDesc := expected
				ifEmpty: ['']
				ifNotEmpty: [(expected collect: [:o | o printString]) reduce: [:acc :each | acc, ', ', each]].
			'Expected one of <{1}>, found a <{2}>' format: {collDesc. actual printString}]
		ifFalse: ['Expected a <{1}>, found a <{2}>' format: {expected printString. actual printString}].! !

!Empty methodsFor: 'accessing' stamp: 'fbs 2/14/2013 19:09'!
expected
	^ expected.! !


!Empty methodsFor: 'initialize-release' stamp: 'fbs 2/14/2013 20:47'!
initialize
	super initialize.
	expected := nil.
	actual := nil.! !


!Empty methodsFor: 'parsing' stamp: 'fbs 8/30/2012 18:17'!
or: aParser
	^ aParser.! !

!Empty methodsFor: 'parsing' stamp: 'fbs 2/15/2013 14:36'!
reduce: aBlock
	^ self.! !

!Empty methodsFor: 'parsing' stamp: 'fbs 8/30/2012 18:03'!
then: aParser
	^ self.! !


!Empty methodsFor: 'private' stamp: 'fbs 2/14/2013 20:39'!
initializeWithExpected: expectedObject actual: actualObject
	self initialize.
	expected := expectedObject.
	actual := actualObject.! !


!Empty methodsFor: 'testing' stamp: 'fbs 2/15/2013 09:31'!
isEmptyParser
	^ true.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Empty class
	instanceVariableNames: ''!

!Empty class methodsFor: 'instance creation' stamp: 'fbs 2/14/2013 20:46'!
expected: expectedObject actual: actualObject
	^ self basicNew
		initializeWithExpected: expectedObject
		actual: actualObject.! !
