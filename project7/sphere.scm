(define (sphere-info sphere)
    (let (
        (name (car sphere))
        (radius (clean-number (caddr sphere))))
        (sphere-info-helper name radius)))

(define (sphere-area sphere)
    (let (
        (radius (clean-number (caddr sphere))))
        (sphere-area-helper radius)))

(define (sphere-volume sphere)
    (let (
        (radius (clean-number (caddr sphere))))
        (sphere-volume-helper radius)))

(define (sphere-area-helper radius)
    (* 4 pi (expt radius 2)))

(define (sphere-area sphere)
    (let ((radius (string->number (string-trim (caddr sphere) char-set:numeric))))
        (sphere-area-helper radius)))

(define (sphere-volume sphere)
    (let ((radius (string->number (string-trim (caddr sphere) char-set:numeric))))
        (sphere-volume-helper radius)))

(define (sphere-volume-helper radius)
    (* (/ 4 3.0) pi (expt radius 3)))

(define (sphere-info-helper name radius)
    (let ((area (sphere-area-helper radius))
        (volume (sphere-volume-helper radius)))
    (display "Sphere: ") (display name)
    (display ", Radius=") (display (rounded radius))
    (newline)
    (display "  Surface Area: ") (display (rounded area))
    (display ", Volume: ") (display (rounded volume))
    (newline)))
