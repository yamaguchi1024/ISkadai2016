(define (to_i a)
              (if a 1 0))

(define (even<odd? a b c d e)
(if (> (+ (+ (+ (+ (to_i (odd? a)) (to_i (odd? b))) (to_i (odd? c)) ) (to_i(odd? d))) (to_i(odd? e))) 2) #t #f))
