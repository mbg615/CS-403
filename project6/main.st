Object subclass: LineParser [
    | name type args |

    LineParser class >> fromString: aString [
        | tokens instance |
        tokens := aString tokenize: ' '.
        instance := self new.
        instance ParseTokens: tokens.
        ^instance
    ]

    ParseTokens: tokens [
        name := tokens first.
        type := tokens second.
        args := tokens allButFirst allButFirst.
    ]

    name [ ^name ]
    type [ ^type ]
    args [ ^args ]
]

Object subclass: FileProcessor [
    FileProcessor class >> makeShape: parser [
        | shape arg1 arg2 arg3 |
        shape := nil.

        parser type = 'box' ifTrue: [
            shape := Box withName:
                parser name
                length: (parser args first asNumber)
                width: (parser args second asNumber)
                height: (parser args third asNumber).
            ^shape
        ].

        parser type = 'sphere' ifTrue: [
            shape := Sphere withName:
                parser name
                radius: (parser args first asNumber).
            ^shape
        ].

        parser type = 'cylinder' ifTrue: [
            shape := Cylinder withName:
                parser name
                radius: (parser args first asNumber)
                height: (parser args second asNumber).
            ^shape
        ].

        parser type = 'torus' ifTrue: [
            shape := Torus withName:
                parser name
                bigRadius: (parser args second asNumber)
                smallRadius: (parser args first asNumber).
            ^shape
        ].


    ]

    FileProcessor class >> parseFile: fileName [
        | file lines shapes |
        shapes := OrderedCollection new.

        [
            file := FileStream open: fileName mode: #read.
        ] on: SystemExceptions.FileError do: [ :ex |
            Transcript show: 'Unable to open ', fileName asString, ' for reading'; nl; nl.
             ObjectMemory quit
        ].

        [file atEnd] whileFalse: [
            | line parser shape |
            line := file nextLine.
            parser := LineParser fromString: line.
            parser ifNotNil: [
                shape := self makeShape: parser.
                shapes add: shape.
            ].
        ].
        file close.

        ^shapes
    ]
]

| filename shapes |
(Smalltalk arguments size ~= 1) ifTrue: [
    Transcript show: 'Usage: shape.st sphere.st cylinder.st torus.st box.st -f main.st shape_file'; nl.
    ObjectMemory quit
].

filename := Smalltalk arguments first.
shapes := FileProcessor parseFile: filename.

