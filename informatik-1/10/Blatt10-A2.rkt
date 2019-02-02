;; Die ersten drei Zeilen dieser Datei wurden von DrRacket eingefügt. Sie enthalten Metadaten
;; über die Sprachebene dieser Datei in einer Form, die DrRacket verarbeiten kann.
#reader(lib "DMdA-vanilla-reader.ss" "deinprogramm")((modname Blatt10-A2) (read-case-sensitive #f) (teachpacks ()) (deinprogramm-settings #(#f write repeating-decimal #t #t none explicit #f ())))
; ----------------------------------------------------------------------
; Streams (unendliche Ströme von Elementen gleicher Signatur)

; "Versprechen", ein Wert der Signatur t liefern zu können
(define promise
  (lambda (t) 
    (signature (-> t))))

; "Einlösung" (Auswertung) des Versprechens p
(: force ((promise %a) -> %a))
(define force
  (lambda (p) 
    (p)))

; Polymorphe Paare (isomorph zu `pair')
(: make-cons (%a %b -> (cons-of %a %b)))
(: head ((cons-of %a %b) -> %a))
(: tail ((cons-of %a %b) -> %b))
(define-record-procedures-parametric cons cons-of
  make-cons 
  cons?
  (head
   tail))

; Streams mit Elementen der Signatur t
(define stream-of
  (lambda (t) 
    (signature (cons-of t (promise cons)))))

(: from (number -> (stream-of number)))
(define from
  (lambda (n) 
    (make-cons n (lambda () (from (+ n 1))))))

; Erzeuge die ersten n Elemente des Strom str (Stream -> Liste)
(: stream-take (natural (stream-of %a) -> (list-of %a)))
(check-expect (stream-take 5 (from 1)) (list 1 2 3 4 5))
(check-expect (stream-take 0 (from 1)) empty)
(define stream-take
  (lambda (n str)
    (match str
      ((make-cons hd tl)
       (if (= n 0)
           empty
           (make-pair hd (stream-take (- n 1) (force tl))))))))


;;; EIGENE LOESUNG AB HIER

;Erzeugt strom nach Abbildungsforschrift
(: stream-iterate ((%a -> %a) %a -> (stream-of %a)))
( check-expect (stream-take 5 ( stream-iterate ( lambda ( x ) (+ x 2) ) 1) ) ( list 1 3 5 7 9))
(define stream-iterate
  (lambda (p x)
    (make-cons x (lambda () (stream-iterate p (p x))))
    ))

;Liefert das erste Element aus einem konvergierenden Strom s, das sich
;um weniger als d von seinem Vorgänger unterscheidet

(: stream-converge (real (stream-of real) -> real))
( check-within ( stream-converge 0.3 ( stream-iterate ( lambda ( x ) (/ x 10) ) 100)) 0.01 0.00001)
(define stream-converge
  (lambda (r s)
    (let ([t (force (tail s))])
    (if (< (abs (- (head s) (head t))) r)
        (head t)
        (stream-converge r t)))))

;Quadratwurzelberechnung nach dem Heron-Verfahren
(: approx-sqrt (real real -> real))
(check-within (approx-sqrt 15 0.01) 3.872 0.001)
(check-within (approx-sqrt 0 0.0001) 0 0.0001)
(check-within (approx-sqrt 9 0.0001) 3 0.0001)
(define approx-sqrt
  (lambda (a delta)
    (stream-converge delta (stream-iterate (lambda (x) (/ (+ x (/ a x)) 2)) (/ (+ a 1) 2)))
))