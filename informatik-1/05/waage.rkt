;; Die ersten drei Zeilen dieser Datei wurden von DrRacket eingefügt. Sie enthalten Metadaten
;; über die Sprachebene dieser Datei in einer Form, die DrRacket verarbeiten kann.
#reader(lib "DMdA-vanilla-reader.ss" "deinprogramm")((modname waage) (read-case-sensitive #f) (teachpacks ((lib "image2.rkt" "teachpack" "deinprogramm") (lib "universe.rkt" "teachpack" "deinprogramm"))) (deinprogramm-settings #(#f write repeating-decimal #f #t none explicit #f ((lib "image2.rkt" "teachpack" "deinprogramm") (lib "universe.rkt" "teachpack" "deinprogramm")))))
(isosceles-triangle 75	 	 	 	 
                    15	 	 	 	 
                    "solid"	 	 	 	 
                    "red")

(overlay/offset (rectangle 100 80 "solid" "white")
                0
                -30
                (overlay (circle 40 "solid" "white")
                         (circle 50 "solid" "green"))
                )