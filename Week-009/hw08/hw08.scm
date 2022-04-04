(define (cddr s)
  (cdr (cdr s)))

(define (cadr s)
  (car (cdr s))
)

(define (caddr s)
  (car (cdr (cdr s)))
)

(define (sign x)
  (cond
    ((< 0 x) 1)
    ((= 0 x) 0)
    ((> 0 x) -1)
  )
)

(define (square x) (* x x))

(define (pow b n)
  (cond
    ((= n 0) 1)
    (else (* b (pow b (- n 1))))
  ) 
)

(define (ordered? s)
  (cond
    ((null? s) True)
    ((null? (cdr s)) True)
    ((<= (car s) (car (cdr s))) 
      (ordered? (cdr s)) 
    )
    (else False)
  )
)

(define (nodots s)
  (cond 
      ((null? (cdr s))            s)
      ((pair? (car s))  
          (cond
            ((not (pair? (cdr s))) (cons (nodots (car s)) (cons (cdr s) nil)))
            (else (cons (nodots (car s)) (nodots (cdr s))))
          )
        )
      ((not (pair? (cdr s))) (cons (car s) (cons (cdr s) nil))) 
      (else  (cons (car s) (nodots (cdr s))))                              
  )
)

; Sets as sorted lists

(define (empty? s) (null? s))

(define (contains? s v)
    (cond ((empty? s) #f)
          ((= v (car s)) #t)
          ((< v (car s)) #f)
          (else (contains? (cdr s) v)) ; replace this line
          ))

; Equivalent Python code, for your reference:
;
; def empty(s):
;     return s is Link.empty
;
; def contains(s, v):
;     if empty(s):
;         return False
;     elif s.first > v:
;         return False
;     elif s.first == v:
;         return True
;     else:
;         return contains(s.rest, v)

(define (add s v)
    (cond ((empty? s) (list v))
          ((contains? s v) s)
          (else 
            (cond
              ((< (car s) v) (cons (car s) (add (cdr s) v)))
              (else (cons v s))
            )) ; replace this line
          ))

(define (intersect s t)
    (cond ((or (empty? s) (empty? t)) nil)
          (else (cond
                  ((= (car s) (car t)) 
                      (cond
                          ((list? (intersect (cdr s) (cdr t))) (cons (car s) (intersect (cdr s) (cdr t))))
                          (else (cons (car s) (cons (intersect (cdr s) (cdr t)) nil)))
                      )
                  )
                  ((< (car s) (car t)) 
                      (intersect (cdr s) t) )
                  ((> (car s) (car t)) 
                      (intersect (cdr t) s) ) 
                ) 
          )
    )
)

; Equivalent Python code, for your reference:
;
; def intersect(set1, set2):
;     if empty(set1) or empty(set2):
;         return Link.empty
;     else:
;         e1, e2 = set1.first, set2.first
;         if e1 == e2:
;             return Link(e1, intersect(set1.rest, set2.rest))
;         elif e1 < e2:
;             return intersect(set1.rest, set2)
;         elif e1 > e2:
;             return intersect(set1, set2.rest)

(define (union s t)
    (cond ((empty? s) t)
          ((empty? t) s)
          (else (cond
                  ((= (car s) (car t)) 
                          (cons (car t) (union (cdr s) (cdr t))))
                  ((< (car s) (car t)) 
                          (cons (car s) (union (cdr s) t)))
                  ((> (car s) (car t)) 
                          (cons (car t) (union s (cdr t)))) 
                )
          )
    )
)