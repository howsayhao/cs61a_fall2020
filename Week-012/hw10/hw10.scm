(define (accumulate combiner start n term)
  (if (= n 0)
      start
      (if (< start n)
        (combiner (term start) (accumulate combiner (+ start 1) n term))
        (term n)
      )
  )
)

(define (accumulate-tail combiner start n term)
  (and
    (define (accumulate-mutate all combiner start n term)
      (if (= n 0) 
        all
        (if (<= start n)
          (accumulate-mutate (combiner all (term start)) combiner (+ start 1) n term)
          all
        )
      )  
    )
    (accumulate-mutate start combiner start n term)
  )
)

(define-macro (list-of expr for var in seq if filter-fn)
  ;(list 'map (list 'lambda (list var) expr) (list 'filter (list 'lambda (list var) filter-fn) seq))
  `(map (lambda ( ,var) ,expr) (filter (lambda (, var) ,filter-fn) ,seq))
)



