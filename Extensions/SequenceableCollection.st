
!SequenceableCollection methodsFor: '*Parsing-Derivatives' stamp: 'fbs 4/15/2013 21:02'!
asSequenceParser
	self ifEmpty: [^ DerivingParser empty].
	^ self allButFirst
		inject: self first asParser
		into: [:acc :each | acc then: each asParser].! !
