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
                    (if (null? conditions)
                        (begin
                            ; No conditions
                            (cond
                                ((string=? action "min")(get-min-unconditional))
                                ((string=? action "max")(get-max-unconditional))
                                ((string=? action "avg")(get-avg-unconditional))
                                ((string=? action "total")(get-total-unconditional))
                                ((string=? action "count")(get-count-unconditional))
                                ((string=? action "print")(get-print-unconditional))))
                        (begin
                            ; Conditions


                            ))

                    (for-each
                        (lambda (shape)
                            (newline)


                        )
                        shapes)

                )
                (begin
                    (display "Incorrect number of arguments.") (newline) (newline))))))

(define (get-min-unconditional)
    (display "min(Surface Area)=") (display (rounded (apply min (map get-area shapes)))) (newline)
    (display "min(Volume)=") (display (rounded (apply min (map get-volume shapes)))) (newline))

(define (get-max-unconditional)
    (display "max(Surface Area)=") (display (rounded (apply max (map get-area shapes)))) (newline)
    (display "max(Volume)=") (display (rounded (apply max (map get-volume shapes)))) (newline))

(define (get-avg-unconditional)
    (display "avg(Surface Area)=") (display (rounded (avg-area-unconditional))) (newline)
    (display "avg(Volume)=") (display (rounded (avg-volume-unconditional))) (newline))

(define (get-total-unconditional)
    (display "total(Surface Area)=") (display (rounded (total-area-unconditional))) (newline)
    (display "total(Volume)=") (display (rounded (total-volume-unconditional))) (newline))

(define (get-count-unconditional)
    (display "There are ") (display (length shapes)) (display " shapes.") (newline))

(define (get-print-unconditional)
    (map print-shape shapes) (newline))
