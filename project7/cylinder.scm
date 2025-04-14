(define (cylinder-info cylinder)
    (cylinder-info-helper
        (car cylinder)
        (string->number (caddr cylinder))
        (string->number (string-trim (cadddr cylinder) char-set:numeric))))

(define (cylinder-area radius height)
    (+ (* 2 pi radius height)
        (* 2 pi (expt radius 2))))

(define (cylinder-volume radius height)
    (* pi (expt radius 2) height))

(define (cylinder-info-helper name radius height)
    (let ((area (cylinder-area radius height))
        (volume (cylinder-volume radius height)))
    (display "Cylinder: ") (display name)
    (display ", Radius=") (display (exact->inexact radius))
    (display ", Height=") (display (exact->inexact height))
    (newline)
    (display "  Surface Area: ") (display (exact->inexact area))
    (display ", Volume: ") (display (exact->inexact volume))
    (newline)))
