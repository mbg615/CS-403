(load "functions.scm")
(load "box.scm")
(load "sphere.scm")
(load "cylinder.scm")
(load "torus.scm")

(define pi 3.14159265358979323846)
(define shapes '())

(define (perform action filename . conditions)
    (if (not (file-exists? filename))
        (begin
            ; File doesn't exist
            (display "Unable to open ") (display filename) (display " for reading.") (newline) (newline))
        (begin
            ; File exists
            (if (null? shapes) (make-shapes filename) ())

            (if (eq? (remainder (length conditions) 3) 0)
                (begin
                    (display "Correct number of arguments.") (newline) (newline)
                    ; Valid amout of arguments
                    ;
                    ; (get-avg)
                    (get-print)

                    (for-each
                        (lambda (shape)
                            (newline)
                            ; (display "Shape: ")
                            ; (display (car shape))
                            ; (newline)
                            ; (get-max)
                            ; (get-avg)
                            ; (print-shape shape)
                        )
                        shapes)


                )
                (begin
                    (display "Incorrect number of arguments.") (newline) (newline)))

            )))

(define (get-min-unconditional)
    (display "min(Surface Area)=") (display (rounded (apply min (map area-shape shapes)))) (newline)
    (display "min(Volume)=") (display (rounded (apply min (map volume-shape shapes)))) (newline))

(define (get-max-unconditional)
    (display "max(Surface Area)=") (display (rounded (apply max (map area-shape shapes)))) (newline)
    (display "max(Volume)=") (display (rounded (apply max (map volume-shape shapes)))) (newline))

(define (get-avg-unconditional)
    (display "avg(Surface Area)=") (display (rounded (avg-area-unconditional))) (newline)
    (display "avg(Volume)=") (display (rounded (avg-volume-unconditional))) (newline))

(define (get-total-unconditional)
    (display "total(Surface Area)=") (display (rounded (total-area-unconditional))) (newline)
    (display "total(Volume)=") (display (rounded (total-volume-unconditional))) (newline))

(define (get-count-unconditional)
    (display (length shapes)))

(define (get-print)
    (map print-shape shapes) (newline))

(define (avg-area-unconditional)
    (/ (apply + (map area-shape shapes)) (length shapes)))

(define (avg-volume-unconditional)
    (/ (apply + (map volume-shape shapes)) (length shapes)))

(define (total-area-unconditional)
    (apply + (map area-shape shapes)))

(define (total-volume-unconditional)
    (apply + (map volume-shape shapes)))
