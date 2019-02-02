;; Die ersten drei Zeilen dieser Datei wurden von DrRacket eingefügt. Sie enthalten Metadaten
;; über die Sprachebene dieser Datei in einer Form, die DrRacket verarbeiten kann.
#reader(lib "DMdA-vanilla-reader.ss" "deinprogramm")((modname Blatt12-A1) (read-case-sensitive #f) (teachpacks ((lib "image2.rkt" "teachpack" "deinprogramm") (lib "universe.rkt" "teachpack" "deinprogramm"))) (deinprogramm-settings #(#f write repeating-decimal #f #t none explicit #f ((lib "image2.rkt" "teachpack" "deinprogramm") (lib "universe.rkt" "teachpack" "deinprogramm")))))
(: mountain string)
(define mountain "/\\")
(: mountain-peaks (natural -> (list-of string)))
(check-expect (mountain-peaks 1) (list "/\\"))
(check-expect (mountain-peaks 2) (list " /\\" "/\\ \\"))
(check-expect (mountain-peaks 3) (list "  /\\" " / /\\" "/ /\\ \\"))
(define mountain-peaks
  (lambda (n)
    (if (<= n 0) (list "_") ;Niederlande
        (mp-worker (list (ntw (- n 1) mountain))
                   mountain
                   n
                   (even? n)))))

(: mp-worker ((list-of string) string natural boolean -> (list-of string)))
(define mp-worker
  (lambda (l m n a)                                    ;l=output-list, m=mountain-slice, n=n-th slice, a=append (left/right)
    (if (<= n 1)                                       ;Fuß des Berges erreicht
        l                                              ;Gebe list of string zurück
        (let ([newM (if a                              ;wenn a
                        (string-append m " \\")        ;füge \ rechts hinzu
                        (string-append "/ " m))])      ;anosnte / links
          
          (mp-worker (append l (list (ntw (- n 2) newM)))    ;füge den neuen "Mountain-Slice" mit passender anzahl an " " zur liste hinzu
                     newM (- n 1) (not a))))))

;n times whitespace
;Setzte n mal " " vor acc
(: ntw (natural string -> string))
(check-expect (ntw 1 "") " ")
(check-expect (ntw 2 "test") "  test")
(define ntw
  (lambda (n acc)
    (if (<= n 0)
        acc
        (ntw (- n 1) (string-append " " acc)))))


(: unlines ((list-of string) -> string))
(define unlines
  (lambda (ys)
    (fold "" (lambda (x xs) (string-append x "\n" xs)) ys)))
(: print ((list-of string) -> %nothing))
(define print
  (lambda (ss)
    (write-string (unlines ss))))

