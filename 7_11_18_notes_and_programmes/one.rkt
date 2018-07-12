#lang br/quicklang
(require brag/support racket/sequence) ;imports `lexer`

(module+ reader
  (provide read-syntax))

(define lex
  (lexer
   ["#$" null]
   ["%" 'taco]
   [any-char (lex input-port)]))

(define (tokenize ip)
  (define toklets (for/list ([tok (in-port lex ip)])
    tok))
  (for/list ([tok (in-slice 7 toklets)])
    tok))

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