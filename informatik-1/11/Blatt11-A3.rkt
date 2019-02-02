;; Die ersten drei Zeilen dieser Datei wurden von DrRacket eingefügt. Sie enthalten Metadaten
;; über die Sprachebene dieser Datei in einer Form, die DrRacket verarbeiten kann.
#reader(lib "DMdA-vanilla-reader.ss" "deinprogramm")((modname Blatt11-A3) (read-case-sensitive #f) (teachpacks ((lib "image2.ss" "teachpack" "deinprogramm") (lib "universe.ss" "teachpack" "deinprogramm"))) (deinprogramm-settings #(#f write repeating-decimal #f #t none explicit #f ((lib "image2.ss" "teachpack" "deinprogramm") (lib "universe.ss" "teachpack" "deinprogramm")))))
; Vorgegebene Definitionen: Blatt 11 vom 18.1.19
; Aufgabe 3: Suchbäume


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


; Falte Baum t bzgl. z und c
(: btree-fold (%b (%b %a %b -> %b) (btree-of %a) -> %b))

(check-expect (btree-fold 5 (lambda (left label right) 5) the-empty-tree) 5) 
(check-expect (btree-fold 1 (lambda (left label right) (+ left right)) (make-leaf "l1")) 2) 
(check-expect (btree-fold 1 (lambda (left label right) (+ left right)) (make-node (make-leaf "l1") "n1" (make-leaf "l2"))) 4)

(define btree-fold
  (lambda (z c t)
    (match t
      ((make-empty-tree) z)
      ((make-node left label right)
       (c (btree-fold z c left)
          label
          (btree-fold z c right))))))



; Exemplarische Suchbäume

; Korrekter Suchbaum
(: t1 (btree-of integer))
(define t1
  (make-node (make-node (make-leaf -4)
                        1
                        (make-leaf 3))
             12
             (make-node (make-leaf 13)
                        16
                        (make-leaf 20))))

; Kaputter Suchbaum (-4 < 1 und rechts(1) = -4)
(: t2 (btree-of integer))
(define t2
  (make-node (make-node (make-leaf 10)
                        1
                        (make-leaf -4))
             12
             (make-node (make-leaf 13)
                        16
                        (make-leaf 200))))

(: t22 (btree-of integer))
(define t22
  (make-node (make-node (make-leaf 0)
                        1
                        (make-leaf 0))
             12
             (make-node (make-leaf 13)
                        16
                        (make-leaf 200))))

; Kaputter Suchbaum (10 doppelt)
(: t3 (btree-of integer))
(define t3
  (make-node (make-node (make-leaf -4)
                        1
                        (make-leaf 10))
             12
             (make-node (make-leaf 10)
                        16
                        (make-leaf 200))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Eigene Lösung ab hier
;Min node of btree
(: btree-min ((btree-of real) -> real))
(define btree-min
  (lambda (bt) 
    (btree-fold +inf.0 (lambda (l n r) (min l n r)) bt)))

;Max node of btree
(: btree-max ((btree-of real) -> real))
(define btree-max
  (lambda (bt) 
    (btree-fold -inf.0 (lambda (l n r) (max l n r)) bt)))

(: search-tree? ((btree-of real) -> boolean))
(check-expect (search-tree? t1) #t)
(check-expect (search-tree? t2) #f)
(check-expect (search-tree? t22) #f)
(check-expect (search-tree? t3) #f)
(: search-tree? ((btree-of real) -> boolean))
(define search-tree?
  (lambda (bt)
    (match bt
      ((make-empty-tree) #t)
      ((make-node l n r) (and (< (btree-max l) n (btree-min r))
                              (search-tree? l)
                              (search-tree? r))
                         ))))

;Signatur Binär-Suchbaum
;Muss binärbaum und suchbaum sein
(define searchtree-of
  (lambda (bt)
    (signature (combined
                (btree-of bt)
                (predicate search-tree?)))))

;Schaut ob zahl in Suchbaum vorhanden
(: searchtree-member? (integer (searchtree-of integer) -> boolean))
(check-expect (searchtree-member? 16 t1) #t)
(check-expect (searchtree-member? 3 t1) #t)
(check-expect (searchtree-member? -4 t1) #t)
(check-expect (searchtree-member? 5 t1) #f)

(define searchtree-member?
  (lambda (int bt)
    (match bt
      ((make-empty-tree) #f)
      ((make-node l n r) (cond
                           ((= int n) #t)
                           ((< int n) (searchtree-member? int l))
                           (else (searchtree-member? int r)))))))

(: searchtree-insert (integer (searchtree-of integer)-> (searchtree-of integer)))
(define searchtree-insert
  (lambda (int bt)
    (if (searchtree-member? int bt)
        bt
        (sti-w int bt))))

(: sti-w (integer (searchtree-of integer)-> (searchtree-of integer)))
(define sti-w
  (lambda (int bt)
    (match bt
      ((make-empty-tree) (make-leaf int))
      ((make-node l n r) (cond
                           ((< int n) (make-node (sti-w int l) n r))
                           (else (make-node l n  (sti-w int r))))))))

;Liste zu Binärbaum
(: list->searchtree ((list-of integer)-> (searchtree-of integer)))
(check-expect (list->searchtree (list -4 3 1 13 20 16 12)) t1)
(check-expect (list->searchtree (list -4 13 3 1 16 13 20 16 12)) t1) ;T1 mit doppelten
(define list->searchtree
  (lambda (l)
    (fold the-empty-tree (lambda (x lRest) (searchtree-insert x lRest)) l)))

;Entfernt element aus Suchbaum
(: searchtree-delete (integer (searchtree-of integer)-> (searchtree-of integer)))

(define searchtree-delete
  (lambda (int bt)
    (match bt
      ((make-node l n r)
       (cond
         ((< int n) (make-node (searchtree-delete int l) n r))
         ((> int n) (make-node l n (searchtree-delete int r)))
         ((and (empty-tree? l) (empty-tree? r)) the-empty-tree)
         ((empty-tree? l) r)
         ((empty-tree? r) l)
         (else (let ([minr (btree-min r)])
                 (make-node l                                     ;Nehme kleinstes von rechts und ersetzte damit das zu löschende (ist der erste knoten)
                            minr                                  ;Lösche das kleinste von rechts      
                            (searchtree-delete minr r))
                 )))))))

        
      
