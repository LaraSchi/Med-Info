;; Die ersten drei Zeilen dieser Datei wurden von DrRacket eingefügt. Sie enthalten Metadaten
;; über die Sprachebene dieser Datei in einer Form, die DrRacket verarbeiten kann.
#reader(lib "DMdA-vanilla-reader.ss" "deinprogramm")((modname Blatt11-A2) (read-case-sensitive #f) (teachpacks ()) (deinprogramm-settings #(#f write repeating-decimal #f #t none explicit #f ())))
; Vorgegebene Definitionen: Blatt 11 vom 18.1.19
; Aufgabe 2: Parser


; Ein Knoten (node) besteht aus
; - einem linken Zweig (left-branch)
; - einer Markierung (label) und
; - einem rechten Zweig (right-branch)
(: make-node (%a %b %c -> (node-of %a %b %c)))
(: node-left-branch ((node-of %a %b %c) -> %a))
(: node-label ((node-of %a %b %c) -> %a))
(: node-right-branch ((node-of %a %b %c) -> %c))

(define-record-procedures-parametric node node-of
  make-node
  node?
  (node-left-branch
   node-label
   node-right-branch))


; Ein leerer Baum (empty-tree) besitzt
; keine weiteren Eigenschaften
(: make-empty-tree (-> empty-tree))

(define-record-procedures empty-tree
  make-empty-tree
  empty-tree?
  ())


; Signatur für Binärbäume (btree-of t) mit Markierungen der Signatur t
; (im linken/rechten Zweig jedes Knotens findet sich jeweils wieder
; ein Binärbaum)
(define btree-of
  (lambda (t)
    (signature (mixed empty-tree
                      (node-of (btree-of t) t (btree-of t))))))
;                              \__________/   \__________/
;                                  ↑               ↑
;                                 zweifache Rekursion, s. (list-of t)


; Erzeuge einen leeren Baum
(: the-empty-tree empty-tree)
(define the-empty-tree (make-empty-tree))


; Erzeuge einen Blattknoten, d.h. beide Zweige sind je ein leerer Baum
(: make-leaf (%a -> (btree-of %a)))
(define make-leaf
  (lambda (x)
    (make-node the-empty-tree x the-empty-tree)))


; Filtert eine Liste gegeben entsprechendem Prädikat
(: filter ((%a -> %b) (list %a) -> (list %b)))

(define filter
  (lambda (p xs)
    (match xs
      (empty empty)
      ((make-pair hd tl)
       (if (p hd)
           (make-pair hd (filter p tl))
           (filter p tl))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;
; Eigene Lösung ab hier
(define s1 "(_1_)")
(define l1 (string->strings-list s1))
(define s2 "(((_1_)2 _)3(_4_))")
(define l2 (string->strings-list s2))
(define s3 "((_2_)3(_4(_5_)))")
(define l3 (string->strings-list s3))
;damaged
(define s4 "((_2_)4_4(_5_)))")
(define l4 (string->strings-list s4))

;(: btree-parse (string -> (btree-of string)))
(define btree-parse
  (lambda (s)
    (let ([bt (worker empty (emptify                                     ;replace "_" with empty tree
                             (filter (lambda (x) (not (string=? " " x))) ;Whitespace filtering
                                     (string->strings-list s)            ;String to List
                                     )))])
      (if (= (length bt) 1)
          (first bt)
          (violation "Check your syntax")))))

;If (list (aBc)... -> (list (node a B c)...)
;Else #f
(define btree-last
  (lambda (l)
    (match l
      ((make-pair "(" (make-pair a (make-pair b (make-pair c (make-pair ")" restList)))))
       (make-pair (make-node a b c) restList))
      (_ #f))))

;replaces _ with empty tree
(define emptify
  (lambda (l)
    (map (lambda (a) (match a
                       ("_" empty-tree)
                       (_ a)))
         l)))

;Worker for btree-parse
(define worker
  (lambda (front l)
    (let ([btl (btree-last l)])
      (cond
        ((empty? l) front)                                               ;Stoppkritrium
        ((false? btl) (worker (append front (list (first l))) (rest l))) ;Liste fängt nicht mit (***) an => gehe eins tiefer rein
        (else (worker empty (append front btl))))                        ;ersetzt (***) durch node
      )))


