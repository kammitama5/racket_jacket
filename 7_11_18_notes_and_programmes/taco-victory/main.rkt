#lang br/quicklang
(require brag/support "grammar.rkt")
(provide (all-from-out br/quicklang) (all-defined-out))

(module+ reader
  (provide read-syntax))


(define (taco-program . pieces)
  pieces
  )

(define (taco-leaf . pieces)
  (integer->char
     (for/sum ([val (in-list pieces)]
               [power (in-naturals)]
               #:when (equal? val 'taco))
       (expt 2 power))))

(define (taco)
  'taco
  )

(define (not-a-taco)
  'not-a-taco
  )



(define tokenize
  (lexer
   ["#$" "#$"]
   ["%" "%"]
   ["#" "#"]
   ["$" "$"]
   [any-char (tokenize input-port)]))
;;(apply-lexer tokenize "\n#$#$#$%#$%%\n")
;; produces '("#$" "#$" "#$" "%" "#$" "%" "%")

(define (read-syntax src ip)
  (define token-thunk (λ () (tokenize ip)))
  (define parse-tree (parse token-thunk))
  (strip-context
   (with-syntax ([PT parse-tree])
     #'(module winner taco-victory
         (display (apply string PT))))))