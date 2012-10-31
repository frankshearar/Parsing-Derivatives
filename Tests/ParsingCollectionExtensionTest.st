TestCase subclass: #ParsingCollectionExtensionTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Support-Tests'!

!ParsingCollectionExtensionTest methodsFor: 'testing' stamp: 'fbs 10/12/2012 09:58'!
testCartesianProductWithEmptyLeftReturnsRight
	| r |
	self assert: #(1) asSet equals: (Set new cartesianProduct: #+ with: #(1) asSet).
	self assert: #(1) equals: (#() cartesianProduct: #+ with: #(1)).
	r := OrderedCollection with: 1.
	self assert: r equals: (OrderedCollection new cartesianProduct: #+ with: r).! !

!ParsingCollectionExtensionTest methodsFor: 'testing' stamp: 'fbs 10/12/2012 09:58'!
testCartesianProductWithEmptyRightReturnsLeft
	| l |
	self assert: #(1) asSet equals: (#(1) asSet cartesianProduct: #+ with: Set new).
	self assert: #(1) equals: (#(1) cartesianProduct: #+ with: #()).
	l := (OrderedCollection with: 1).
	self assert: l equals: (l cartesianProduct: #+ with: OrderedCollection new).! !

!ParsingCollectionExtensionTest methodsFor: 'testing' stamp: 'fbs 9/5/2012 09:16'!
testCartesianProductWithNonEmptyCollections
	"We show the duplicate 5 to explain the workings of the product. As a Set, the duplicate will be removed."
	self assert: #(4 5 5 6) asSet equals: (#(1 2) asSet cartesianProduct: #+ with: #(3 4) asSet).
	self assert: #(4 5 5 6) equals: (#(1 2) cartesianProduct: #+ with: #(3 4)).
	self assert: #(4 5 5 6) asOrderedCollection equals: (#(1 2) asOrderedCollection cartesianProduct: #+ with: #(3 4) asOrderedCollection).! !
 !
