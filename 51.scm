(define (my-reverse a) (yu a `()))
(define (yu a b)
(if (null? a)
  b
  (yu (cdr a) (cons (car a) b))
)
)

