(define alist '((1 . "One") (2 . "Two") (3 . "Three")))
(define (my-foldl op acc l)
  (if (null? l)
      acc
      (my-foldl op (op (car l) acc) (cdr l))))

(define (my-assoc2 a b) (my-foldl (lambda (x y) (if (equal? (car x) a) x y)) #f b)
  )
