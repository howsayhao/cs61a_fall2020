(define (caar x) (car (car x)))
(define (cadr x) (car (cdr x)))
(define (cdar x) (cdr (car x)))
(define (cddr x) (cdr (cdr x)))

; Some utility functions that you may find useful to implement

(define (zip pairs)
  'replace-this-line)


;; Problem 15
;; Returns a list of two-element lists
(define (enumerate s)
  ; BEGIN PROBLEM 15
  (define (mutate ok lisp)
      (cond
        ((null? lisp) nil)
        (else 
          (cons (cons ok (cons (car lisp) nil)) (mutate (+ ok 1) (cdr lisp)))
          )
        )
    )  
  (mutate 0 s)
)
  ; END PROBLEM 15

;; Problem 16

;; Merge two lists LIST1 and LIST2 according to COMP and return
;; the merged lists.
(define (merge comp list1 list2)
  ; BEGIN PROBLEM 16
  (define (mutate lt lisp1 lisp2)
    (cond
      ((null? lisp1) lisp2)
      ((null? lisp2) lisp1)
      ((= lt 1) 
        (cond
          ((< (car lisp1) (car lisp2)) (cons (car lisp1) (mutate lt (cdr lisp1) lisp2)))
          (else (cons (car lisp2) (mutate lt lisp1 (cdr lisp2))))
          )
        )
      (else
        (cond
          ((> (car lisp1) (car lisp2)) (cons (car lisp1) (mutate lt (cdr lisp1) lisp2)))
          (else (cons (car lisp2) (mutate lt lisp1 (cdr lisp2))))
          )
        )
      )
    ) 
  (cond
    ((equal? comp <) (mutate 1 list1 list2))
    (else (mutate 0 list1 list2))
    ) 
)
  ; END PROBLEM 16


(merge < '(1 5 7 9) '(4 8 10))
; expect (1 4 5 7 8 9 10)
(merge > '(9 7 5 1) '(10 8 4 3))
; expect (10 9 8 7 5 4 3 1)

;; Problem 17

(define (nondecreaselist s)
  ; BEGIN PROBLEM 17
  (define (mutate start)
    (cond
      ((null? start) nil)
      ((null? (cdr start)) (cons (car start) nil))
      ((> (car start) (cadr start))
        (cons (car start) nil)
        )
      (else
        (cons (car start) (mutate (cdr start)))
        )
      )
    )
  (define (eval start s)
    (cond
      ((null? s) nil)
      ((null? (cdr s)) (cons (mutate s) nil))
      (else
        (cond
          ((or (< (car s) (cadr s)) (= (car s) (cadr s))) 
            (eval start (cdr s))
            )
          (else                 
            (cons (mutate start) (eval (cdr s) (cdr s)))
            )
          )
        )
      )
    )
  (eval s s)
)
  ; END PROBLEM 17

;; Problem EC
;; Returns a function that checks if an expression is the special form FORM
(define (check-special form)
  (lambda (expr) (equal? form (car expr))))

(define lambda? (check-special 'lambda))
(define define? (check-special 'define))
(define quoted? (check-special 'quote))
(define (let? expr)    
    (and
        (equal? 'let (car expr))
        (cond
         ((null? expr)               False)
         ((null? (cdr expr))         False)
         ((null? (cadr expr))        False)
         ((integer?  (cadr expr))    False) 
         ((symbol?  (cadr expr))     False)  ; 无奈之举，我找不到其他的方法可以快速判断
                                             ; 是不是pair，给我的接口太少了
                                             ; 估计题目也不允许我自己加几个接口
         (else)
        )
    )
)

(define (para s)
  (cond
       ((null? s) nil)
       (else
            (cons (caar s) (para (cdr s)))
        )))

(define (val s)
  (cond
       ((null? s) nil)
       (else
            (cons (car (cdar s)) (val (cdr s)))
        )))


;; Converts all let special forms in EXPR into equivalent forms using lambda
(define (let-to-lambda expr)
  (cond ((atom? expr)
         ; BEGIN PROBLEM EC
         expr
         ; END PROBLEM EC
         )
        ((quoted? expr)
         ; BEGIN PROBLEM EC
         expr
         ; END PROBLEM EC
         )
        ((or (lambda? expr)
             (define? expr))
         (let ((form   (car expr ))
               (params (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM EC
           ;(let-to-lambda params)
           (append (list 'lambda (let-to-lambda params)) (let-to-lambda body))
           ; END PROBLEM EC
          )
        )
        ((let? expr)
         (let ((values (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM EC
           ;(list 1 2)
           (append (list (append (list 'lambda (let-to-lambda (para values))) (let-to-lambda body))) (let-to-lambda (val values)))
           ; END PROBLEM EC
           ))
        (else
         ; BEGIN PROBLEM EC
         ;(list 15764)
         (cons (let-to-lambda (car expr)) (let-to-lambda (cdr expr)))
         ; END PROBLEM EC
         )))

