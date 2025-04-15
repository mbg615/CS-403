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
