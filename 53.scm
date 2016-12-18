(define (ack m n)
    (ack0 (cons (cons m n) '()))
    )
(define (ack0 a)
    (if (and (null? (cdr a)) (number? (cdr (car a))) (= 0 (car (car a))))
     (+ (cdr (car a)) 1)
     (let ((x 0))
      (cond
       ((= (car (car a)) 0)
        (set! x (cons (cons (car (cdr a)) (+ 1 (cdr (car a)))) (cdr (cdr a))))
       )
       ((= (cdr (car a)) 0)
        (set! x (cons (cons (- (car (car a)) 1) 1) (cdr a)))
       )
       (else
        (set! x (cons (cons (car (car a)) (- (cdr (car a)) 1)) (cons (- (car (car a)) 1) (cdr a))))
       )
      )
      (ack0 x)
     )
    )
)
