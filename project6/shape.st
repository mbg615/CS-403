Object subclass: Shape [
    | name type |

    initialize [
        "Initializes the shape with a default name."
        name := 'Shape'.
        type := 'Shape'.
    ]

    Shape class >> pi [
        ^3.14159265358979323846.
    ]

    Shape class >> square: aNumber [
        ^ aNumber * aNumber
    ]

    Shape class >> cube: aNumber [
        ^ aNumber * aNumber * aNumber
    ]

    name [
        "Return the name of the shape."
        ^ name
    ]

    name: aName [
        "Sets the name of the shape."
        name := aName.
    ]

    type [
        "Return the type of the shape."
        ^ type
    ]

    type: aType [
        "Sets the type of the shape."
        type := aType.
    ]

    area [
        "Virtual method - Subclasses must override."
        self subclassResponsibility.
    ]

    volume [
        "Virtual method - Subclasses must override."
        self subclassResponsibility.
    ]

    info [
        "Virtual method - Subclasses must override."
        self subclassResponsibility.
    ]

    test [
        "Virtual method - Subclasses must override."
        self subclassResponsibility.
    ]

    compare: type with: name with: op with: value [
        | lhs |
        name = 'type' ifTrue: [ lhs := self type ].
        name = 'area' ifTrue: [ lhs := self area ].
        name = 'volume' ifTrue: [ lhs := self volume ].

        name = 'type' ifTrue: [
            op = '==' ifTrue: [ ^ lhs = value ].
            op = '!=' ifTrue: [ ^ lhs ~= value ].
            op = '>' ifTrue: [ ^ lhs > value ].
            op = '<' ifTrue: [ ^ lhs < value ].
            op = '>=' ifTrue: [ ^ lhs >= value ].
            op = '<=' ifTrue: [ ^ lhs <= value ].
        ] ifFalse: [
            op = '==' ifTrue: [ ^ lhs = (value asNumber) ].
            op = '!=' ifTrue: [ ^ lhs ~= (value asNumber) ].
            op = '>' ifTrue: [ ^ lhs > (value asNumber) ].
            op = '<' ifTrue: [ ^ lhs < (value asNumber) ].
            op = '>=' ifTrue: [ ^ lhs >= (value asNumber) ].
            op = '<=' ifTrue: [ ^ lhs <= (value asNumber) ].
        ].

        ^ false.
    ]
]

Float extend [
    roundTo: numDec [
        ^((((self asFloat) * (10 raisedTo: numDec)) rounded / (10 raisedTo: numDec)) asFloat).
    ]
]

Number extend [
    fixDec [
        | newNum |
        newNum := (self asFloat) roundTo: 2.
        (newNum = (newNum asInteger)) ifTrue: [
            ^((newNum asInteger) asString, '.00').
        ] ifFalse: [
            (newNum = (newNum roundTo: 1)) ifTrue: [
                ^(newNum asString, '0').
            ] ifFalse: [
                ^(newNum asString)
            ]
        ]
    ]
]
