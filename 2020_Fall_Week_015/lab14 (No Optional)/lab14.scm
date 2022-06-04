(define (split-at lst n)
  (define (mutate lst n)
    (cond 
        ((null? lst) nil)
        ((= n 0) nil)
        (else (cons (car lst) (mutate (cdr lst) (- n 1))))))
  (define (rest lst n)
    (cond 
        ((null? lst) nil)
        ((= n 0) (cons (car lst) (rest (cdr lst) n)))
        (else (rest (cdr lst) (- n 1)))))
  (cons (mutate lst n) (rest lst n))
)


(define (compose-all funcs)
  (lambda (x)
    (if (null? funcs)
        x
        ((compose-all (cdr funcs)) ((car funcs) x))))
)

