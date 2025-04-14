(define (box-info box)
    (box-info-helper
        (car box)
        (string->number (caddr box))
        (string->number (cadddr box))
        (string->number (string-trim (car (cddddr box)) char-set:numeric))))

(define (box-area length width height)
    (* 2 (+ (* width length)
           (* height length)
           (* height width))))

(define (box-volume length width height)
    (* length width height))

(define (box-test cond-list area volume)
  (if (null? cond-list)
      #t
      (let ((name (car cond-list))
            (op (cadr cond-list))
            (value (caddr cond-list)))
        (if (not (compare name op value area volume "box"))
            #f
            (box-test (cdddr cond-list) area volume)))))

(define (box-info-helper name length width height)
    (let ((area (box-area length width height))
        (volume (box-volume length width height)))
    (display "Box: ") (display name)
    (display ", Length=") (display (exact->inexact length))
    (display ", Width=") (display (exact->inexact width))
    (display ", Height=") (display (exact->inexact height))
    (newline)
    (display "  Surface Area: ") (display (exact->inexact area))
    (display ", Volume: ") (display (exact->inexact volume))
    (newline)))
