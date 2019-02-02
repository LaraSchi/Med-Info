;; Die ersten drei Zeilen dieser Datei wurden von DrRacket eingefügt. Sie enthalten Metadaten
;; über die Sprachebene dieser Datei in einer Form, die DrRacket verarbeiten kann.
#reader(lib "DMdA-beginner-reader.ss" "deinprogramm")((modname Blatt1-A1) (read-case-sensitive #f) (teachpacks ()) (deinprogramm-settings #(#f write repeating-decimal #f #t none explicit #f ())))
; #t wenn der Abstand zwischen a und b kleiner-gleich eps ist
; #f wenn der Abstand zwischen a und b größer eps ist
(: equal-eps (real real real -> boolean))

(check-expect (equal-eps 0 1 1) #t)
(check-expect (equal-eps -1 1 1) #f)
(check-expect (equal-eps 0 1 1) #t)
(check-expect (equal-eps -1 0 1) #t)

(define equal-eps
  (lambda (a b eps)
     (<= (abs (- a b))
         eps
     )
  )
)