(define pi 3.14159265358979323846)
(define shapes '())
(define condition-list '())

(define (box-info box)
    (let (
        (name (car box))
        (length (clean-number (caddr box)))
        (width (clean-number (cadddr box)))
        (height (clean-number (car (cddddr box)))))
        (box-info-helper name length width height)))

(define (box-area box)
    (let (
        (length (clean-number (caddr box)))
        (width (clean-number (cadddr box)))
        (height (clean-number (car (cddddr box)))))
        (box-area-helper length width height)))

(define (box-volume box)
    (let (
        (length (clean-number (caddr box)))
        (width (clean-number (cadddr box)))
        (height (clean-number (car (cddddr box)))))
        (box-volume-helper length width height)))

(define (box-area-helper length width height)
    (* 2 (+ (* width length)
           (* height length)
           (* height width))))

(define (box-volume-helper length width height)
    (* length width height))

(define (box-info-helper name length width height)
    (let ((area (box-area-helper length width height))
        (volume (box-volume-helper length width height)))
    (display "Box: ") (display name)
    (display ", Length=") (display (rounded length))
    (display ", Width=") (display (rounded width))
    (display ", Height=") (display (rounded height))
    (newline)
    (display "  Surface Area: ") (display (rounded area))
    (display ", Volume: ") (display (rounded volume))
    (newline)))

(define (sphere-info sphere)
    (let (
        (name (car sphere))
        (radius (clean-number (caddr sphere))))
        (sphere-info-helper name radius)))

(define (sphere-area sphere)
    (let (
        (radius (clean-number (caddr sphere))))
        (sphere-area-helper radius)))

(define (sphere-volume sphere)
    (let (
        (radius (clean-number (caddr sphere))))
        (sphere-volume-helper radius)))

(define (sphere-area-helper radius)
    (* 4 pi (expt radius 2)))

(define (sphere-area sphere)
    (let ((radius (string->number (string-trim (caddr sphere) char-set:numeric))))
        (sphere-area-helper radius)))

(define (sphere-volume sphere)
    (let ((radius (string->number (string-trim (caddr sphere) char-set:numeric))))
        (sphere-volume-helper radius)))

(define (sphere-volume-helper radius)
    (* (/ 4 3.0) pi (expt radius 3)))

(define (sphere-info-helper name radius)
    (let ((area (sphere-area-helper radius))
        (volume (sphere-volume-helper radius)))
    (display "Sphere: ") (display name)
    (display ", Radius=") (display (rounded radius))
    (newline)
    (display "  Surface Area: ") (display (rounded area))
    (display ", Volume: ") (display (rounded volume))
    (newline)))

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

(define (parse-conditions conditions)
    (if (null? conditions) '() (
        let ((key (car conditions))
            (op (cadr conditions))
            (value (caddr conditions)))
        (set! condition-list (append condition-list (list (list key op value))))
        (parse-conditions (cdddr conditions)))))

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

(define (get-type shape)
    (cadr shape))

(define (get-attribute shape attr)
    (cond
        ((string=? attr "type") (get-type shape))
        ((string=? attr "area") (get-area shape))
        ((string=? attr "volume") (get-volume shape))))

(define (avg-area-unconditional)
    (/ (apply + (map get-area shapes)) (length shapes)))

(define (avg-volume-unconditional)
    (/ (apply + (map get-volume shapes)) (length shapes)))

(define (total-area-unconditional)
    (apply + (map get-area shapes)))

(define (total-volume-unconditional)
    (apply + (map get-volume shapes)))

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
                                ((string=? action "min") (get-min-unconditional))
                                ((string=? action "max") (get-max-unconditional))
                                ((string=? action "avg") (get-avg-unconditional))
                                ((string=? action "total") (get-total-unconditional))
                                ((string=? action "count") (get-count-unconditional))
                                ((string=? action "print") (get-print-unconditional))))
                        (begin
                            (set! condition-list '())
                            (parse-conditions conditions)
                            (cond
                                ((string=? action "min") (get-min-conditional))
                                ((string=? action "max") (get-max-conditional))
                                ((string=? action "avg") (get-avg-conditional))
                                ((string=? action "total") (get-total-conditional))
                                ((string=? action "count") (get-count-conditional))
                                ((string=? action "print") (get-print-conditional))))))
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

(define (get-min-conditional)
    (let ((shapes-list (filter (lambda (s) (meets-all? s)) shapes)))
        (display "min(Surface Area)=") (display (rounded (apply min (map get-area shapes-list)))) (newline)
        (display "min(Volume)=") (display (rounded (apply min (map get-volume shapes-list)))) (newline)))

(define (andmap proc lst)
    (if (null? lst)
        #t
        (and (proc (car lst))
            (andmap proc (cdr lst)))))

(define (meets-all? shape)
    (andmap (lambda (c) (test shape c)) condition-list))

(define (test shape condition)
    (let (
        (attr (get-attribute shape (car condition)))
        (op (cadr condition))
        (val (caddr condition)))
    (cond
        ((string=? (car condition) "type")
            (begin
                (cond
                    ((string=? op "==") (string=? attr val))
                    ((string=? op "!=") (not (string=? attr val)))
                    ((string=? op ">=") (string>=? attr val))
                    ((string=? op "<=") (string<=? attr val))
                    ((string=? op ">") (string>? attr val))
                    ((string=? op "<") (string<? attr val)))))
        (else
            (begin
                (cond
                    ((string=? op "==") (= attr val))
                    ((string=? op "!=") (not (= attr val)))
                    ((string=? op ">=") (>= attr val))
                    ((string=? op "<=") (<= attr val))
                    ((string=? op ">") (> attr val))
                    ((string=? op "<") (< attr val))))))))

(define (get-max-conditional)
    (let ((shapes-list (filter (lambda (s) (meets-all? s)) shapes)))
        (display "max(Surface Area)=") (display (rounded (apply max (map get-area shapes-list)))) (newline)
        (display "max(Volume)=") (display (rounded (apply max (map get-volume shapes-list)))) (newline)))

(define (get-avg-conditional)
    (let ((shapes-list (filter (lambda (s) (meets-all? s)) shapes)))
        (display "avg(Surface Area)=") (display (rounded (/ (apply + (map get-area shapes-list)) (length shapes-list)))) (newline)
        (display "avg(Volume)=") (display (rounded (/ (apply + (map get-volume shapes-list)) (length shapes-list)))) (newline)))

(define (get-total-conditional)
    (let ((shapes-list (filter (lambda (s) (meets-all? s)) shapes)))
        (display "total(Surface Area)=") (display (rounded (apply + (map get-area shapes-list)) (length shapes-list))) (newline)
        (display "total(Volume)=") (display (rounded (apply + (map get-volume shapes-list)) (length shapes-list))) (newline)))

(define (get-count-conditional)
    (let ((shapes-list (filter (lambda (s) (meets-all? s)) shapes)))
        (display "There are ") (display (length shapes-list)) (display " shapes.") (newline) (newline)))

(define (get-print-conditional)
    (let ((shapes-list (filter (lambda (s) (meets-all? s)) shapes)))
        (map print-shape shapes-list) (newline)))
