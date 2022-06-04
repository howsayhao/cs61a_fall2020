; 以前写的，感觉scheme都差不多
; 基本就是各种边界判断，没什么意思
; 递归的话也还行，主要最近时间紧
; 就这样，不再写一遍了
(define (how-many-dots s)
  (cond
    ((null? s) 0)
    ((number? s) 0)
    ((pair? s)
      (cond
        ((pair? (car s))
            (cond
              ((or (pair? (cdr s)) (null? (cdr s))) (+ (how-many-dots (car s)) (how-many-dots (cdr s))))
              (else (+ 1 (how-many-dots (cdr s)) (how-many-dots (car s))))
            )
        )
        (else
            (cond
              ((or (pair? (cdr s)) (null? (cdr s))) (how-many-dots (cdr s)))
              (else (+ 1 (how-many-dots (cdr s))))
            )
        )
      )
    )
    (else 0)
  )
)

(define (cadr s) (car (cdr s)))
(define (caddr s) (cadr (cdr s)))
(define (first-operand p) (cadr p))
(define (second-operand p) (caddr p))


; derive returns the derivative of EXPR with respect to VAR
(define (derive expr var)
  (cond ((number? expr) 0)
        ((variable? expr) (if (same-variable? expr var) 1 0))
        ((sum? expr) (derive-sum expr var))
        ((product? expr) (derive-product expr var))
        ((exp? expr) (derive-exp expr var))
        (else 'Error)))

; Variables are represented as symbols
(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

; Numbers are compared with =
(define (=number? expr num)
  (and (number? expr) (= expr num)))

; Sums are represented as lists that start with +.
(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list '+ a1 a2))))
(define (sum? x)
  (and (list? x) (eq? (car x) '+)))
(define (addend s) (cadr s))
(define (augend s) (caddr s))

; Products are represented as lists that start with *.
(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list '* m1 m2))))
(define (product? x)
  (and (list? x) (eq? (car x) '*)))
(define (multiplier p) (cadr p))
(define (multiplicand p) (caddr p))

(define (derive-sum expr var)
  (cond
    ((null? expr) 0) 
    ((number? expr) 0)
    ((sum? expr)
      (cond
        ((or (number? (car (cdr expr))) (same-variable? (car (cdr expr)) var)) 
          (cond
            ((same-variable? (car (cdr expr)) var) 
              (make-sum 1 (derive (car (cdr (cdr expr)) ) var))
            )
            (else (derive (car (cdr (cdr expr))) var)) 
          ) 
        )
        (else 
            (make-sum (derive (car (cdr expr)) var) (derive (car (cdr (cdr expr)) ) var))
        )
      )
    )
  ) 
)

(define (derive-product expr var)
  (cond
    ((null? expr) 0) 
    ((product? expr)
      (cond
        ((or (number? (car (cdr expr))) (variable? (car (cdr expr)))) 
          (cond
            ((same-variable? (car (cdr expr)) var) 
              (cond
                ((product? (cdr (cdr expr))) (cdr (cdr expr)))
                (else (car (cdr (cdr expr))))
              )
            )
            (else (make-product (car (cdr expr)) (derive-product (cdr (cdr expr)) var))) 
          ) 
        )
        (else 
          (make-sum
            (make-product (derive (car (cdr expr)) var) (car (cdr (cdr expr))))
            (make-product (car (cdr expr)) 
                      (derive (car (cdr (cdr expr))) var)
            )
          )
        )
      )
    )
  )
)

; Exponentiations are represented as lists that start with ^.
(define (make-exp base exponent)
  (cond
    ((number? base) (expt base exponent))
    ((= 0 exponent) 1)
    ((= 1 exponent) base)
    (else (list '^ base exponent))
  )
)

(define (base exp)
  (if (exp? exp)
      (car (cdr exp)))
)

(define (exponent exp)
  (if (exp? exp)
      (car (cdr (cdr exp))))
)

(define (exp? exp)
  (and (list? exp) (eq? (car exp) '^))
)

(define x^2 (make-exp 'x 2))
(define x^3 (make-exp 'x 3))

(define (derive-exp expr var)
  (cond
    ((null? expr) 0) 
    ((number? expr) 0)
    ((exp? expr)
      (cond
        ((or (number? (base expr)) (variable? (base expr))) 
          (cond
            ((same-variable? (base expr) var) 
                  (make-product 
                      (exponent expr) 
                      (make-exp (base expr) (make-sum (exponent expr) (- 1)))
                  )
            )
            (else 0) 
          ) 
        )
        (else 
            0
        )
      )
    )
  )
)