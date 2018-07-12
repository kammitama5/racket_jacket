#lang br/quicklang
(require brag/support) ; imports `lexer`

(module+ reader
  (provide read-syntax))

(define lex
  (lexer
   ["%" "taco"]
   ["#" "("]
   ["$" ")"]
   [any-char (lex input-port)])
  )


(define (tokenize ip)
 (let* ((n 
        (for/list ([tok (in-port lex
                         ip )])tok))
       (m (string-join n)))
 (for/list ((tok (in-port read (open-input-string m))))
    tok)))

(define (parse toks)
  (for/list ([tok (in-list toks)])
    (integer->char
     (for/sum ([val (in-list tok)]
               [power (in-naturals)]
               #:when (eq? val 'taco))
       (expt 2 power)))))

(define (read-syntax src ip)
  (define toks (tokenize ip))
  (define parse-tree (parse toks))
  (strip-context
   (with-syntax ([PT parse-tree])
     #'(module untaco racket
         (display (list->string 'PT))))))