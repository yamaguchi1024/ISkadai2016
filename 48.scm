(define (fib2 a)
  (if (= a 1)
    1
    (if (= a 2)
      1
      (po 1 1 (- a 2))
      )))

(define (po a b c)
  (if (= c 0)
    a
    (po (+ a b) a (- c 1))
    )
  )
