(define (ack m n)
  (if ((= m 0) n)
    (else
      (let ((nm 0) (nn 0))
        (cond
          ((number? m) (begin
                         (set! nm (list m))
                         (set! nn n)))
          ((= (car m) 0) (begin
                           (set! nm (cdr m))
                           (set! nn (+ n 1))))
          ((= n 0) (begin
                     (set! nm (cons (- (car m) 1) (cdr m)))
                     (set! nn 1)))
          (else (begin
                  (set! nm (cons (car m)
                                 (cons (- (car m) 1) (cdr m))))
                  (set! nn (- n 1)))))
        (ack nm nn)))))
