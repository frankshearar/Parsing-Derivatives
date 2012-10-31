
!Collection methodsFor: '*Parsing-Derivatives' stamp: 'fbs 10/15/2012 09:31'!
cartesianProduct: aBinaryBlock with: aCollection
	"Given a collection A of a's and B of b's return a collection of all pairs of the form (a,b) where aBinaryBlock is responsible for creating the pairs."
	self ifEmpty: [^ aCollection].
	aCollection ifEmpty: [^ self].
	^ (self gather: [:a |
		aCollection collect: [:b |
			aBinaryBlock value: a value: b]]) as: self species! !
! !
