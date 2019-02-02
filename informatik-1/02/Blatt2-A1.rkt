;; Die ersten drei Zeilen dieser Datei wurden von DrRacket eingefügt. Sie enthalten Metadaten
;; über die Sprachebene dieser Datei in einer Form, die DrRacket verarbeiten kann.
#reader(lib "DMdA-beginner-reader.ss" "deinprogramm")((modname Blatt2-A1) (read-case-sensitive #f) (teachpacks ((lib "image2.rkt" "teachpack" "deinprogramm"))) (deinprogramm-settings #(#f write repeating-decimal #f #t none explicit #f ((lib "image2.rkt" "teachpack" "deinprogramm")))))
;Parameter Namen in eckigen Klammern []
;(a) Nimmt Menge von Benzin [benzin] und die Reichweite dieser Menge [reichweite]
;und gibt den Verbrauch pro 100km zurück.
(: liters-per-hundred-kilometers (real real -> real))

(check-within (liters-per-hundred-kilometers 5 50) 10 0.001)
(check-within (liters-per-hundred-kilometers 5 100) 5 0.001)
(check-within (liters-per-hundred-kilometers 0.5 15) 3.333 0.001)

(define liters-per-hundred-kilometers
  (lambda (benzin reichweite)
    (/ (* benzin 100) reichweite)
  )
)

;(b) Nimmt eine Entfernung in Meilen [meilen] und den Verbrauch in Gallonen [gallonen]
;und gibt mögliche Reichweite in Meilen pro Gallone zurück
(: miles-per-gallon (real real -> real))

(check-within (miles-per-gallon 5 1) 5 0.001)
(check-within (miles-per-gallon 10 1) 10 0.001)
(check-within (miles-per-gallon 0.5 1) 0.5 0.001)

(define miles-per-gallon
  (lambda (meilen gallonen)
    (/ meilen gallonen)
  )
)

;(c) Umrechnungsfaktor Meile zu Kilometer
(: kilometers-per-mile rational)
(define kilometers-per-mile 1.61)


;(c) Nimmt eine Entfernung in Kilometer [kilometer] und konvertiert diese in Meilen
(: kilometers->miles (real -> real))

(check-within (kilometers->miles 1.61) 1 0.0001)
(check-within (kilometers->miles 42) 26.08695 0.0001)
(check-within (kilometers->miles 67.62) 42 0.0001)

(define kilometers->miles
  (lambda (kilometer)
    (/ kilometer kilometers-per-mile)
  )
)

;(c) Nimmt eine Entfernung in Meilen [meilen] und konvertiert diese in Kilometer
(: miles->kilometers (real -> real))

(check-within (miles->kilometers 1) 1.61 0.0001)
(check-within (miles->kilometers 26.08695) 42 0.0001)
(check-within (miles->kilometers 42) 67.62 0.0001)

(define miles->kilometers
  (lambda (meilen)
    (* meilen kilometers-per-mile)
  )
)

;(d) Umrechnungsfaktor Liter in Gallonen
(: liters-per-gallon rational)
(define liters-per-gallon 3.79)


;(d) Nimmt eine Volumen in Liter [liter] und konvertiert dieses in Gallonen
(: liters->gallons (real -> real))

(check-within (liters->gallons 3.79) 1 0.000001)
(check-within (liters->gallons 159.18) 42 0.0001)
(check-within (liters->gallons 42) 11.08179 0.00001)

(define liters->gallons
  (lambda (liter)
    (/ liter liters-per-gallon)
  )
)

;(d) Nimmt eine Volumen in Gallonen [gallonen] und konvertiert dieses in Liter
(: gallons->liters (real -> real))

(check-within (gallons->liters 1) 3.79 0.000001)
(check-within (gallons->liters 42) 159.18 0.0001)
(check-within (gallons->liters 11.08179) 42 0.0001)

(define gallons->liters
  (lambda (gallonen)
    (* gallonen liters-per-gallon)
  )
)

;(e) Nimmt einen Verbrauch in l/100km [verbrauch] an und konvertiert diesen in mi/gal
(: l/100km->mi/gal (real -> real))

(check-within (l/100km->mi/gal 10) 23.54037 0.0001)
(check-within (l/100km->mi/gal 42) 5.60485  0.0001)
(check-within (l/100km->mi/gal 5.604850636) 42 0.0001)

(define l/100km->mi/gal
  (lambda (verbrauch)
    (/ (kilometers->miles 100) (liters->gallons verbrauch))
  )
)

;(f) Nimmt einen Verbrauch in mi/gal [verbrauch] an und konvertiert diesen in l/100km
(: mi/gal->l/100km (real -> real))

(check-within (mi/gal->l/100km 1) 235.4037 0.0001)
(check-within (mi/gal->l/100km 42) 5.60485  0.0001)
(check-within (mi/gal->l/100km 5.604850636) 42 0.0001)

(define mi/gal->l/100km
  (lambda (verbrauch)
    (* 100 (/ liters-per-gallon (miles->kilometers verbrauch)))
  )
)




