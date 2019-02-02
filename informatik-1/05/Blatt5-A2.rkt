;; Die ersten drei Zeilen dieser Datei wurden von DrRacket eingefügt. Sie enthalten Metadaten
;; über die Sprachebene dieser Datei in einer Form, die DrRacket verarbeiten kann.
#reader(lib "DMdA-beginner-reader.ss" "deinprogramm")((modname Blatt5-A2) (read-case-sensitive #f) (teachpacks ((lib "image2.rkt" "teachpack" "deinprogramm") (lib "universe.rkt" "teachpack" "deinprogramm"))) (deinprogramm-settings #(#f write repeating-decimal #f #t none explicit #f ((lib "image2.rkt" "teachpack" "deinprogramm") (lib "universe.rkt" "teachpack" "deinprogramm")))))
;2
;Kreis (Radius[rad], Farbe[color])
(: make-kreis (real string -> kreis))
(: kreis? (any -> boolean))
(: kreis-rad (kreis -> real))
(: kreis-color (kreis -> string))
(define-record-procedures kreis
  make-kreis
  kreis?
  (kreis-rad
   kreis-color)
  )

;Reckteck (Breite[width], Höhe[height], Farbe[color])
(: make-rechteck (real real string -> rechteck))
(: rechteck? (any -> boolean))
(: rechteck-width (rechteck -> real))
(: rechteck-height (rechteck -> real))
(: rechteck-color (rechteck -> string))
(define-record-procedures rechteck
  make-rechteck
  rechteck?
  (rechteck-width
   rechteck-height
   rechteck-color)
  )

;Dreieck (Höhe[height], Farbe[color])
(: make-dreieck (real string -> dreieck))
(: dreieck? (any -> boolean))
(: dreieck-width (dreieck -> real))
(: dreieck-color (dreieck -> string))
(define-record-procedures dreieck
  make-dreieck
  dreieck?
  (dreieck-width
   dreieck-color)
  )

;Mixed signatur "shape" bestehend aus Kreis, Rechteck und Dreieck
(define shape
  (signature (mixed kreis rechteck dreieck))
  )

;Quadriert eine Zahl
(check-expect (sqr 0) 0)
(check-expect (sqr -1) 1)
(check-expect (sqr 2) 4)

(: sqr (real -> real))
(define sqr
  (lambda (x)
    (* x x)))

;Berechnung der Fläche einer Form
;Nimmt eine Form der Signatur shape
(check-within (shape-area (make-kreis 1 "green")) 3.1415 0.01)
(check-within (shape-area (make-rechteck 1 1 "green")) 1 0.01)
(check-within (shape-area (make-dreieck 1 "green")) 0.433 0.01)
(: shape-area (shape -> real))
(define shape-area
  (lambda (s)
    (cond
      ((kreis? s) (* 3.1415 (sqr (kreis-rad s))))                ;ist s ein kreis?
      ((rechteck? s) (* (rechteck-width s) (rechteck-height s))) ;ist s ein rechteck?
      ((dreieck? s) (/ (* (sqr (dreieck-width s)) (sqrt 3)) 4))  ;ist s ein dreieck?
      (else 0)
      )
    )
  )

;Länge der Waage (Breite von Bild1 + Bild2 + 'abstand')
(check-expect (scale-length (empty-scene 10 10) (empty-scene 10 10) 10) 30)
(check-expect (scale-length (empty-scene 0 0) (empty-scene 0 0) 0) 0)

(: scale-length (image image real -> real))
(define scale-length
  (lambda (i1 i2 abs)
    (+ (image-width i1)
       (image-width i2)
       abs
       )
    )
  )

;Zeichnet ein Bild
(check-expect (draw-shape (make-kreis 1 "red")) (circle 1 "solid" "red"))
(check-expect (draw-shape (make-rechteck 1 20 "red")) (rectangle 1 20 "solid" "red"))
(check-expect (draw-shape (make-dreieck 1 "red")) (triangle 1 "solid" "red"))
(: draw-shape (shape -> image))
(define draw-shape
  (lambda (s)
    (cond
      ((kreis? s) (circle (kreis-rad s) "solid" (kreis-color s)))
      ((rechteck? s) (rectangle (rechteck-width s) (rechteck-height s) "solid" (rechteck-color s)))
      ((dreieck? s) (triangle (dreieck-width s) "solid" (dreieck-color s)))
      (else (empty-scene 0 0))
      )
    )
  )


;Berechnung des Neigewinkels
(check-expect (rotation-angle 0 0) 0)
(check-expect (rotation-angle -10 5) 0)
(check-expect (rotation-angle 10 10) 0)
(check-within (rotation-angle 1 1.5) -30 0.001)
(check-within (rotation-angle 1.5 1) 30 0.001)

(: rotation-angle (real real -> real))
(define rotation-angle
  (lambda (a1 a2)
    (cond ;Fängt ungültige Eingaben ab
      ((or (< a1 0) (< a2 0)) 0)
      ((and (= a1 0) (= a2 0)) 0)
      (else (* 90
               (if (> a1 a2)
                   (- 1 (/ a2 a1))
                   (+ -1 (/ a1 a2))
                   )
               )
            )
      )
    )
  )
;Hintergrund der Waage "Halbkreisbogen"
(define bg
  
  (overlay/offset (rectangle 100 80 "solid" "white")
                  0
                  -30
                  (overlay (circle 40 "solid" "white")
                           (circle 50 "solid" "dimgray"))
                  ))

;Zeichent die Waage
(: draw-scale (shape shape -> image))
(define draw-scale
  (lambda (s1 s2)
    (overlay/align "middle" "top"
     (rotate (rotation-angle (shape-area s1) (shape-area s2)) ;Rotation
             ((lambda (i1 i2)
                (above                                            ;(Image 1 + 10px + triangle(20px) + 10px + Image 2) über Linie (length = width of Scale
                 (beside/align "bottom" i1 (empty-scene 10 0) (isosceles-triangle 75 15 "solid" "darkgray") (empty-scene 10 0) i2)
                 (line (scale-length i1 i2 40) 0 "black")
                 )
                )
              (draw-shape s1) ;Image 1 [i1] from Shape 1 [s1]
              (draw-shape s2) ;Image 2 [i2] from Shape 2 [s2]
              )
             )
     bg)
    )
  )

;(draw-scale (make-kreis 0 "green") (make-dreieck 0 "red"))
;(draw-scale (make-kreis 20 "green") (make-dreieck 45 "red"))
;(draw-scale (make-kreis 25 "green") (make-dreieck 45 "red"))
;(draw-scale (make-kreis 20 "green") (make-dreieck 55 "red"))
;(draw-scale (make-kreis 15 "green") (make-dreieck 45 "red"))