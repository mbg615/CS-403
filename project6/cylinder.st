Shape subclass: Cylinder [
    | radius height |

    Cylinder class >> withName: aName radius: aRadius height: aHeight [
        ^self new initializeWithName: aName radius: aRadius height: aHeight.
    ]

    initializeWithName: aName radius: aRadius height: aHeight [
        self type: 'cylinder'.
        self name: aName.
        radius := aRadius.
        height := aHeight.
    ]

    area [
        ^(2 * (self class pi) * radius * height) + (2 * (self class pi) * (self class square: radius))
    ]

    volume [
        ^(self class pi) * (self class square: radius) * height
    ]

    info [
        Transcript show: 'Cylinder: ' , self name.
        Transcript show: ', Radius = ' , radius fixDec.
        Transcript show: ', Height = ' , height fixDec.
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

            result := self compare: 'cylinder' with: name with: op with: value.
            result ifFalse: [ ^ false ].
            i := i + 3.
        ].
        ^ true.
    ]
]
