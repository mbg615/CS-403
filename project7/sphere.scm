(define (sphere-info sphere)
    (sphere-info-helper
        (car sphere)
        (string->number (string-trim (caddr sphere) char-set:numeric))))

(define (sphere-area-helper radius)
    (* 4 pi (expt radius 2)))

(define (sphere-area sphere)
    (let ((radius (string->number (string-trim (caddr sphere) char-set:numeric))))
        (sphere-area-helper radius)))

(define (sphere-volume sphere)
    (let ((radius (string->number (string-trim (caddr sphere) char-set:numeric))))
        (sphere-volume-helper radius)))

(define (sphere-volume-helper radius)
    (* (/ 4 3.0) pi (expt radius 2)))

(define (sphere-info-helper name radius)
    (let ((area (sphere-area-helper radius))
        (volume (sphere-volume-helper radius)))
    (display "Sphere: ") (display name)
    (display ", Radius=") (display (exact->inexact radius))
    (newline)
    (display "  Surface Area: ") (display (exact->inexact area))
    (display ", Volume: ") (display (exact->inexact volume))
    (newline)))
