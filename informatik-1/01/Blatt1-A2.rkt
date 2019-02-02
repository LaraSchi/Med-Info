;; Die ersten drei Zeilen dieser Datei wurden von DrRacket eingefügt. Sie enthalten Metadaten
;; über die Sprachebene dieser Datei in einer Form, die DrRacket verarbeiten kann.
#reader(lib "DMdA-beginner-reader.ss" "deinprogramm")((modname Blatt1-A2) (read-case-sensitive #f) (teachpacks ()) (deinprogramm-settings #(#f write repeating-decimal #f #t none explicit #f ())))
;nimmt celsius, gibt fahrenheit zurück
;F = 9/5C + 32
(: celsius->fahrenheit (real -> real))
(check-within (celsius->fahrenheit 20) 68 0.0001)

(define celsius->fahrenheit
  (lambda (c)
     (+ (* 9/5 c) 32)
  )
)
;nimmt fahrenheit, gibt celsius zurück
;C = (F-32) / 9/5
(: fahrenheit->celsius (real -> real))
(check-within (fahrenheit->celsius 68) 20 0.0001)

(define fahrenheit->celsius
  (lambda (f)
     (/ (- f 32) 9/5)
  )
)