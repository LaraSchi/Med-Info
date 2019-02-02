;; Die ersten drei Zeilen dieser Datei wurden von DrRacket eingefügt. Sie enthalten Metadaten
;; über die Sprachebene dieser Datei in einer Form, die DrRacket verarbeiten kann.
#reader(lib "DMdA-vanilla-reader.ss" "deinprogramm")((modname Blatt7-A2) (read-case-sensitive #f) (teachpacks ((lib "image2.rkt" "teachpack" "deinprogramm") (lib "universe.rkt" "teachpack" "deinprogramm"))) (deinprogramm-settings #(#f write repeating-decimal #f #t none explicit #f ((lib "image2.rkt" "teachpack" "deinprogramm") (lib "universe.rkt" "teachpack" "deinprogramm")))))
;Blatt7-A2
;A
;Summe aller Elemente einer Liste
(: sum ((list-of number) -> number))
(check-expect (sum (list 1 2 3)) 6)
(check-expect (sum (list 1)) 1)
(check-expect (sum empty) 0)
(check-within (sum (list 1/3 1/3 1/3)) 1 0.001)
(check-within (sum (list 1 -1 1 -1)) 0 0.001)

(define sum
  (lambda (l)
    (sum-worker l 0)
    )
  )

;Worker für sum
;Addiert das erste Element der Liste [l] auf die übergebene Zahl [n]
;Ruft sich selbst mit Restliste und neuer Zahl auf
(: sum-worker ((list-of number) number -> number))
(check-expect (sum-worker (list 1 2 3) 0) 6)
(check-expect (sum-worker (list 1) 0) 1)
(check-expect (sum-worker empty 0) 0)
(check-within (sum-worker (list 1/3 1/3 1/3) 0) 1 0.001)
(check-expect (sum-worker (list 1) 1) 2)

(define sum-worker
  (lambda (l n)
    (match l
      (empty n)
      (_ (sum-worker (rest l) (+ (first l) n))) ;Addiert erstes Element auf n -> sum-worker mit neuem n und Rest der Liste
      )
    )
  )

;B
;Teilt natürliche Zahl [n] in Ziffern auf (von Rechts nach Links)
(: digits (natural -> (list-of natural)))
(check-expect (digits 1024) (list 4 2 0 1))
(check-expect (digits 10) (list 0 1))
(check-expect (digits 0) (list 0))
(check-expect (digits 1) (list 1))

(define digits
  (lambda (n)
    (match n
      (0 (list 0))
      (_ (digits-worker n empty))
      )
    )
  )

;Worker für digits
;Nimmt natürliche Zahl [n] und Liste [l], fügt letzte Ziffer von Zahl [n] der Liste [l] hinzu
;Ruft sich selbst mit neuer Zahl (ohne letzte Ziffer) und neuer Liste auf
(: digits-worker (natural (list-of natural) -> (list-of natural)))
(check-expect (digits-worker 1024 empty) (list 4 2 0 1))
(check-expect (digits-worker 10 empty) (list 0 1))
(check-expect (digits-worker 0 empty) empty)
(check-expect (digits-worker 1 empty) (list 1))
(check-expect (digits-worker 1 (list 2)) (list 2 1))

(define digits-worker
  (lambda (n l) ;number list
    (let ([modr (modulo n 10)])                     ;Sei modr = Rest nach Teilung durch 10
      (match n
        (0 l)                                       ;Endbedingung, gebe Liste zurück
        (_ (digits-worker (/ (- n modr) 10)         ;Berechne 'neue Zahl' Bsp.: (1024 - 4) / 10 = 102
                          (append l (list modr))))  ;Füge modr der Liste l hinzu
        )
      )
    )
  )

