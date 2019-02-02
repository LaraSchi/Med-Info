;; Die ersten drei Zeilen dieser Datei wurden von DrRacket eingefügt. Sie enthalten Metadaten
;; über die Sprachebene dieser Datei in einer Form, die DrRacket verarbeiten kann.
#reader(lib "DMdA-beginner-reader.ss" "deinprogramm")((modname Blatt3-A1) (read-case-sensitive #f) (teachpacks ((lib "image2.rkt" "teachpack" "deinprogramm") (lib "universe.rkt" "teachpack" "deinprogramm"))) (deinprogramm-settings #(#f write repeating-decimal #f #t none explicit #f ((lib "image2.rkt" "teachpack" "deinprogramm") (lib "universe.rkt" "teachpack" "deinprogramm")))))
(define pi 3.1415)
(define quadrat
(lambda (n)
(* n n)))

; (a)
(* 2 pi)

~>[eval_id(*), eval_lit(2), eval_id(pi)]
(#<procedure:*> 2 3.1415)

~>[eval_lit(3.1415)]
(#<procedure:*> 2 3.1415)

~>[apply_prim(*)]
6.283

; (b)
(quadrat (+ 4 2))

~>[eval_id(quadrat)]
((lambda (n) (* n n) ) (+ 4 2))

~>[eval_id(+), eval_lit(4), eval_lit(2)]
((lambda (n) (* n n) ) (#<procedure:+> 4 2))

~>[apply_prim(+)]
((lambda (n) (* n n) )  6)

~>[eval_lambda]
((lambda (n) (* n n) )  6)

~>[apply_lambda]
(* 8 8)

~>[eval_id(*), eval_lit(6), eval_lit(6)]
(#<procedure:*> 6 6)

~>[apply_prim(*)]
64

; (c)
((lambda (pi) (* 2 pi)) pi)

~>[eval_id(pi)]
((lambda (pi) (* 2 pi)) 3.1415)

~>[eval_lit(3.1415)]
((lambda (pi) (* 2 pi)) 3.1415)

~>[eval_lambda]
((lambda (pi) (* 2 pi)) 3.1415)

~>[apply_lambda]
(* 2 3.1415)

~>[eval_id(*), eval_lit(2), eval_lit(3.1415)]
(#<procedure:*> 2 3.1415)

~>[apply_prim(*)]
6.283


; (d)
((lambda (a) a)
(+ ((lambda (a) (+ a 2)) 3) 2))

~>[eval_lambda]
((lambda (a) a)
(+ ((lambda (a) (+ a 2)) 3) 2))

~>[apply_lambda]
((lambda (a) a)
 (+ (+ 3 2) 2))

~>[eval_id(+), eval_lit(3), eval_lit(2)]
((lambda (a) a)
 (+ (#<procedure:+> 3 2) 2))

~>[apply_prim(+)]
((lambda (a) a)
 (+ 5 2))

~>[eval_id(+), eval_lit(5), eval_lit(2)]
((lambda (a) a)
 (#<procedure:+> 5 2))

~>[apply_prim(+)]
((lambda (a) a) 7)

~>[eval_lambda]
((lambda (a) a) 7)

~>[apply_lambda]
(7)

~>[eval_lit(7)]
7

; (e)
((lambda (x) x) (lambda (x) x))
~>[eval_lambda]
((lambda (x) x) (lambda (x) x))

~>[apply_lambda]
(lambda (x) x)

~>[eval_lambda]
(lambda (x) x)






