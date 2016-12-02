(define (if-fun exp1 exp2 exp3)
    (if exp1 exp2 exp3))
(define (fact4 a) (mama a a))
(define (mama a b) (if-fun (= b 1) a (mama (* a (- a 1)) (- b 1) )))