;C
;Verdoppelt jede zweite Zahl in Liste [l]
(: double-every-other-number ((list-of number) -> (list-of number)))
(check-expect (double-every-other-number (list 1 2 3 4 5)) (list 1 4 3 8 5))
(check-expect (double-every-other-number (list 5 6)) (list 5 12))
(check-expect (double-every-other-number (list 1)) (list 1))
(check-expect (double-every-other-number empty) empty)

(define double-every-other-number
  (lambda (l)
    (match l
      (empty empty)
      ((list _) l)
      (_ (deon-worker l empty))
      )
    )
  )

;Worker für double-every-other-number
;Nimmt Liste [li] und hängt erste zwei Elemente (mit dem Zweiten verdoppelt) an Liste [lo] an
;ruft sich selber mit li ohne ersten zwei Elementen und neuer lo auf
(check-expect (deon-worker (list 5 6) empty) (list 5 12))
(check-expect (deon-worker (list 1) empty) (list 1))
(check-expect (deon-worker empty (list 1)) (list 1))
(check-expect (deon-worker empty empty) empty)

(define deon-worker
  (lambda (li lo) ;list-in list-out
    (match li
      (empty lo)
      ((make-pair a empty) (append lo (list a)))
      ((make-pair a (make-pair b liRest)) (deon-worker (rest (rest li))
                                                       (append lo (list a (* 2 b)))))
      )
    )
  )

;D
;wendet (digits) auf jedes Element > 9 der Liste [l] an
(: map-digits ((list-of natural) -> (list-of (list-of natural))))
(check-expect (map-digits (list 2 13 9)) (list (list 2) (list 3 1) (list 9)))
(check-expect (map-digits (list 10 0 123)) (list (list 0 1) (list 0) (list 3 2 1)))
(check-expect (map-digits empty) empty)

(define map-digits
  (lambda (l)
    (map (lambda (e)           ;(map <p> <list>) -> wendet Prozedur <p> 'auf' jedes Element von <list> an 
           (if (> e 9)         ;(if e > 9) -> digits wird nur angewand wenn e 2 oder mehr Ziffern
               (digits e)      ;~2.5 mal schneller als ohne (Mittelwert aus 1500 Tests)
               (list e))) l)   ;wenn (e <= 9) mache nur (list e)
    )
  )


;E
;Hängt alle Teillisten einer Liste an neue Liste an
(: concat ((list-of (list-of %a)) -> (list-of %a)))
(check-expect (concat (list (list 1 2) (list 3 4) (list 5))) (list 1 2 3 4 5))
(check-expect (concat (list (list 1) (list 2) (list 3))) (list 1 2 3))
(check-expect (concat empty) empty)

(define concat
  (lambda (l)
    (concat-worker l empty)
    )
  )

;Worker für concat
(check-expect (concat-worker (list (list 1 2) (list 3 4) (list 5)) empty) (list 1 2 3 4 5))
(check-expect (concat-worker (list (list 3 4) (list 5)) (list 1 2)) (list 1 2 3 4 5))
(check-expect (concat-worker (list empty) (list 1)) (list 1))
(check-expect (concat-worker empty empty) empty)

(: concat-worker ((list-of %a) (list-of %a) -> (list-of %a)))
(define concat-worker
  (lambda (li lo) ;listin listout
    (match li
      (empty lo)
      (_ (concat-worker (rest li) (append lo (first li)))) ;Hängt erstes Element von li an lo an, wiederhohle mit Rerstliste von li bis lo = empty
      )
    )
  )

;LUHN Check
(: luhn-check (natural -> boolean))
(check-expect (luhn-check 0) #t)
(check-expect (luhn-check 1) #f)
(check-expect (luhn-check 5678) #t)
(check-expect (luhn-check 6789) #f)
(check-expect (luhn-check 446667651) #t)
(check-expect (luhn-check 4563960122001999) #t)
(check-expect (luhn-check 4563960122001998) #f)
(define luhn-check
  (lambda (n)
    (= (modulo (sum (concat (map-digits (double-every-other-number (digits n))))) 10) 0)
    )
  )
  
