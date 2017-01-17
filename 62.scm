;データ構造

;フレーム
;空のフレームを返す
(define empty-frame (lambda () (list)))
;変数と値を加えた新しいフレームを返す
(define update (lambda (frame var val)
                 (cons (cons var val) frame)))
;変数の値を見つける
(define lookup (lambda (var frame) (assoc var frame)))
;(define (lookup var frame)
;  (assoc var frame))

;環境
;空のフレームひとつの環境を返す
(define make-env (lambda () (list (empty-frame))))
;(define (make-env)
;  (list (empty-frame)))
;環境を受け取り空のフレームを足す
(define extend-env (lambda (env) (cons (empty-frame) env)))
;(define (extend-env env)
;  (cons (empty-frame) env))
;内側のフレームに変数と値の情報を追加
(define define-var (lambda (env var val)
                     (if (null? env)
                       #f
                       (set-car! env (update (car env) var val)))
                     env)
  )
;(define (define-var env var val)
;  (if (null? env)
;    #f
;   (set-car! env (update (car env) var val)))
;  env)
;環境から変数の値を探す
(define lookup-var (lambda (var env)
                     (if (null? env)
                       #f
                       (let ((found (lookup var (car env))))
                         (if (pair? found)
                           found
                           (lookup-var var (cdr env)))))))

