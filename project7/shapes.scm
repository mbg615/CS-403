(load "box.scm")
(load "sphere.scm")
(load "cylinder.scm")
(load "torus.scm")

(define shapes '())

(define (perform action filename . conditions)
    (define (process-shapes shapes-list) ; local parameter lol
      (for-each
        (lambda (current-shape)
          (display "Processing sublist: ")
          (display current-shape)
          (newline))
        shapes-list))

    (if (not (file-exists? filename))
        ( begin
            (display "Unable to open ") (display filename) (display " for reading.") (newline))
        ( begin
            (if (null? shapes)
                ( begin
                    (make-shapes filename))
                ( begin
                    (display "Shapes not null")))

        (if (eq? (remainder (length conditions) 3) 0)
            ( begin
                ; If the number of conditions is valid

                (newline)
                (process-shapes shapes)
                (newline)


                (display "Conditions: ") (display (length conditions)) (newline)

                ; (newline)
                ; (let ((myShape (car shapes)))
                ;     (display (car myShape)))
                ; (newline)
                ; (let ((myShape (car (cdr shapes))))
                ;     (display (car myShape)))
                ; (newline)
                ; (let ((myShape (car (cdr (cdr shapes)))))
                ;     (display (car myShape)))
                ;;; Further logic here


                )
            ( begin
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
