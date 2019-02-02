;; Die ersten drei Zeilen dieser Datei wurden von DrRacket eingefügt. Sie enthalten Metadaten
;; über die Sprachebene dieser Datei in einer Form, die DrRacket verarbeiten kann.
#reader(lib "DMdA-vanilla-reader.ss" "deinprogramm")((modname Blatt4-A1) (read-case-sensitive #f) (teachpacks ((lib "image2.rkt" "teachpack" "deinprogramm") (lib "universe.rkt" "teachpack" "deinprogramm"))) (deinprogramm-settings #(#f write repeating-decimal #f #t none explicit #f ((lib "image2.rkt" "teachpack" "deinprogramm") (lib "universe.rkt" "teachpack" "deinprogramm")))))
;Erstellt Record-Definition eines Datums 
(: make-date (natural natural integer -> date))
(: date-day (date -> natural))
(: date-month (date -> natural))
(: date-year (date -> integer))

(define-record-procedures date
  make-date  
  date?
  (date-day  
   date-month                        
   date-year))

; Check ob das Datum möglich ist
; Monat zwischen 1 und 12
; Tag zwischen 1 und 28/30/31 (je nach Monat, über max-days) ohne Schlatjahr berücksichtigung
; Jahr eine ganze Zahl
(: calendar-date-ok? (date -> boolean))
(check-expect (calendar-date-ok? (make-date 1 1 1)) #t)
(check-expect (calendar-date-ok? (make-date 30 2 1)) #f)
(check-expect (calendar-date-ok? (make-date 30 42 1)) #f)

(define calendar-date-ok?
  (lambda (d)
    (and
     (within? 1 (date-month d) 12)
     (within? 1 (date-day d) (max-days (date-month d) #f))
     (integer? (date-year d))
     )
    )
  )

; Check ob das Datum möglich ist
; Monat zwischen 1 und 12
; Jahr eine ganze Zahl
;Tag zwischen 1 und 28/30/31 (je nach Monat, über max-days) (mit Rücksicht auf Schaltjahre)
(: calendar-date-ok/leap-year? (date -> boolean))
(check-expect (calendar-date-ok/leap-year? (make-date 1 1 1)) #t)
(check-expect (calendar-date-ok/leap-year? (make-date 30 2 2000)) #f)
(check-expect (calendar-date-ok/leap-year? (make-date 30 42 -4242)) #f)
(check-expect (calendar-date-ok/leap-year? (make-date 29 2 2000)) #t)

(define calendar-date-ok/leap-year?
  (lambda (d)
    (and
     (within? 1 (date-month d) 12)
     (integer? (date-year d))
     (within? 1 (date-day d) (max-days (date-month d) (leapyear? (date-year d))))
     )
    )
  )

; Anzahl an Tagen im Monat
; 0 falls kein gülter Monat übergeben wurde.
(: max-days (natural boolean -> (one-of 0 28 29 30 31)))
(check-expect (max-days 13 #f) 0)
(check-expect (max-days 1 #f) 31)
(check-expect (max-days 2 #t) 29)
(check-expect (max-days 2 #f) 28)

(define max-days
  (lambda (m l)
    (cond
      ((= m 1) 31)
      ((= m 2) (if l 29 28))
      ((= m 3) 31)
      ((= m 4) 30)
      ((= m 5) 31)
      ((= m 6) 30)
      ((= m 7) 31)
      ((= m 8) 31)
      ((= m 9) 30)
      ((= m 10) 31)
      ((= m 11) 30)
      ((= m 12) 31)
      (else 0)
      )
    )
  )

;Check ob Schaltjahr
(: leapyear? (integer -> boolean))
(check-expect (leapyear? 2000) #t)
(check-expect (leapyear? 2018) #f)
(check-expect (leapyear? 2100) #f)
(define leapyear?
  (lambda (y)
    (and
     (= (modulo y 4) 0)
     (or
      (not (= (modulo y 100) 0))
      (= (modulo y 400) 0)
      )
     )
    )
  )



; within? übernommen von Prof. Grust
; Liegt x zwischen l und h einschliesslich?
(: within? (integer integer integer -> boolean))
(check-expect (within? 0 4 10) #t)
(check-expect (within? 0 -2 10) #f)
(check-expect (within? 0 10 10) #t)
(define within?
  (lambda (l x h)
    (and (<= l x)
         (<= x h))))