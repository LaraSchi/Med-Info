;; Die ersten drei Zeilen dieser Datei wurden von DrRacket eingefügt. Sie enthalten Metadaten
;; über die Sprachebene dieser Datei in einer Form, die DrRacket verarbeiten kann.
#reader(lib "DMdA-vanilla-reader.ss" "deinprogramm")((modname Blatt10-A3) (read-case-sensitive #f) (teachpacks ((lib "image2.rkt" "teachpack" "deinprogramm") (lib "universe.rkt" "teachpack" "deinprogramm"))) (deinprogramm-settings #(#f write repeating-decimal #f #t none explicit #f ((lib "image2.rkt" "teachpack" "deinprogramm") (lib "universe.rkt" "teachpack" "deinprogramm")))))
;Berechnet Potenzmenger einer Liste
(: powerset ((list-of %a) -> (list-of (list-of %a))))
(check-expect (powerset empty) (list empty))
(check-expect (powerset (list 1 2)) (list (list 1 2) (list 1) (list 2) empty))
(define powerset
  (lambda (l)
  (if (empty? l)
      (list empty)
      (let ((powersetL (powerset (rest l))))
        (append (map (lambda (x) (make-pair (first l) x)) powersetL) powersetL)))))
