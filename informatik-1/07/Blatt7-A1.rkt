;; Die ersten drei Zeilen dieser Datei wurden von DrRacket eingefügt. Sie enthalten Metadaten
;; über die Sprachebene dieser Datei in einer Form, die DrRacket verarbeiten kann.
#reader(lib "DMdA-vanilla-reader.ss" "deinprogramm")((modname Blatt7-A1) (read-case-sensitive #f) (teachpacks ((lib "image2.rkt" "teachpack" "deinprogramm") (lib "universe.rkt" "teachpack" "deinprogramm"))) (deinprogramm-settings #(#f write repeating-decimal #f #t none explicit #f ((lib "image2.rkt" "teachpack" "deinprogramm") (lib "universe.rkt" "teachpack" "deinprogramm")))))
;Blatt7-A1

;Tuple Definition
(: make-tuple (%a %b -> (tuple-of %a %b)))
(: tuple? (any -> boolean))
(: tuple-one ((tuple-of %a %b) -> %a))
(: tuple-two ((tuple-of %a %b) -> %b))
   
(define-record-procedures-parametric tuple tuple-of
  make-tuple
  tuple?
  (tuple-one
   tuple-two))


;Teilt Liste in Tulpe auf 
(: split-list ((list-of %a) -> (tuple-of (list-of %a) (list-of %a))))
(check-expect (split-list (list 1 2 3 4 5)) (make-tuple (list 1 3 5) (list 2 4)))
(check-expect (split-list (list "a" "b")) (make-tuple (list "a") (list "b")))
(check-expect (split-list empty) (make-tuple empty empty))
(check-expect (split-list (list 1)) (make-tuple (list 1) empty))

(define split-list
  
  (lambda (l)
    (split-list-worker l empty empty)
    )
  )

;Worker von split-list
;Nimmt zu Teilende Liste [l], Teilliste1 [acc1] und Teilliste2 [acc2]
(: split-list-worker ((list-of %a) (list-of %a) (list-of %a) -> (tuple-of (list-of %a) (list-of %a))))
(check-expect (split-list-worker (list 1 2) empty empty) (make-tuple (list 1) (list 2)))
(check-expect (split-list-worker (list 1) empty empty) (make-tuple (list 1) empty))
(check-expect (split-list-worker (list 3) (list 1) (list 2)) (make-tuple (list 1 3) (list 2)))

(define split-list-worker
  (lambda (l acc1 acc2)
    (match l
      (empty (make-tuple acc1 acc2))
      ((list a) (make-tuple (append acc1 (list a)) acc2))
      ((make-pair a (make-pair b lRest)) (split-list-worker
                                          (rest (rest l))
                                          (append acc1 (list a))
                                          (append acc2 (list b))))
      )
    )
  )

;B
;Kombiniert zwei Listen in einem Tupel zu einer eigenständigen Liste
(: weave-lists ((tuple-of (list-of %a) (list-of %a)) -> (list-of %a)))
(check-expect (weave-lists (make-tuple (list 1 3 5 6) (list 2 4))) (list 1 2 3 4 5 6))
(check-expect (weave-lists (make-tuple (list 1 3) (list 2 4 5))) (list 1 2 3 4 5))
(check-expect (weave-lists (make-tuple empty (list 2 4))) (list 2 4))
(check-expect (weave-lists (make-tuple (list 2 4) empty)) (list 2 4))

(define weave-lists
  (lambda (t)
    (cond
      ((empty? (tuple-one t)) (tuple-two t))
      ((empty? (tuple-two t)) (tuple-one t))
      (else (weave-lists-worker (tuple-one t) (tuple-two t) empty))
      )
    )
  )

;Worker für weave-lists
;Nimmt zwei Listen [l1] [l2] und hängt das jeweils erste Elemenet an die dritte Liste [lo]
(: weave-lists-worker ((list-of %a) (list-of %a) (list-of %a) -> (list-of %a)))
(define weave-lists-worker
  (lambda (l1 l2 lo)
    (cond
      ((empty? l1) (append lo l2))
      ((empty? l2) (append lo l1))
      (else (weave-lists-worker (rest l1)
                                (rest l2)
                                (append lo (list (first l1) (first l2)))))
      )
    )
  )

;Überprüft ob 2 Listen identisch
(: list-equal? ((list-of real) (list-of real) -> boolean))
(check-expect (list-equal? (list 1 2 3) (list 1 2 3)) #t)
(check-expect (list-equal? (list 1 2) (list 1 2 3)) #f)
(check-expect (list-equal? (list 1 2 3) (list 1 2)) #f)
(check-expect (list-equal? empty (list 1 2 3)) #f)
(check-expect (list-equal? empty empty) #t)

(define list-equal?
  (lambda (l1 l2)
    (cond
      ((and (empty? l1) (empty? l2)) #t)
      ((or (empty? l1) (empty? l2)) #f)
      ((= (first l1) (first l2)) (list-equal? (rest l1) (rest l2)))
      (else #f)
      )
    )
  )

;C
;Checkt für alle Listen aus natürlichen Zahlen ob (weave-lists (split-list xs)) ≡ xs gilt
(check-property
 (for-all ((xs (list-of natural)))
      (list-equal? (weave-lists (split-list xs)) xs)
     )
   )
