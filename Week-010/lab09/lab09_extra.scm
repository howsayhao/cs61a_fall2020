;; Extra Scheme Questions ;;


; Q5
(define lst
  'YOUR-CODE-HERE
)

; Q6
(define (composed f g)
  (lambda (x) (f (g x)))
)

; Q7
(define (remove item lst)
  (cond
      ((null? lst) nil)
      ((= item (car lst)) (remove item (cdr lst)))
      (else (cons (car lst) (remove item (cdr lst))))
  )
)



;;; Tests
(remove 3 nil)
; expect ()
(remove 3 '(1 3 5))
; expect (1 5)
(remove 5 '(5 3 5 5 1 4 5 4))
; expect (3 1 4 4)

; Q8
(define (max a b) (if (> a b) a b))
(define (min a b) (if (> a b) b a))
(define (gcd a b)
  (and
    (define (mod a b) 
      (if (> (- a b) b) 
            (mod (- a b) b)
            (- a b)
      )
    )  
    (cond
        ((or (= 0 a) (= 0 b) ) (max a b))
        ((or (= 1 a) (= 1 b) ) 1)
        ((> a b) (gcd b (mod a b)))
        ((= a b) a)
        (else (gcd a (mod b a)))
    )
  )
)

;;; Tests
(gcd 24 60)
; expect 12
(gcd 1071 462)
; expect 21

(define (no-repeats s)
  (and
    (define (contains v lst)  
                          (cond
                              ((null? lst) 1)
                              ((= v (car lst)) 0)
                              (else (contains v (cdr lst)))
                          )
              )
    (cond
        ((null? s) nil)
        ((= (contains
              (car s) (cdr s)) 1)       
          (cons (car s) (no-repeats (cdr s))))
        (else (no-repeats (cdr s)))
      )
  )
)

; Q10
(define (substitute s old new)
  (cond
    ((null? s) nil)
    ((pair? (car s))
          (cons (substitute (car s) old new) (substitute (cdr s) old new)))
    (else
      (cond
        ((equal? (car s) old) (cons new (substitute (cdr s) old new)))
        (else (cons (car s) (substitute (cdr s) old new)))
      )
    )
  )
)

; Q11
(define (sub-all s olds news)
  (cond
    ((null? olds) s)
    (else (sub-all (substitute s (car olds) (car news)) (cdr olds) (cdr news)))
  )
)