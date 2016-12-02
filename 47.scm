(define (mama a b)
  (if (= a 1)
    b
    (mama (- a 1) (* a b) )
    )
  )
(define (fact2 a)
  (mama a 1)
  )

