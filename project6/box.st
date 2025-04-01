Shape subclass: Box [
    | length width height |

    Box class >> withName: aName length: aLength width: aWidth height: aHeight [
        ^self new initializeWithName: aName length: aLength width: aWidth height: aHeight.
    ]

    initializeWithName: aName length: aLength width: aWidth height: aHeight [
        self type: 'box'.
        self name: aName.
        length := aLength.
        width := aWidth.
        height := aHeight.
    ]

    area [
        ^2 * ((width * length) + (height * length) + (height * width))
    ]

    volume [
        ^width * height * length
    ]

    info [
        Transcript show: 'Box: ' , self name.
        Transcript show: ', Length = ' , length fixDec.
        Transcript show: ', Width = ' , width fixDec.
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

            result := self compare: 'box' with: name with: op with: value.
            result ifFalse: [ ^ false ].
            i := i + 3.
        ].
        ^ true.
    ]
]
