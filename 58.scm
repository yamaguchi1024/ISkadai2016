(define (fix f)
 (lambda (x) ((f (fix f)) x)))
(define (fact5 a) (mama a a))
(define (mama a b) 
 ((if-fun (= b 1) 
  (lambda () a)
  (lambda () (mama (* a (- b 1)) (- b 1) ))
 ))
 (if (= b 1)
  a

 )
)
