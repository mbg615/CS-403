(define (torus-info torus)
    (let (
        (name (car torus))
        (small-radius (clean-number (caddr torus)))
        (big-radius (clean-number (cadddr torus))))
        (torus-info-helper name big-radius small-radius)))

(define (torus-area torus)
    (let (
        (small-radius (clean-number (caddr torus)))
        (big-radius (clean-number (cadddr torus))))
        (torus-area-helper big-radius small-radius)))

(define (torus-volume torus)
    (let (
        (small-radius (clean-number (caddr torus)))
        (big-radius (clean-number (cadddr torus))))
        (torus-volume-helper big-radius small-radius)))

(define (torus-area-helper big-radius small-radius)
    (* (* 2 pi big-radius)
        (* 2 pi small-radius)))

(define (torus-volume-helper big-radius small-radius)
    (* 2 (expt pi 2) big-radius (expt small-radius 2)))

(define (torus-info-helper name big-radius small-radius)
    (let ((area (torus-area-helper big-radius small-radius))
        (volume (torus-volume-helper big-radius small-radius)))
    (display "Torus: ") (display name)
    (display ", Small Radius=") (display (rounded small-radius))
    (display ", Big Radius=") (display (rounded big-radius))
    (newline)
    (display "  Surface Area: ") (display (rounded area))
    (display ", Volume: ") (display (rounded volume))
    (newline)))
