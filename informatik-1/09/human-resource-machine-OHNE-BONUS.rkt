;; Die ersten drei Zeilen dieser Datei wurden von DrRacket eingefügt. Sie enthalten Metadaten
;; über die Sprachebene dieser Datei in einer Form, die DrRacket verarbeiten kann.
#reader(lib "DMdA-vanilla-reader.ss" "deinprogramm")((modname human-resource-machine) (read-case-sensitive #f) (teachpacks ((lib "image2.rkt" "teachpack" "deinprogramm") (lib "universe.rkt" "teachpack" "deinprogramm"))) (deinprogramm-settings #(#f write repeating-decimal #f #t none explicit #f ((lib "image2.rkt" "teachpack" "deinprogramm") (lib "universe.rkt" "teachpack" "deinprogramm")))))
; --------------------------------------------------------------------------------------------------------------
; The office
; --------------------------------------------------------------------------------------------------------------

; A post office consists of
; - an inbox for incomming packages
; - an outbox for outgoing packages
; - a floor of fixed size to work on. Each slot contains either a package or nothing
; - a worker who can carry a single package (or nothing)
; - a list of instructions, telling the worker what to do step by step
; - an instruction pointer, telling the worker what to do next. It is either an absolute
;   position on the instructions board, starting from 0, or #f for "finish work!"
; - a time clock which records the total time of work (in number of performed instructions)
(define-record-procedures office
  make-office
  office?
  (inbox
   outbox
   floor-slots
   worker
   instruction-list
   ip
   time-clock))

(: make-office ((list-of package)
                (list-of package)
                (list-of (maybe-of package))
                (maybe-of package)
                (list-of (mixed instruction string))
                (maybe-of natural)
                natural
                -> office))
(: office? (any -> boolean))
(: inbox (office -> (list-of package)))
(: outbox (office -> (list-of package)))
(: floor-slots (office -> (list-of (maybe-of package))))
(: worker (office -> (maybe-of package)))
(: instruction-list (office -> (list-of (mixed instruction string))))
(: ip (office -> (maybe-of natural)))
(: time-clock (office -> natural))

; A package contains either a number or a character
(define package (signature (mixed integer character)))

; A character is an upper case letter of the alphabet between "A" and "Z" 
(define character (signature (predicate (lambda (c) (and (string? c) (string<=? "A" c "Z"))))))

