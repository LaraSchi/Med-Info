;; Die ersten drei Zeilen dieser Datei wurden von DrRacket eingefügt. Sie enthalten Metadaten
;; über die Sprachebene dieser Datei in einer Form, die DrRacket verarbeiten kann.
#reader(lib "DMdA-vanilla-reader.ss" "deinprogramm")((modname Blatt12-A2) (read-case-sensitive #f) (teachpacks ((lib "image2.rkt" "teachpack" "deinprogramm") (lib "universe.rkt" "teachpack" "deinprogramm"))) (deinprogramm-settings #(#f write repeating-decimal #f #t none explicit #f ((lib "image2.rkt" "teachpack" "deinprogramm") (lib "universe.rkt" "teachpack" "deinprogramm")))))
(define-record-procedures-parametric tuple tuple-of
  make-tuple
  tuple?
  (one two))

;teilt liste in der mitte
(: split ((list-of %a) -> (tuple-of (list-of %a) (list-of %a))))
(check-expect (split (list 1 4 7 2)) (make-tuple (list 1 4) (list 7 2)))
(check-expect (split (list 1 4 7)) (make-tuple (list 1 4) (list 7)))
(define split
  (lambda (l)
    (if (empty? l)
        (make-tuple empty empty)
        ;worker liste acc (hälfte aufgerundet)
        (split-w l empty (ceiling (/ (length l) 2))))))

;Worker für Split
(: split-w ((list-of %a) (list-of %a) natural -> (tuple-of (list-of %a) (list-of %a))))
(check-expect (split-w (list 1 4 7 2) empty 2) (make-tuple (list 1 4) (list 7 2)))
(check-expect (split-w (list 1) empty 0) (make-tuple empty (list 1)))
(define split-w
  (lambda (l acc n);liste acc hälfte aufgerundet
    (if (= n 0)
        (make-tuple acc l)
        (split-w (rest l) (append acc (list (first l))) (- n 1)))))

;fügt zwei listen nach kriterium zusammen
(: merge-by ((%a %a -> boolean) (list-of %a) (list-of %a) -> (list-of %a)))
(check-expect (merge-by < (list 1 ) (list 3 6)) (list 1 3 6))
(check-expect (merge-by < (list 1 9) (list 0 0)) (list 0 0 1 9))
(check-expect (merge-by < (list 1 5 7) (list 3 4 5 5 6)) (list 1 3 4 5 5 5 6 7))
(define merge-by
  (lambda (lt? l1 l2)
    (merge-by-worker lt? l1 l2 empty)))

;Worker für Merge-by
(: merge-by-worker ((%a %a -> boolean) (list-of %a) (list-of %a) (list-of %a) -> (list-of %a)))
(define merge-by-worker
  (lambda (lt? l1 l2 acc)
    (cond
      ((and (empty? l1) (empty? l2)) acc); sollte nie eintreten
      ((empty? l1) (append acc l2))
      ((empty? l2) (append acc l1))   
      (else (let ([f1 (first l1)]
                  [f2 (first l2)])
              (if (lt? f1 f2)
                  (merge-by-worker lt? (rest l1) l2  (append acc (list f1)))
                  (merge-by-worker lt? l1 (rest l2)  (append acc (list f2)))))))))

;Sortiert liste
(: mergesort ((%a %a -> boolean) (list-of %a) -> (list-of %a)))
(check-expect (mergesort < (list  8 4 6 5 9 0 2 3 3 1 9 7)) (list 0 1 2 3 3 4 5 6 7 8 9 9))
(check-expect (mergesort < empty) emtpy)
(check-expect (mergesort < (list 1) (list 1)))
(define mergesort
  (lambda (p l)
    (let ([sp (split l)])
      (if (<= 2 (length l))
          (merge-by p (mergesort p (one sp)) (mergesort p (two sp)))
          l))))
