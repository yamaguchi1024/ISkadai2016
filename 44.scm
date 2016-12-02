(define (my-gcd a b)
  (if (< a b)
    (mama b a)
    (mama a b)
    ))

(define (mama a b)
  (if (= 0 (modulo a b))
    b
    (mama b (modulo a b))
    )
  )
