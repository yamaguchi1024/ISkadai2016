(define (ack m n)
  (if (and (= 0 m) (number? n))
    (+ n 1)
    (if (and (number? m) (= n 0))
      (ack (- m 1) 1)
      (let ((a 0) (b 0))
        (cond
          ((number? n)
           (set! a (- m 1))
           (set! b (cons (cons m (- n 1)) '()))
           )
          ((= (car (car n)) 0)
           (set! a m)
           (set! b (cons (cons (car (cdr n)) (+ 1 (cdr (car n)))) (cdr (cdr n))))
           )
          ((= (cdr (car  n)) 0)
           (set! a m)
           (set! b (cons (cons (- (car (car n)) 1) 1) (cdr n)))
           )
          (else
            (set! a m)
            (set! b (cons (cons (car (car n)) (- (cdr (car n)) 1)) (cons (- (car (car n)) 1) (cdr n))))
            )
          )
        (ack a b)
        )
      )
    )
  )

(define (ack2 m n)
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
