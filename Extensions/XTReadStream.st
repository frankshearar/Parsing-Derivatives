
!XTReadStream methodsFor: '*Parsing-Derivatives' stamp: 'fbs 10/31/2012 20:48'!
interleave: aXTReadStream
	"Interleave my values with those of aXTReadStream. If either of us are exhausted, read from the other. If we are both exhausted, signal so with an Incomplete."
	| readFromLeft |
	readFromLeft := true.
	^ self transforming: [:input :output | | next |
		next := [| s |
			s := readFromLeft ifTrue: [input] ifFalse: [aXTReadStream].
			readFromLeft := readFromLeft not.
			s].
		[output put: next value get]
			on: Incomplete do: [output put: next value get]].! !
alse: [aXTReadStream]) get]].! !
