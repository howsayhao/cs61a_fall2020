(define (over-or-under num1 num2)
  'YOUR-CODE-HERE
  (cond
    ((< num1 num2) -1)
    ((= num1 num2)  0)
    ((> num1 num2)  1)
  )
)

;;; Tests
(over-or-under 1 2)
; expect -1
(over-or-under 2 1)
; expect 1
(over-or-under 1 1)
; expect 0


(define (make-adder num)
  ; Solu 1  
  ; (x)一定要带上括号 
  ;(lambda (x) (+ num x))

  ; Solu 2
  ; define不占结构，但返回的nest可能会占
  ; 返回的nest是str，不能用，所以需要自己再加一行nest
  ; nest不能带括号
  (define (nest x) (+ num x))
  nest
)

;;; Tests
(define adder (make-adder 5))
(adder 8)
; expect 13


(define (composed f g)
  (lambda (x) (f (g x)))
)


(define lst
  (list (list 1) 2 (list 3 4) 5)
)


(define (remove item lst)
  (define (mutate-find lisp) 
      (if (null? lisp)
          lisp
          (if (= item (car lisp))
              (mutate-find (cdr lisp))
              (cons (car lisp) (mutate-find (cdr lisp)))
            )
        )
    )
  (mutate-find lst)
)


;;; Tests
(remove 3 nil)
; expect ()
(remove 3 '(1 3 5))
; expect (1 5)
(remove 5 '(5 3 5 5 1 4 5 4))
; expect (3 1 4 4)