; A (maybe-of ⟨t⟩) is either an element of signature ⟨t⟩ or empty (#f)
(: maybe-of (signature -> signature))
(define maybe-of
  (lambda (t)
    (signature (mixed t (one-of #f)))))

(define-record-procedures-parametric tuple tuple-of
  make-tuple
  tuple?
  (one
   two)
  )

; --------------------------------------------------------------------------------------------------------------
; Some predefined list functions
; --------------------------------------------------------------------------------------------------------------

; replicate an element n times
(: replicate (natural %a -> (list-of %a)))
(define replicate
  (lambda (n x)
    (cond ((= n 0) empty)
          (else (make-pair x (replicate (- n 1) x))))))

; Zip two lists with a given function
(: zipWith ((%a %b -> %c) (list-of %a) (list-of %b) -> (list-of %c)))
(define zipWith
  (lambda (f xs ys)
    (cond ((empty? xs) empty)
          ((empty? ys) empty)
          (else        (make-pair (f (first xs) (first ys)) 
                                  (zipWith f (rest xs) (rest ys)))))))

; Return an integer list range
(: range (integer integer -> (list-of integer)))
(define range
  (lambda (from to)
    (cond ((> from to) empty)
          (else (make-pair from (range (+ from 1) to))))))



; --------------
; Student task
; --------------

; Exercises (f) through (k): implement the higher-order procedures for list processing
(: list-index ((%a -> boolean) (list-of %a) -> natural))
(define list-index
  (lambda (proc l)
    (li-w proc l 0)))
(define li-w
  (lambda (proc l i)
    (match l
      (empty (violation "[list-index] List index not found"))
      (_ (if (proc (first l))
             i
             (li-w proc (rest l) (+ i 1))
             )
         ))))

(define any=string?
  (lambda (s)
    (lambda (a)
      (if (string? a)
          (string=? s a)
          #f))))

(define jump
  (lambda(s)
    (make-instr "Jump to"
                (lambda (o)
                  (let ([pos (list-index (any=string? s) (instruction-list o))])
                    (make-office
                     (inbox o)
                     (outbox o)
                     (floor-slots o)
                     (worker o)
                     (instruction-list o)
                     pos ;ip
                     (time-clock o))
                    )))))

(define jump-if-zero
  (lambda(s)
    (make-instr "Jump if Zero"
                (lambda (o)
                  (let ([hands (worker o)])
                    (cond
                      ((natural? hands) (if (= 0 hands)
                                            (let ([pos (list-index (any=string? s) (instruction-list o))])
                                              (make-office
                                               (inbox o)
                                               (outbox o)
                                               (floor-slots o)
                                               hands
                                               (instruction-list o)
                                               pos ;ip
                                               (time-clock o))
                                              )
                                            o
                                            ))
                      ((false? hands) (violation "[jump-if-zero] Coparision not possible with empty hands"))
                      (else o)
                      )
                    )
                  )
                )
    )
  )
(define jump-if-negative
  (lambda(s)
    (make-instr "Jump if Negative"
                (lambda (o)
                  (let ([hands (worker o)])
                    (cond
                      ((integer? hands) (if (< hands 0)
                                            (let ([pos (list-index (any=string? s) (instruction-list o))])
                                              (make-office
                                               (inbox o)
                                               (outbox o)
                                               (floor-slots o)
                                               hands
                                               (instruction-list o)
                                               pos ;ip
                                               (time-clock o))
                                              )
                                            o
                                            ))
                      ((false? hands) (violation "[jump-if-negative] Comparision not possible with empty hands"))
                      (else o)
                      )
                    )
                  )
                )
    )
  )

(: list-update ((list-of %a) natural %a -> (list-of %a)))
(define list-update
  (lambda (l n nv) ;List Natural NewValue
    (if (>= (abs n) (length l))
        (violation "[list-update] List index out of range")
        (lu-w empty l n nv)
        )
    )
  )
(define lu-w
  (lambda (lf lb n nv) ;ListFront ListEnd Natural NewValue
    (if (= n 0)
        (append lf (make-pair nv (rest lb)))
        (lu-w (append lf (list (first lb))) (rest lb) (- n 1) nv)
        )
    )
  )

;Get n-th element from list
;Count from 0
;-1 => last element, -2 => second element counting from end...
(: getFromList (integer (list-of (maybe-of %a)) -> (maybe-of %a)))
(define getFromList
  (lambda (n l)
    (cond
      ((< n 0) (getFromList (- (abs n) 1) (reverse l)))
      ((empty? l) (violation "[getFromList] Given empty list"))
      ((< (length l) (+ n 1)) (violation "[getFromList] List index out of range"))
      ((= n 0) (first l))
      (else (getFromList (- n 1) (rest l)))
      )
    )
  )
(: ordinal (character -> natural))
(define ordinal
  (lambda (c)
    (li-w (any=string? c) (list "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z") 1)))
; --------------------------------------------------------------------------------------------------------------
; Instructions
; --------------------------------------------------------------------------------------------------------------

; An instruction consists of
; - a text representation and
; - a function that modifies a given office, following the instruction
(define-record-procedures instruction
  make-instr
  instr?
  (description action))

(: make-instr (string (office -> office) -> instruction))
(: instr? (any -> boolean))
(: description (instruction -> string))
(: action (instruction -> (office -> office)))


; --------------
; Student task
; --------------

; Exercises (a), (b), (g), (i), (k), (l) and (n): implement the instructions

(: <-inbox instruction)
(define <-inbox
  (make-instr "Get from Inbox"
              (lambda (o)
                (let ([inb (inbox o)])
                  (if (empty? inb)
                      (make-office empty ;new Office, IP = #f
                                   (outbox o)
                                   (floor-slots o)
                                   (worker o)
                                   (instruction-list o)
                                   #f
                                   (time-clock o)
                                   )
                      (make-office (rest inb) ;new Office, worker hällt new-pack
                                   (outbox o)
                                   (floor-slots o)
                                   (first inb)
                                   (instruction-list o)
                                   (ip o)
                                   (time-clock o)
                                   ))))))
                                       
(: ->outbox instruction)
(define ->outbox
  (make-instr "Push to Outbox"
              (lambda (o)
                (let ([outb (outbox o)]
                      [hands (worker o)])
                  (if (false? hands)
                      (violation "[->outbox] Missing value! With empty hands <-OUTBOX won't work")
                      (make-office (inbox o) ;new Office, worker hällt new-pack
                                   (append (list hands) outb)
                                   (floor-slots o)
                                   #f
                                   (instruction-list o)
                                   (ip o)
                                   (time-clock o)
                                   ))))))

(: copy-to (natural -> instruction))
(define copy-to
  (lambda (to)
    (make-instr "Copy to"
                (lambda (o)
                  (let ([hands (worker o)])
                    (if (false? hands)
                        (violation "[copy-to] Missing value! With empty hands copy-to won't work")
                        (make-office (inbox o)
                                     (outbox o)
                                     (list-update (floor-slots o) to hands)
                                     hands
                                     (instruction-list o)
                                     (ip o)
                                     (time-clock o)
                                     )))))))
(: copy-from (natural -> instruction))
(define copy-from
  (lambda (from)
    (make-instr "Copy from"
                (lambda (o)
                  (let ([nv (getFromList from (floor-slots o))])
                    (if (false? nv)
                        (violation "[copy-from] Missing value! Can't copy from empty floor")
                        (make-office (inbox o)
                                     (outbox o)
                                     (floor-slots o)
                                     nv
                                     (instruction-list o)
                                     (ip o)
                                     (time-clock o)
                                     )))))))

(: sub (natural -> instruction))
(define sub
  (lambda (from)
    (make-instr "Substract from"
                (lambda (o)
                  (let ([fv (getFromList from (floor-slots o))] ;FloorValue (Int/char)
                        [hands (worker o)])                     ;Worker
                    (cond
                      ((false? fv) (violation "[sub] Missing value! Can't substract from empty floor"))
                      ((false? hands) (violation "[sub] Missing value! Can't substract with empty hands"))
                      (else (make-office (inbox o)
                                         (outbox o)
                                         (floor-slots o)
                                         (int/charSub hands fv)
                                         (instruction-list o)
                                         (ip o)
                                         (time-clock o)
                                         ))))))))
(: add (natural -> instruction))
(define add
  (lambda (from)
    (make-instr "Add from"
                (lambda (o)
                  (let ([fv (getFromList from (floor-slots o))] ;FloorValue (Int/char)
                        [hands (worker o)])                     ;Worker
                    (cond
                      ((false? fv) (violation "[add] Missing value! Can't add from empty floor"))
                      ((false? hands) (violation "[add] Missing value! Can't add with empty hands"))
                      (else (make-office (inbox o)
                                         (outbox o)
                                         (floor-slots o)
                                         (int/charAdd hands fv)
                                         (instruction-list o)
                                         (ip o)
                                         (time-clock o)
                                         ))))))))


(: int/charSub ((mixed number character) (mixed number character) -> number))
(define int/charSub
  (lambda (a b)
    (cond
      ((and (string? a) (string? b)) (- (ordinal a) (ordinal b)))
      ((string? a) (- (ordinal a) b))
      ((string? b) (- a (ordinal b)))
      (else (- a b))
      )
    )
  )
(: int/charAdd ((mixed number character) (mixed number character) -> number))
(define int/charAdd
  (lambda (a b)
    (cond
      ((and (string? a) (string? b)) (+ (ordinal a) (ordinal b)))
      ((string? a) (+ (ordinal a) b))
      ((string? b) (+ a (ordinal b)))
      (else (+ a b))
      )
    )
  )
    
(define bump+
  (lambda (to)
    (make-instr "bump+"
                (lambda (o)
                  (let ([fv (getFromList to (floor-slots o))]
                        [fs (floor-slots o)]) ;FloorValue (Int/char)
                    (cond
                      ((false? fv) (violation "[bump+] Missing value! Can't bump to empty floor"))
                      (else (let ([nv (int/charAdd fv 1)])
                              (make-office (inbox o)
                                           (outbox o)
                                           (list-update fs to nv)
                                           nv
                                           (instruction-list o)
                                           (ip o)
                                           (time-clock o)
                                           )))))))))
(define bump-
  (lambda (to)
    (make-instr "bump-"
                (lambda (o)
                  (let ([fv (getFromList to (floor-slots o))]
                        [fs (floor-slots o)]) ;FloorValue (Int/char)
                    (cond
                      ((false? fv) (violation "[bump-] Missing value! Can't bump to empty floor"))
                      (else (let ([nv (int/charSub fv 1)])
                              (make-office (inbox o)
                                           (outbox o)
                                           (list-update fs to nv)
                                           nv
                                           (instruction-list o)
                                           (ip o)
                                           (time-clock o)
                                           )))))))))
; --------------------------------------------------------------------------------------------------------------
; Running the office
; --------------------------------------------------------------------------------------------------------------

; Perform the action of the next instruction
(: perform-next (office -> office))
(define perform-next
  (lambda (o)
    (let ([pointer (ip o)])
      (match pointer
        (#f o)
        (_ (let ([CAI (getCAI pointer (instruction-list o))])
             (match CAI
               (#f o)
               (_ (setStepUP ((action (two CAI)) o) (+ 1 (one CAI)) 1))
               )
             )
           )
        )
      )
    )
  )

; Iteratively apply instructions to a given office
(: perform-all (office -> office))
(define perform-all
  (lambda (o)
    (if (false? (ip o))
        o
        (perform-all (perform-next o))
        )))


;Get current activ instrucion, get Count of string in il

;(: getCAI (integer (maybe-of (list-of instruction)) -> (maybe-of instruction)))
(define getCAI
  (lambda (p l)
    (getCAIw p l 0)
    )
  )

(define getCAIw
  (lambda (p l atp)
    (cond
      ((empty? l) #f)
      ((= p 0) (if (string? (first l))
                   (getCAIw 0 (rest l) (+ atp 1))
                   (make-tuple atp (first l))))
      (else (getCAIw (- p 1) (rest l) atp))
      )
    )
  )


(: setStepUP (office natural natural -> office))
(define setStepUP
  (lambda (o atp atc) ;Office addToPointer addToClock
    (let ([pointer (ip o)]
          [l (instruction-list o)])
      (match pointer
        (#f o)
        (_ (make-office
            (inbox o)
            (outbox o)
            (floor-slots o)
            (worker o)
            l
            (if (false? (getCAI (+ pointer atp) l)) ;War die jetzige Instruction die letzte?
                #f
                (+ pointer atp))
            (+ (time-clock o) atc)))))
    
    ))
; -------------------------------------------------------------------------------------------------------------
; Draw and animate the office
; --------------------------------------------------------------------------------------------------------------

; Draw package
(: draw-package ((maybe-of package) -> image))
(define draw-package
  (lambda (p)
    (place-image (text (cond ((number? p) (number->string p))
                             ((string? p) p)
                             (else ""))
                       14 "black")
                 12 12
                 (overlay
                  (cond ((false? p) empty-image)
                        (else (rectangle 20 20 "solid" "lightgray")))
                  (rectangle 23 23 "solid" "brown")
                  (rectangle 24 24 "solid" "white")))))

; Draw list of packages
(: draw-pkgs (string (list-of (maybe-of package)) -> image))
(define draw-pkgs
  (lambda (lbl ps)
    (beside (place-image/align (text lbl 14 "black") (* 2.5 24) 12 "right" "center" (rectangle (* 2.5 24) 24 "solid" "white"))
            (empty-scene 3 0)
            (fold empty-image beside (map draw-package ps)))))

; Draw instruction based on instruction pointer and a given line number
(: draw-instruction ((maybe-of natural) -> (natural (mixed instruction string) -> image)))
(define draw-instruction
  (lambda (ip)
    (lambda (n instr) 
      (let ((current? (and (number? ip) (= ip n))))
        (text/font (string-append
                    (if current? ">" " ")
                    (if (< n 10) "0" "")
                    (number->string n) ": "
                    (cond ((string? instr)
                           (string-append "\"" instr "\""))
                          (else (description instr))))
                   16 "black" #f "modern" "normal"
                   (if current? "bold" "normal")
                   #f)))))

; Draw list of instructions
(: draw-instructions ((list-of (mixed instruction string)) (maybe-of natural) -> image))
(define draw-instructions
  (lambda (is ip)
    (above/align "left"
                 (text "Board of instructions: (press any key to proceed, ESC to finish work)"  14 "black")
                 (empty-scene 0 6)
                 (beside (empty-scene 12 0)
                         (fold empty-image
                               (lambda (instr res)
                                 (above/align "left" instr res))
                               (zipWith (draw-instruction ip)
                                        (range 0 (- (length is) 1))
                                        is)))            
                 (empty-scene 0 6))))

; Draw the office
(: draw-office (office -> image))
(define draw-office
  (lambda (o)
    (above/align "left"
                 (text "Human Resource Machine Post Office" 30 "gray")
                 (empty-scene 0 6)
                 (draw-instructions (instruction-list o) (ip o))
                 (empty-scene 0 6)
                 (draw-pkgs "inbox <-" (inbox o))
                 (empty-scene 0 6)
                 (beside (draw-pkgs "worker" (list (worker o)))
                         (draw-pkgs "floor" (floor-slots o)))
                 (empty-scene 0 6)
                 (draw-pkgs "outbox ->" (outbox o))
                 (empty-scene 0 6)
                 (text (string-append "Time clock: " (number->string (time-clock o))) 14 "black")
                 )))

; Animate the office
(: start-office-day (office -> office))
(define start-office-day
  (lambda (o)
    (big-bang o
      (to-draw draw-office)
      (on-key (lambda (o key)
                (cond ((key=? key "escape") (perform-all o))
                      (else (perform-next o))))) )))


; --------------------------------------------------------------------------------------------------------------
; Programs and tests
; --------------------------------------------------------------------------------------------------------------


;(check-expect (outbox (perform-all day01)) (list 3 "E"))
(define day01
  (make-office (list "E" 3) empty    ; inbox, outbox
               (replicate 16 #f) #f  ; floor, worker
               (list "top"
                     <-inbox
                     ->outbox
                     (jump "top")
                     )            
               0 0))

;(check-expect (outbox (perform-all day03)) (list 3 0 2 "E" 0 2 0 "B" 2 0 5))
(define day03
  (make-office (list 5 -3 0 2 "B" 0 2 -4 0 "E" 2 0 3) empty    ; inbox, outbox
               (replicate 16 #f) #f  ; floor, worker
               (list "top"
                     <-inbox
                     (jump-if-negative "top")
                     ->outbox
                     (jump "top")
                     )            
               0 0))
;(check-expect (outbox (perform-all day04)) (list 3 4 1 2))
(define day04
  (make-office (list 1 2 3 4) empty    ; inbox, outbox
               (replicate 16 #f) #f  ; floor, worker
               (list "top"
                     <-inbox
                     (copy-to 0)
                     <-inbox
                     "ignore"
                     ->outbox
                     "test"
                     "test2"
                     (copy-from 0)
                     ->outbox
                     (jump "top")
                     )            
               0 0))
(check-expect (outbox (perform-all day04)) (list 4 0 3))
(define day05
  (make-office (list 7 2 3 5 13 3) empty    ; inbox, outbox
               (append (list 0) (replicate 15 #f)) #f  ; floor, worker
               (list "top"
                     (copy-from 0)
                     (copy-to 1)
                     <-inbox
                     (copy-to 3)
                     <-inbox
                     (copy-to 4)
                     "mid"
                     (copy-from 3)
                     (sub 4)
                     (jump-if-negative  "break")
                     (copy-to 3)
                     (bump+ 1)
                     (jump "mid")
                     "break"
                     (copy-from 1)
                     ->outbox
                     (jump "top")
                     )            
               0 0))
; --------------
; Student task
; --------------

; Exercises (h), (j), (m) and (o): implement and test the worker's instructions

