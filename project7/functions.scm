(define (clean-number str)
    (string->number (string-trim str char-set:numeric)))

(define (rounded num)
  (let* ((n (inexact->exact (round (* (exact->inexact num) 100))))
         (int-part (quotient n 100))
         (frac-part (remainder n 100)))
    (string-append
     (number->string int-part)
     "."
     (if (< frac-part 10)
         (string-append "0" (number->string frac-part))
         (number->string frac-part)))))

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

(define (print-shape shape)
    (cond
        ((string=? (cadr shape) "torus") (torus-info shape))
        ((string=? (cadr shape) "box") (box-info shape))
        ((string=? (cadr shape) "sphere") (sphere-info shape))
        ((string=? (cadr shape) "cylinder") (cylinder-info shape))))

(define (get-area shape)
    (cond
        ((string=? (cadr shape) "torus") (torus-area shape))
        ((string=? (cadr shape) "box") (box-area shape))
        ((string=? (cadr shape) "sphere") (sphere-area shape))
        ((string=? (cadr shape) "cylinder") (cylinder-area shape))))

(define (get-volume shape)
    (cond
        ((string=? (cadr shape) "torus") (torus-volume shape))
        ((string=? (cadr shape) "box") (box-volume shape))
        ((string=? (cadr shape) "sphere") (sphere-volume shape))
        ((string=? (cadr shape) "cylinder") (cylinder-volume shape))))

(define (avg-area-unconditional)
    (/ (apply + (map get-area shapes)) (length shapes)))

(define (avg-volume-unconditional)
    (/ (apply + (map get-volume shapes)) (length shapes)))

(define (total-area-unconditional)
    (apply + (map get-area shapes)))

(define (total-volume-unconditional)
    (apply + (map get-volume shapes)))
