(load "box.scm")
(load "sphere.scm")
(load "cylinder.scm")
(load "torus.scm")

(define pi 3.14159265358979323846)
(define shapes '())
(define global_count 0)
(define global_total 0)

(define (perform action filename . conditions)
    (define (process-shapes shapes-list)
      (for-each
        (lambda (current-shape)
            (let ((shape-type (car (cdr current-shape))))
                (cond
                    ((string=? shape-type "box")
                        (begin
                            (cond
                                ((string=? action "count")
                                    (begin
                                        (if (null? conditions) (set! global_count (+ global_count 1))
                                            (begin

                                            ))
                                    ))
                                ((string=? action "print")
                                    (begin
                                        (if (null? conditions) (box-info current-shape)
                                            (begin

                                            ))
                                    ))
                                ((string=? action "min")
                                    (begin


                                    ))
                                ((string=? action "max")
                                    (begin


                                    ))
                                ((string=? action "total")
                                    (begin


                                    ))
                                ((string=? action "avg")
                                    (begin


                                    ))
                            )
                        ))
                    ((string=? shape-type "sphere")
                        (begin
                            (cond
                                ((string=? action "count")
                                    (begin
                                        (if (null? conditions) (set! global_count (+ global_count 1))
                                            (begin

                                            ))
                                    ))
                                ((string=? action "print")
                                    (begin
                                        (if (null? conditions) (sphere-info current-shape)
                                            (begin

                                            ))
                                    ))
                                ((string=? action "min")
                                    (begin


                                    ))
                                ((string=? action "max")
                                    (begin


                                    ))
                                ((string=? action "total")
                                    (begin


                                    ))
                                ((string=? action "avg")
                                    (begin


                                    ))
                            )
                        ))
                    ((string=? shape-type "cylinder")
                        (begin
                            (cond
                                ((string=? action "count")
                                    (begin
                                        (if (null? conditions) (set! global_count (+ global_count 1))
                                            (begin

                                            ))
                                    ))
                                ((string=? action "print")
                                    (begin
                                        (if (null? conditions) (cylinder-info current-shape)
                                            (begin

                                            ))
                                    ))
                                ((string=? action "min")
                                    (begin


                                    ))
                                ((string=? action "max")
                                    (begin


                                    ))
                                ((string=? action "total")
                                    (begin


                                    ))
                                ((string=? action "avg")
                                    (begin


                                    ))
                            )
                        ))
                    ((string=? shape-type "torus")
                        (begin
                            (cond
                                ((string=? action "count")
                                    (begin
                                        (if (null? conditions) (set! global_count (+ global_count 1))
                                            (begin

                                            ))
                                    ))
                                ((string=? action "print")
                                    (begin
                                        (if (null? conditions) (torus-info current-shape)
                                            (begin

                                            ))
                                    ))
                                ((string=? action "min")
                                    (begin


                                    ))
                                ((string=? action "max")
                                    (begin


                                    ))
                                ((string=? action "total")
                                    (begin


                                    ))
                                ((string=? action "avg")
                                    (begin


                                    ))
                            )
                        )))))
        shapes-list))

    (if (not (file-exists? filename))
        (begin
            (display "Unable to open ") (display filename) (display " for reading.") (newline) (newline))
        (begin
            (if (null? shapes) (make-shapes filename) ())

        (if (eq? (remainder (length conditions) 3) 0)
            (begin
                ; If the number of conditions is valid
                (newline)
                (set! global_count 0)
                (set! global_total 0)
                (process-shapes shapes)
                (cond
                    ((string=? action "count")
                        (begin
                            (display "There are ") (display global_count) (display " shapes.") (newline)
                        ))


                    )


                (newline)



                )
            (begin
                (display "Incorrect number of arguments.") (newline))))))

(define (make-shapes name)
    (let ((port (open-input-file name)))
        (shapes-helper port)
        (close-input-port port)
        'done))

(define (str-split str ch)
  (let ((len (string-length str)))
    (letrec
        ((split
          (lambda (a b)
            (cond
              ((>= b len) (if (= a len) '() (list (substring str a len))))
              ((char=? ch (string-ref str b))
               (if (= a b)
                   (cons "" (split (+ 1 b) (+ 1 b)))
                   (cons (substring str a b) (split (+ 1 b) (+ 1 b)))))
              (else (split a (+ 1 b)))))))
      (split 0 0))))

(define (shapes-helper port)
    (let ((stuff (read-line port)))
        (if (eof-object? stuff)
            'done
            (begin
                (let ((shape (str-split stuff #\space)))
                    (set! shapes (append shapes (list shape))))
                (shapes-helper port)))))
