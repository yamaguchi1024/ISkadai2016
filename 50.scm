(define (my-assoc b a)
  (if (null? a)
    #f
    (if (= b (car (car a)))
      (car a)
      (my-assoc b (cdr a))
      )
    )
  )
