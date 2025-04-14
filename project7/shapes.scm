(load "box.scm")
(load "sphere.scm")
(load "cylinder.scm")
(load "torus.scm")

(define pi 3.14159265358979323846)
(define shapes '())

(define global_count 0)
(define global_total 0)

(define globals_set? 0)
(define global_area_store 0)
(define global_volume_store 0)


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

                                                ; Condition

                                            ))
                                    ))
                                ((string=? action "print")
                                    (begin
                                        (if (null? conditions) (box-info current-shape)
                                            (begin


                                                ; Condition checking for print


                                            ))
                                    ))
                                ((string=? action "min")
                                    (begin
                                        (if (null? conditions)
                                            (begin
                                                (if (eq? globals_set? 0)
                                                    (begin
                                                        (set! globals_set? 1)
                                                        (set! global_area_store (box-area current-shape))
                                                        (set! global_volume_store (box-volume current-shape)))())

                                                (if (< (box-area current-shape) global_area_store) (set! global_area_store (box-area current-shape)) ())
                                                (if (< (box-volume current-shape) global_volume_store) (set! global_volume_store (box-volume current-shape)) ()))
                                            (begin


                                                ; Condition checking for min


                                            ))

                                    ))
                                ((string=? action "max")
                                    (begin
                                        (if (null? conditions)
                                            (begin
                                                (if (eq? globals_set? 0)
                                                    (begin
                                                        (set! globals_set? 1)
                                                        (set! global_area_store (box-area current-shape))
                                                        (set! global_volume_store (box-volume current-shape)))())

                                                (if (> (box-area current-shape) global_area_store) (set! global_area_store (box-area current-shape)) ())
                                                (if (> (box-volume current-shape) global_volume_store) (set! global_volume_store (box-volume current-shape)) ()))
                                            (begin


                                                ; Condition checking for max


                                            ))

                                    ))
                                ((string=? action "total")
                                    (begin
                                        (if (null? conditions)
                                            (begin
                                                (if (eq? globals_set? 0)
                                                    (begin
                                                        (set! globals_set? 1)
                                                        (set! global_area_store 0)
                                                        (set! global_volume_store 0))())

                                                (if (> (box-area current-shape) global_area_store) (set! global_area_store (box-area current-shape)) ())
                                                (if (> (box-volume current-shape) global_volume_store) (set! global_volume_store (box-volume current-shape)) ())

                                            )
                                            (begin
                                                ; Conditions

                                            ))

                                    ))
                                ((string=? action "avg")
                                    (begin
                                        (if (null? conditions)
                                            (begin
                                                (if (eq? globals_set? 0)
                                                    (begin
                                                        (set! global_count 0)
                                                        (set! globals_set? 1)
                                                        (set! global_area_store (box-area current-shape))
                                                        (set! global_volume_store (box-volume current-shape)))())

                                                (set! global_count (+ global_count 1))
                                                (set! global_area_store (+ global_area_store (box-area current-shape)))
                                                (set! global_volume_store (+ global_volume_store (box-volume current-shape))))
                                            (begin
                                                ; Conditions

                                            ))

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
                                        (if (null? conditions)
                                            (begin
                                                ; No conditions

                                            )
                                            (begin
                                                ; Conditions

                                            ))

                                    ))
                                ((string=? action "max")
                                    (begin
                                        (if (null? conditions)
                                            (begin
                                                ; No conditions

                                            )
                                            (begin
                                                ; Conditions

                                            ))

                                    ))
                                ((string=? action "total")
                                    (begin
                                        (if (null? conditions)
                                            (begin
                                                ; No conditions

                                            )
                                            (begin
                                                ; Conditions

                                            ))

                                    ))
                                ((string=? action "avg")
                                    (begin
                                        (if (null? conditions)
                                            (begin
                                                ; No conditions

                                            )
                                            (begin
                                                ; Conditions

                                            ))

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
                                        (if (null? conditions)
                                            (begin
                                                ; No conditions

                                            )
                                            (begin
                                                ; Conditions

                                            ))

                                    ))
                                ((string=? action "max")
                                    (begin
                                        (if (null? conditions)
                                            (begin
                                                ; No conditions

                                            )
                                            (begin
                                                ; Conditions

                                            ))

                                    ))
                                ((string=? action "total")
                                    (begin
                                        (if (null? conditions)
                                            (begin
                                                ; No conditions

                                            )
                                            (begin
                                                ; Conditions

                                            ))

                                    ))
                                ((string=? action "avg")
                                    (begin
                                        (if (null? conditions)
                                            (begin
                                                ; No conditions

                                            )
                                            (begin
                                                ; Conditions

                                            ))

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
                                        (if (null? conditions)
                                            (begin
                                                ; No conditions

                                            )
                                            (begin
                                                ; Conditions

                                            ))

                                    ))
                                ((string=? action "max")
                                    (begin
                                        (if (null? conditions)
                                            (begin
                                                ; No conditions

                                            )
                                            (begin
                                                ; Conditions

                                            ))

                                    ))
                                ((string=? action "total")
                                    (begin
                                        (if (null? conditions)
                                            (begin
                                                ; No conditions

                                            )
                                            (begin
                                                ; Conditions

                                            ))

                                    ))
                                ((string=? action "avg")
                                    (begin
                                        (if (null? conditions)
                                            (begin
                                                ; No conditions

                                            )
                                            (begin
                                                ; Conditions

                                            ))

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
                (set! globals_set? 0)
                (process-shapes shapes)
                (cond
                    ((string=? action "count")
                        (begin
                            (display "There are ") (display global_count) (display " shapes.") (newline)))
                    ((string=? action "min")
                        (begin
                            (display "min(Surface Area)=") (display (exact->inexact global_area_store)) (newline)
                            (display "min(Volume)=") (display (exact->inexact global_volume_store)) (newline)))
                    ((string=? action "max")
                        (begin
                            (display "max(Surface Area)=") (display (exact->inexact global_area_store)) (newline)
                            (display "max(Volume)=") (display (exact->inexact global_volume_store)) (newline)))
                    ((string=? action "avg")
                        (begin
                            (display "avg(Surface Area)=") (display (exact->inexact (/ global_area_store global_count))) (newline)
                            (display "avg(Volume)=") (display (exact->inexact (/ global_volume_store global_count))) (newline)



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
