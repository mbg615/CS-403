(define (box-info box)
    (let (
        (name (car box))
        (length (clean-number (caddr box)))
        (width (clean-number (cadddr box)))
        (height (clean-number (car (cddddr box)))))
        (box-info-helper name length width height)))

(define (box-area box)
    (let (
        (length (clean-number (caddr box)))
        (width (clean-number (cadddr box)))
        (height (clean-number (car (cddddr box)))))
        (box-area-helper length width height)))

(define (box-volume box)
    (let (
        (length (clean-number (caddr box)))
        (width (clean-number (cadddr box)))
        (height (clean-number (car (cddddr box)))))
        (box-volume-helper length width height)))

(define (box-area-helper length width height)
    (* 2 (+ (* width length)
           (* height length)
           (* height width))))

(define (box-volume-helper length width height)
    (* length width height))

(define (box-info-helper name length width height)
    (let ((area (box-area-helper length width height))
        (volume (box-volume-helper length width height)))
    (display "Box: ") (display name)
    (display ", Length=") (display (rounded length))
    (display ", Width=") (display (rounded width))
    (display ", Height=") (display (rounded height))
    (newline)
    (display "  Surface Area: ") (display (rounded area))
    (display ", Volume: ") (display (rounded volume))
    (newline)))
