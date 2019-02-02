;; Die ersten drei Zeilen dieser Datei wurden von DrRacket eingefügt. Sie enthalten Metadaten
;; über die Sprachebene dieser Datei in einer Form, die DrRacket verarbeiten kann.
#reader(lib "DMdA-vanilla-reader.ss" "deinprogramm")((modname Blatt12-A3) (read-case-sensitive #f) (teachpacks ((lib "image2.rkt" "teachpack" "deinprogramm") (lib "universe.rkt" "teachpack" "deinprogramm"))) (deinprogramm-settings #(#f write repeating-decimal #f #t none explicit #f ((lib "image2.rkt" "teachpack" "deinprogramm") (lib "universe.rkt" "teachpack" "deinprogramm")))))
(define-record-procedures-parametric tuple tuple-of
  make-tuple
  tuple?
  (one two))
;-------------------------------------------------------------------------------------------
;Eigene Lösung ab hier
;Splits
(: splits ((list-of %a) -> (list-of (tuple-of (list-of %a) (list-of %a)))))
( check-expect ( splits ( list 1 2 3) )
               ( list ( make-tuple empty ( list 1 2 3) )
                      ( make-tuple ( list 1) ( list 2 3) )
                      ( make-tuple ( list 1 2) ( list 3) )
                      ( make-tuple ( list 1 2 3) empty ) ) )
(define splits
  (lambda (l)
    (splits-worker (make-tuple empty l) (list (make-tuple empty l)))))

(: splits-worker ((tuple-of (list-of %a) (list-of %a))
                  (list-of (tuple-of (list-of %a) (list-of %a)))
                  -> (list-of (tuple-of (list-of %a) (list-of %a)))))
(define splits-worker
  (lambda (t out)
    (if (empty? (two t))
        out
        (let ([newT (make-tuple (append (one t) (list (first (two t)))) (rest (two t)))])
          (splits-worker newT (append out (list newT)))))))
;----------------------------------------------------------------------------------------------
;rekutsiv von hinten?
;
;(: permutations ((list-of %a) -> (list-of (list-of %a))))
(define !
  (lambda (n)
    (letrec ([fac-w (lambda (n acc)
                      (if (= n 1)
                          acc
                          (fac-w (- n 1) (* acc n))))])
      (fac-w n 1))))

#|
Ich stehe auf dem Schlauch

           ////\\\\
           |      |
          @  O  O  @
           |  ~   |     
            \ –– /         
          ___|  |___  
         /          \  
        /            \    
       /  /|      |\  \ 
      /  / |   λ  | \  \
     <  <  |      |  >  >
      \  \ |      | /  /
       \  \|______|/  /
         \_|______|_/
           |      |
           |  |   |
           |  |   |
           |__|___|
           |  |  |
           (  (  |
           |  |  |
           |  |  |
          _|  |  |_
========\(___   ___)/=====================
||||||||||||||||||||||||||||||||||||||||||
==========================================

|#
(define permutations
  (lambda (l)
    (match l
      (empty empty)
      ((list _) l)
      (_ (permw l)))))

(define permw
  (lambda (l)
    (match l
      ((list a b) (perm2 a b))
      ((make-pair a lRest) (map (lambda (x) (append (list a) x)) (permutations lRest))))))
   
(define perm2
  (lambda (a b)
    (list (list a b) (list b a))))


(define concat
  (lambda (l)
    (concat-w l empty)))
      
(define concat-w
  (lambda (l acc)
    (match l
      ;Concat deep
      ;((make-pair a lRest) (concat-w lRest (append acc (concat a))))
      ;Concat only one layer
      ((make-pair a lRest) (concat-w lRest (append acc (list a))))
      (empty acc)
      (a (list a)))))
