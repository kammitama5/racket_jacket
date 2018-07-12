#lang br/quicklang

(require brag/support "grammar.rkt")
(provide (all-from-out br/quicklang) (all-defined-out))

(module+ reader
  (provide read-syntax))

(define (tokenize)
  ;; returns one token not all the tokens
    (lexer
     ["#$" lexeme]
     ["%" lexeme]
     [any-char (lex input-port)]))

(define (taco-leaf . pieces)
(integer->char
 (for/sum ([taco-or-not (in-list pieces)]
           [power (in-naturals)])
   (* taco-or-not (;;...

  
(define (taco-program . pieces)
  pieces
  )

(define (taco)
  1
  )

(define (not-a-taco)
  0
  )


