(define (cylinder-info cylinder)
    (let (
        (name (car cylinder))
        (radius (clean-number (caddr cylinder)))
        (height (clean-number (cadddr cylinder))))
        (cylinder-info-helper name radius height)))

(define (cylinder-area cylinder)
    (let (
        (radius (clean-number (caddr cylinder)))
        (height (clean-number (cadddr cylinder))))
        (cylinder-area-helper radius height)))

(define (cylinder-volume cylinder)
    (let (
        (radius (clean-number (caddr cylinder)))
        (height (clean-number (cadddr cylinder))))
        (cylinder-volume-helper radius height)))

(define (cylinder-area-helper radius height)
    (+ (* 2 pi radius height)
        (* 2 pi (expt radius 2))))

(define (cylinder-volume-helper radius height)
    (* pi (expt radius 2) height))

(define (cylinder-info-helper name radius height)
    (let (
        (area (cylinder-area-helper radius height))
        (volume (cylinder-volume-helper radius height)))
        (display "Cylinder: ") (display name)
        (display ", Radius=") (display (rounded radius))
        (display ", Height=") (display (rounded height))
        (newline)
        (display "  Surface Area: ") (display (rounded area))
        (display ", Volume: ") (display (rounded volume))
        (newline)))
