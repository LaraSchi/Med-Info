;; Die ersten drei Zeilen dieser Datei wurden von DrRacket eingefügt. Sie enthalten Metadaten
;; über die Sprachebene dieser Datei in einer Form, die DrRacket verarbeiten kann.
#reader(lib "DMdA-beginner-reader.ss" "deinprogramm")((modname Blatt5-A1) (read-case-sensitive #f) (teachpacks ()) (deinprogramm-settings #(#f write repeating-decimal #f #t none explicit #f ())))
(: make-t1 (natural (mixed t2 natural) natural -> t1))
(: t1? (any -> boolean))
(: t1-a (t1 -> natural))
(: t1-b (t1 -> (mixed t2 natural)))
(: t1-c (t1 -> natural))
(define-record-procedures t1
  make-t1
  t1?
  (t1-a ;nat
   t1-b ;t2/nat
   t1-c));nat

(: make-t2 (natural natural -> t2))
(: t2? (any -> boolean))
(: t2-d (t2 -> natural))
(: t2-e (t2 -> natural))
(define-record-procedures t2
  make-t2
  t2?
  (t2-d;nat
   t2-e));nat

(: f (t1 -> integer))
(define f
  (lambda (x)
    (if (natural? (t1-b x));wenn t1-b nat
        (+ (t1-a x) ;a+b+c
           (t1-b x)
           (t1-c x))
        (if (and (= (t2-e (t1-b x)) 1) ; wenn t1-b == #<record:t2 1 1>
                 (= (t2-d (t1-b x)) 1))
            10
            (- (+ (t2-d (t1-b x)) ;d+e-a
                  (t2-e (t1-b x)))
               (t1-a x))))))


;f* als alternative zu f
(: f*  (t1 -> integer))
(define f*
  (lambda (x)
    (match x ; t1
      ((make-t1 _ (make-t2 1 1) _) 10)             ;ist t1 wie: #<record:t1 _ #<record:t2 1 1> _> aufgebaut?
      ((make-t1 a (make-t2 d e) _) (- (+ d e) a))  ;ist t1 wie: #<record:t1 _ #<record:t2 _ _> _> aufgebaut?
      ((make-t1 a b c) (+ a b c))                  ;ist t1 wie: #<record:t1 _ _ _> aufgebaut?
       )
      )
    )

;check-property f=f* für t1 aus 3 natural bestehend
(check-property
 (for-all ((a natural)
           (b natural)
           (c natural))
   (= (f (make-t1 a b c)) ;(f natural natural natural) ==
      (f* (make-t1 a b c));(f* natural natural natural)
   )
   
   )
)

;check-property f=f* für t1 aus 2 natural und einer t2-struktur (a 2 natural) bestehend
(check-property
 (for-all ((a natural)
           (b natural)
           (c natural)
           (d natural))
   (= (f (make-t1 a (make-t2 b c) d)) ;(f natural t2 natural) ==
      (f* (make-t1 a (make-t2 b c) d));(f* natural t2 natural)
      )
   )
)   
  