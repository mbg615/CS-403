Shape subclass: Torus [
    | bigRadius smallRadius |

    Torus class >> withName: aName bigRadius: aBigRadius smallRadius: aSmallRadius [
        ^self new initializeWithName: aName bigRadius: aBigRadius smallRadius: aSmallRadius.
    ]

    initializeWithName: aName bigRadius: aBigRadius smallRadius: aSmallRadius [
        self type: 'torus'.
        self name: aName.
        bigRadius := aBigRadius.
        smallRadius := aSmallRadius.
    ]

    area [
        ^(2 * (self class pi) * bigRadius) * (2 * (self class pi) * smallRadius)
    ]

    volume [
        ^((self class pi) * (self class square: smallRadius)) * (2 * (self class pi) * bigRadius)
    ]

    info [
        Transcript show: 'Torus: ' , self name.
        Transcript show: ', Small Radius = ' , smallRadius fixDec.
        Transcript show: ', Big Radius = ' , bigRadius fixDec.
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

            result := self compare: 'torus' with: name with: op with: value.
            result ifFalse: [ ^ false ].
            i := i + 3.
        ].
        ^ true.
    ]
]