| input validCommand |
[
    Transcript cr.
    Transcript show: 'Enter command: '; flush.
    input := FileStream stdin nextLine.
    validCommand := false.
    input = 'quit'
] whileFalse: [
    validCommand := false.

    input = 'help' ifTrue: [
        Transcript show: '	count
	*** print the number of all shapes
	countN
	*** print the number of all shapes that satisfy all N conditions specified below
	*** for example: count3
	print
	*** print all shapes
	printN
	*** print all shapes that satisfy all N conditions specified below
	*** for example: print4
	min
	*** find the minimum surface area and volume of all shapes
	minN
	*** find the minimum surface area and volume of all shapes that satisfy all N conditions specified below
	*** for example: min2
	max
	*** find the maximum surface area and volume of all shapes
	maxN
	*** find the maximum surface area and volume of all shapes that satisfy all N conditions specified below
	*** for example: max3
	total
	*** find the tatal surface area and volume of all shapes
	totalN
	*** find the total surface area and volume of all shapes that satisfy all N conditions specified below
	*** for example: total4
	avg
	*** find the average surface area and volume of all shapes
	avgN
	*** find the average surface area and volume of all shapes that satisfy all N conditions specified below
	*** for example: avg2
	quit
	*** quit this program
	help
	*** print this list

Each condition shall be entered in one line and of the following format:

	name op value

	*** for example: type != box
	                 area <= 1000
	                 volume > 100.5

	The valid names:
		type
		area
		volume

	The valid operators:
		==
		!=
		>=
		<=
		>
		<'; nl; nl.
        validCommand := true.
    ].

    (input matchRegex: 'count([0-9]*)') ifTrue: [
        (input matchRegex: 'count') ifTrue: [
            Transcript show: 'There are ', shapes size printString, ' shapes.'; nl.
        ] ifFalse: [
            | number conditions userInput tokens result count |
            conditions := OrderedCollection new.
            count := 0.
            number := (input searchRegex: '[0-9]+') match asInteger.
            1 to: number do: [ :i |
                Transcript show: 'Enter test condition #', i printString, ': '.

                userInput := FileStream stdin nextLine.
                tokens := userInput tokenize: ' '.
                tokens do: [ :word |
                    conditions add: word
                ]
            ].

            shapes do: [ :shape |
                result := shape test: conditions.
                result ifTrue: [
                    count := count + 1.
                ].
            ].

            Transcript show: 'There are ', count printString, ' shapes.'; nl.
        ].

        validCommand := true.
    ].

    (input matchRegex: 'print([0-9]*)') ifTrue: [
        (input matchRegex: 'print') ifTrue: [
            shapes do: [ :shape | shape info ].
        ] ifFalse: [
            | number conditions userInput tokens result |
            conditions := OrderedCollection new.
            number := (input searchRegex: '[0-9]+') match asInteger.
            1 to: number do: [ :i |
                Transcript show: 'Enter test condition #', i printString, ': '.

                userInput := FileStream stdin nextLine.
                tokens := userInput tokenize: ' '.
                tokens do: [ :word |
                    conditions add: word
                ]
            ].

            shapes do: [ :shape |
                result := shape test: conditions.
                result ifTrue: [
                    shape info.
                ].
            ].
        ].

        validCommand := true.
    ].

    (input matchRegex: 'min([0-9]*)') ifTrue: [
        (input matchRegex: 'min') ifTrue: [
            | minArea minVolume |
            minArea := shapes first area.
            minVolume := shapes first volume.

            shapes do: [ :shape | 
                (shape area < minArea) ifTrue: [ minArea := shape area ].
                (shape volume < minVolume) ifTrue: [ minVolume := shape volume ].
            ].

            Transcript show: 'min(Surface Area)=', minArea fixDec; nl.
            Transcript show: 'min(Volume)=', minVolume fixDec; nl.

        ] ifFalse: [
            | number conditions userInput tokens result minArea minVolume |
            conditions := OrderedCollection new.
            minArea := nil.
            minVolume := nil.
            number := (input searchRegex: '[0-9]+') match asInteger.
            1 to: number do: [ :i |
                Transcript show: 'Enter test condition #', i printString, ': '.

                userInput := FileStream stdin nextLine.
                tokens := userInput tokenize: ' '.
                tokens do: [ :word |
                    conditions add: word
                ]
            ].

            shapes do: [ :shape |
                result := shape test: conditions.
                result ifTrue: [
                    minArea ifNil: [
                        minArea := shape area.
                        minVolume := shape volume.
                    ].

                    (shape area < minArea) ifTrue: [ minArea := shape area ].
                    (shape volume < minVolume) ifTrue: [ minVolume := shape volume ].

                ].
            ].

            Transcript show: 'min(Surface Area)=', minArea fixDec; nl.
            Transcript show: 'min(Volume)=', minVolume fixDec; nl.
        ].

        validCommand := true.
    ].

    (input matchRegex: 'max([0-9]*)') ifTrue: [
        (input matchRegex: 'max') ifTrue: [
            | maxArea maxVolume |
            maxArea := shapes first area.
            maxVolume := shapes first volume.

            shapes do: [ :shape | 
                (shape area > maxArea) ifTrue: [ maxArea := shape area ].
                (shape volume > maxVolume) ifTrue: [ maxVolume := shape volume ].
            ].

            Transcript show: 'max(Surface Area)=', maxArea fixDec; nl.
            Transcript show: 'max(Volume)=', maxVolume fixDec; nl.

        ] ifFalse: [
            | number conditions userInput tokens result maxArea maxVolume |
            conditions := OrderedCollection new.
            maxArea := nil.
            maxVolume := nil.
            number := (input searchRegex: '[0-9]+') match asInteger.
            1 to: number do: [ :i |
                Transcript show: 'Enter test condition #', i printString, ': '.

                userInput := FileStream stdin nextLine.
                tokens := userInput tokenize: ' '.
                tokens do: [ :word |
                    conditions add: word
                ]
            ].

            shapes do: [ :shape |
                result := shape test: conditions.
                result ifTrue: [
                    maxArea ifNil: [
                        maxArea := shape area.
                        maxVolume := shape volume.
                    ].

                    (shape area > maxArea) ifTrue: [ maxArea := shape area ].
                    (shape volume > maxVolume) ifTrue: [ maxVolume := shape volume ].

                ].
            ].

            Transcript show: 'max(Surface Area)=', maxArea fixDec; nl.
            Transcript show: 'max(Volume)=', maxVolume fixDec; nl.
        ].

        validCommand := true.
    ].

    (input matchRegex: 'total([0-9]*)') ifTrue: [
        (input matchRegex: 'total') ifTrue: [
            | totalArea totalVolume |
            totalArea := 0.0.
            totalVolume := 0.0.

            shapes do: [ :shape | 
                totalArea := totalArea + shape area.
                totalVolume := totalVolume + shape volume.
            ].

            Transcript show: 'total(Surface Area)=', totalArea fixDec; nl.
            Transcript show: 'total(Volume)=', totalVolume fixDec; nl.

        ] ifFalse: [
            | number conditions userInput tokens result totalArea totalVolume |
            conditions := OrderedCollection new.
            totalArea := totalVolume := 0.
            number := (input searchRegex: '[0-9]+') match asInteger.
            1 to: number do: [ :i |
                Transcript show: 'Enter test condition #', i printString, ': '.

                userInput := FileStream stdin nextLine.
                tokens := userInput tokenize: ' '.
                tokens do: [ :word |
                    conditions add: word
                ]
            ].

            shapes do: [ :shape |
                result := shape test: conditions.
                result ifTrue: [
                    totalArea := totalArea + shape area.
                    totalVolume := totalVolume + shape area.
                ].
            ].

            Transcript show: 'max(Surface Area)=', totalArea fixDec; nl.
            Transcript show: 'max(Volume)=', totalVolume fixDec; nl.
        ].

        validCommand := true.
    ].

    (input matchRegex: 'avg([0-9]*)') ifTrue: [
        (input matchRegex: 'avg') ifTrue: [
            | avgArea avgVolume |
            avgArea := 0.0.
            avgVolume := 0.0.

            shapes do: [ :shape | 
                avgArea := avgArea + shape area.
                avgVolume := avgVolume + shape volume.
            ].

            (shapes size ~= 0) ifTrue: [
                Transcript show: 'avg(Surface Area)=', (avgArea / shapes size) fixDec; nl.
                Transcript show: 'avg(Volume)=', (avgVolume / shapes size) fixDec; nl.
            ].
        ] ifFalse: [
            | number conditions userInput tokens result totalArea totalVolume count |
            conditions := OrderedCollection new.
            totalArea := totalVolume := count := 0.
            number := (input searchRegex: '[0-9]+') match asInteger.
            1 to: number do: [ :i |
                Transcript show: 'Enter test condition #', i printString, ': '.

                userInput := FileStream stdin nextLine.
                tokens := userInput tokenize: ' '.
                tokens do: [ :word |
                    conditions add: word
                ]
            ].

            shapes do: [ :shape |
                result := shape test: conditions.
                result ifTrue: [
                    totalArea := totalArea + shape area.
                    totalVolume := totalVolume + shape area.
                    count := count + 1.
                ].
            ].

            (count ~= 0) ifTrue: [
                Transcript show: 'max(Surface Area)=', (totalArea / count) fixDec; nl.
                Transcript show: 'max(Volume)=', (totalVolume / count) fixDec; nl.
            ].
        ].

        validCommand := true.
    ].

    validCommand ifFalse: [
        Transcript show: input.
        Transcript show: ': invalid action
Valid actions: print count min max total avg
Enter help for help'; nl.

    ].
]. 
