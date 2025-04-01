Shape subclass: Sphere [
    | radius |

    Sphere class >> withName: aName radius: aRadius [
        ^self new initializeWithName: aName radius: aRadius.
    ]

    initializeWithName: aName radius: aRadius [
        self type: 'sphere'.
        self name: aName.
        radius := aRadius.
    ]

    area [
        ^4 * (self class pi) * (self class square: radius).
    ]

    volume [
        ^(4.0 / 3.0) * (self class pi) * (self class cube: radius)
    ]


    info [
        Transcript show: 'Sphere: ' , self name.
        Transcript show: ', Radius = ' , radius fixDec.
        Transcript cr.
        Transcript tab.
        Transcript show: 'Surface Area = ' , self area fixDec.
        Transcript show: ', Volume = ' , self volume fixDec.
        Transcript cr.
    ]

    test: conditions [
        | i name op value result |
        i := 1.
        [i <= conditions size] whileTrue: [
            name := conditions at: i.
            op := conditions at: i + 1.
            value := conditions at: i + 2.

            result := self compare: 'sphere' with: name with: op with: value.
            result ifFalse: [ ^ false ].
            i := i + 3.
        ].
        ^ true.
    ]
]
