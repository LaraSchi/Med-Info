;; Die ersten drei Zeilen dieser Datei wurden von DrRacket eingefügt. Sie enthalten Metadaten
;; über die Sprachebene dieser Datei in einer Form, die DrRacket verarbeiten kann.
#reader(lib "DMdA-beginner-reader.ss" "deinprogramm")((modname Blatt2-A2) (read-case-sensitive #f) (teachpacks ((lib "image2.rkt" "teachpack" "deinprogramm") (lib "universe.rkt" "teachpack" "deinprogramm"))) (deinprogramm-settings #(#f write repeating-decimal #f #t none explicit #f ((lib "image2.rkt" "teachpack" "deinprogramm") (lib "universe.rkt" "teachpack" "deinprogramm")))))
;Gibt zurück ob das Schiff den Wasserfall hinunterfällt (#t) oder nicht (#f)
;Nimmt die Fließgeschwindigkeit des Schiffes  [vschiff] und die des Flusses [vfluss]
(: plunges? (real real -> boolean))
(check-expect (plunges? 5 1.5) #f)
(check-expect (plunges? 5 2.5) #f)
(check-expect (plunges? 5 2.5001) #t)

(define plunges?
  (lambda (vschiff vfluss)
    (> (drift vschiff vfluss 400) 200)
    )
  )

;Berechnet den Drift des Schiffes in Flussabwärts
;Nimmt die Fließgeschwindigkeit des Schiffes  [vschiff] und die des Flusses [vfluss] und die gefahrene Strecke [strecke]
(: drift (real real real -> real))
(check-within (drift 5 2.5 400) 200 0.01)
(check-within (drift 1 1 1) 1 0.01)
(check-within (drift 5 1.5 400) 120 0.01)
(define drift
  (lambda (vschiff vfluss strecke)
    (* (/ strecke vschiff) vfluss)
    )
  )

;ANIMATION
;Boat and river Speed
(define vboat 5)
(define vriver 1.5)

;River
(define river-width 440)
(define river-height 240)
(define river (rectangle river-width river-height "solid" "blue"))


;Border
(define border-width 20)
(define border-height 240)
(define border-left (rectangle border-width border-height "solid" "darkgreen"))
(define border-right (rectangle border-width border-height "solid" "ForestGreen"))

;ETA
(: ETA number)
(define ETA (/ (- river-width (* 2 border-width)) vboat))
  
;Wasserfall
(define wasserfall-width 440)
(define wasserfall-height 21)
(: wasserfall (natural -> image))
(define wasserfall
  (lambda (sekunden)
    ;intervall (jede 5 sekunden)
    (if (< (remainder sekunden 10) 5)
        (overlay/offset
         (overlay/offset
          (rectangle wasserfall-width (/ wasserfall-height 3) "solid" "SkyBlue")
          0
          (/ wasserfall-height 3)
          (rectangle wasserfall-width wasserfall-height "solid" "CadetBlue")
          )
         0
         (* (/ wasserfall-height 3) 2)
         (rectangle wasserfall-width (/ wasserfall-height 3) "solid" "SkyBlue")
         )
        (overlay/offset
         (overlay/offset
          (rectangle wasserfall-width (/ wasserfall-height 3) "solid" "CadetBlue")
          0
          (/ wasserfall-height 3)
          (rectangle wasserfall-width wasserfall-height "solid" "SkyBlue")
          )
         0
         (* (/ wasserfall-height 3) 2)
         (rectangle wasserfall-width (/ wasserfall-height 3) "solid" "CadetBlue")
         )
        )
    )
  )

;River + Border + Wassefall
(: river-with-border-and-wasserfall (natural -> image))
(define river-with-border-and-wasserfall
  (lambda (sekunden)
    (overlay/align "middle" "bottom"
                  (wasserfall sekunden)
                  (overlay/align "right" "middle"
                                 border-right
                                 (overlay/align "left" "middle"
                                                border-left
                                                river
                                                )
                                 )
                  )
    )
  )
    
  
;Boot
(define boat-width 20)
(define boat-height 10)
(define boat (rectangle boat-width boat-height "solid" "brown"))


    
(: crossing (natural -> image))
(define crossing
  (lambda (sekunden)
    (if (< sekunden ETA)
    (underlay/offset
     (river-with-border-and-wasserfall sekunden)
     (-(* vboat sekunden) 200)
     (-(* vriver sekunden) 110)
     boat
     )
     (underlay/offset
     (river-with-border-and-wasserfall sekunden)
     (-(* vboat ETA) 200)
     (-(* vriver ETA) 110)
     boat
     )
    )
  )
)