;λ閉包
;λ閉包を作る
(define make-closure (lambda (env params body)
                       (cons
                         '*lambda* (cons env (cons params body))))
  )

;データがλ閉包かどうかを判定
(define data-closure? (lambda (data)
                        (and (pair? data) (equal? (car data) '*lambda*))))
;環境を取り出す
(define closure-env (lambda (x) (car (cdr x))))
;パラメータを取り出す
(define closure-params (lambda (x) (car (cdr (cdr x)))))
;本体部分を取り出す
(define closure-body (lambda (x) (cdr (cdr (cdr x)))))

;組み込み関数
;組み込み関数の本体を作る
(define make-primitive (lambda (arity fun)
                         (list '*primitive* arity fun))
  )

;データが組み込み関数かどうか判定

(define data-primitive? (lambda (data)
                          (and (pair? data) (equal? (car data) '*primitive*))))
;引数を取り出す
(define primitive-arity (lambda (x) (car (cdr x))))
;関数を取り出す
(define primitive-fun (lambda (x) (car (cdr (cdr x)))))

;データ構造を感じにprintする
(define print-data (lambda (data)
                     (if (data-closure? data) 
                       (display "#<closure>")
                       (if (data-primitive? data)
                         (display "#<primitive>")
                         (if (equal? data '*unspecified*) 
                           (display "#<unspecified>")
                           (if (equal? data '*error*)
                             (display "#<error>")
                             (write data)))))
                     ))


;とりあえず。
(define correct-syntax? (lambda (type exp) #t))
;定数かどうか
(define constant? (lambda (exp)
                    (or (or (boolean? exp) (number? exp)) (string? exp))))
;式の形によって条件分岐する
(define base-eval (lambda (env exp)
                    (if (eof-object? exp)
                      (cons env '*exit*)
                      (if (constant? exp)
                        (cons env exp)
                        (if (symbol? exp)
                          (var-eval env exp)
                          (if (not (pair? exp))
                            (eval-error env 'unknown-data exp)
                            (if (equal? (car exp) 'exit) 
                              (cons env '*exit*)
                              (if (equal? (car exp) 'define)
                                (def-eval env exp)
                                (if (equal? (car exp) 'let)
                                  (let-eval env exp)
                                  (if (equal? (car exp) 'letrec)
                                    (letrec-eval env exp)
                                    (if (equal? (car exp) 'lambda)
                                      (lambda-eval env exp)
                                      (if (equal? (car exp) 'if)
                                        (if-eval env exp)
                                        (if (equal? (car exp) 'begin)
                                          (begin-eval env exp)
                                          (if (equal? (car exp) 'quote) 
                                            (quote-eval env exp)
                                            (app-eval env exp)))))))))))))))
;エラー処理
(define eval-error (lambda (env type exp)
                     (display "ERROR: ")
                     (write type)
                     (display ": ")
                     (print-data exp)
                     (newline)
                     (cons env '*error*)))

;quote-eval
(define quote-eval (lambda (env exp)
                     (if (correct-syntax? 'quote exp)
                       (cons env (car (cdr exp)))
                       (eval-error env 'syntax-error exp)
                       )
                     )
  )

;var-eval
(define var-eval (lambda (env exp)
                   (if (correct-syntax? 'var exp)
                     (cons env (cdr (lookup-var exp env)))
                     (eval-error env 'syntax-error exp))))

;if-eval
(define if-eval (lambda (env exp)
                  (if (cdr (base-eval env (cadr exp))) 
                    (base-eval env (car (cdr (cdr exp))))
                    (base-eval env (car (cdr (cdr (cdr exp)))))
                    )
                  )
  )

;letの処理
(define let-eval (lambda (env exp)
                   (if (correct-syntax? 'let exp)
                     (base-eval env (let->app exp))
                     (eval-error env 'syntax-error exp))))

(define let->app (lambda (exp)
                   (let ((decl (car (cdr exp)))
                         (body (cdr (cdr exp))))
                     (cons (cons 'lambda (cons (map car decl) body))
                           (map cadr decl)))))

;defineの処理
(define def-eval (lambda (env exp)
                   (if (correct-syntax? 'define exp)
                     (let ((var (cadr exp)))
                     (let ((res (base-eval env (car (cdr (cdr exp))))))
                     (let ((env (car res))
                            (val (cdr res)))
                       (cons (define-var env var val) var))))
                     (eval-error env 'syntax-error exp))))

;lambdaの処理
(define lambda-eval (lambda (env exp)
                      (if (correct-syntax? 'lambda exp)
                        (cons env (make-closure env (cadr exp) (cdr (cdr  exp))))
                        (eval-error env 'syntax-error exp))))

;app-eval
(define map-base-eval (lambda (env el)
                        (cons env
                              (map (lambda (exp) (cdr (base-eval env exp))) el))))

(define app-eval (lambda (env exp)
                   (if (correct-syntax? 'app exp)
                     (let ((l (map-base-eval env exp)))
                     (let  ((env (car l))
                            (fun (cadr l))
                            (args (cdr (cdr l)))
                            )
                       (base-apply env fun args)))
                     (eval-error env 'synatx-error exp))))

;環境にパラメータと引数を繰り返し追加する関数
(define base-apply-data (lambda (env parms args)
                          (if (null? parms)
                            env
                            (base-apply-data (define-var env (car parms) (car args)) (cdr parms) (cdr args))
                            )
                          )
  )

;funが複数あってもできるようにした
(define base-apply-fun (lambda (env fun)
                         (if (null? (cdr fun))
                           (cdr (base-eval env (car fun)))
                           (base-apply-fun (car (base-eval env (car fun))) (cdr fun))
                           )
                         )
  )



(define base-apply (lambda (env fun args)
                     (if (data-closure? fun)
                       (cons env (base-apply-fun (base-apply-data (extend-env (closure-env fun)) (closure-params fun) args) (closure-body fun)))
                       (if (data-primitive? fun)
                         (if (or (not (number? (primitive-arity fun)))
                                 (= (primitive-arity fun) (length args)))
                           ((primitive-fun fun) env args)
                           (eval-error env 'wrong-number-of-args fun))
                         (eval-error env 'nanika-wrong fun))))
  )


;make-top-env
(define make-top-env (lambda () 
                       (let ((env (make-env)))
                       (let ((env (define-var env '=
                                               (make-primitive 2 (lambda (env args)
                                                                   (cons env (= (car args) (cadr args))))))))
                       (let ((env (define-var env '>
                                               (make-primitive 2 (lambda (env args)
                                                                   (cons env (> (car args) (cadr args))))))))
                       (let ((env (define-var env '<
                                               (make-primitive 2 (lambda (env args)
                                                                   (cons env (< (car args) (cadr args))))))))
                       (let ((env (define-var env '+
                                               (make-primitive 2 (lambda (env args)
                                                                   (cons env (+ (car args) (cadr args))))))))
                       (let ((env (define-var env '-
                                               (make-primitive 2 (lambda (env args)
                                                                   (cons env (- (car args) (cadr args))))))))
                       (let ((env (define-var env '*
                                               (make-primitive 2 (lambda (env args)
                                                                   (cons env (* (car args) (cadr args))))))))
                       (let ((env (define-var env 'and
                                               (make-primitive 2 (lambda (env args)
                                                                   (cons env (and (car args) (cadr args))))))))
                       (let ((env (define-var env 'or
                                               (make-primitive 2 (lambda (env args)
                                                                   (cons env (or (car args) (cadr args))))))))
                       (let ((env (define-var env 'list
                                               (make-primitive #f (lambda (env args) (cons env args))))))
                       (let ((env (define-var env 'cons
                                               (make-primitive #f (lambda (env args) (cons env (cons (car args) (cadr args))))))))
                       (let ((env (define-var env 'assoc
                                               (make-primitive #f (lambda (env args) (cons env (assoc (car args) (cadr args))))))))
                       (let ((env (define-var env 'set-car!
                                               (make-primitive #f (lambda (env args) (cons env (set-car! (car args) (cadr args))))))))
                       (let ((env (define-var env 'map
                                               (make-primitive #f (lambda (env args) (cons env (map (car args))))))))
                       (let ((env (define-var env 'car
                                               (make-primitive #f (lambda (env args) (cons env (caar args)))))))
                        (let ((env (define-var env 'cdr
                                               (make-primitive #f (lambda (env args) (cons env (cdar args)))))))
                        (let ((env (define-var env 'null?
                                               (make-primitive 1 (lambda (env args)
                                                                   (cons env (null? (car args))))))))
                        (let ((env (define-var env 'not
                                               (make-primitive 1 (lambda (env args)
                                                                   (cons env (not (car args))))))))
                        (let ((env (define-var env 'pair?
                                               (make-primitive 1 (lambda (env args)
                                                                   (cons env (pair? (car args))))))))
                        (let ((env (define-var env 'boolean?
                                               (make-primitive 1 (lambda (env args)
                                                                   (cons env (boolean? (car args))))))))
                        (let ((env (define-var env 'number?
                                               (make-primitive 1 (lambda (env args)
                                                                   (cons env (number? (car args))))))))
                        (let ((env (define-var env 'string?
                                               (make-primitive 1 (lambda (env args)
                                                                   (cons env (string? (car args))))))))
                        (let ((env (define-var env 'eof-object?
                                               (make-primitive 1 (lambda (env args)
                                                                   (cons env (eof-object? (car args))))))))
                        (let ((env (define-var env 'symbol?
                                               (make-primitive 1 (lambda (env args)
                                                                   (cons env (symbol? (car args))))))))
                        (let ((env (define-var env 'cadr
                                               (make-primitive 1 (lambda (env args)
                                                                   (cons env (car (cdr (car args)))))))))
                        (let ((env (define-var env 'read
                                               (make-primitive 1 (lambda (env args)
                                                                   (cons env (read (car args))))))))
                        (let ((env (define-var env 'write
                                               (make-primitive 1 (lambda (env args)
                                                                   (cons env (write (car args))))))))
                        (let ((env (define-var env 'newline
                                               (make-primitive 0 (lambda (env args)
                                                                   (cons env (newline)))))))
                        (let ((env (define-var env 'equal?
                                               (make-primitive 2 (lambda (env args)
                                                                   (cons env (equal? (car args) (cadr args))))))))
                        (let ((env (define-var env 'display
                                               (make-primitive
                                                 1
                                                 (lambda (env args)
                                                   (display (car args))
                                                   (cons env '*unspecified*)))))) env
                        )))))))))))))))))))))))))))))
                         )))

;処理系本体
(define scheme (lambda () 
                 (let ((top-env (make-top-env)))
                   (define rep-loop (lambda (env)
                     (display "mama> ")
                     (let ((res (base-eval env (read))))
                        (let ((env (car res))
                            (val (cdr res)))
                       (print-data val)
                       (newline)
                       (if (equal? val '*exit*)
                         #t
                         (rep-loop env))))
                     ))
                   (rep-loop top-env))))
