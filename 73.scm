(define (stack-push st val)
  (cons val st)
  )
(define (stack-read st)
  (car st)
  )
(define (stack-pop st)
  (cdr st)
  )
(define (calc-add st)
  (let ((z (+ (stack-read st) (stack-read (stack-pop st)))))
     (stack-push (stack-pop (stack-pop st)) z) ))
(define (calc-sub st)
  (let ((z (* -1 (- (stack-read st) (stack-read (stack-pop st))))))
    (stack-push (stack-pop (stack-pop st)) z) ))
(define (calc-mul st)
  (let ((z (* (stack-read st) (stack-read (stack-pop st)))))
    (stack-push (stack-pop (stack-pop st)) z)))
