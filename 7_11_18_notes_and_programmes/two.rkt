#lang br
(require brag/support)
(define lex (lexer
             ["fo" lexeme]
             [(:: "f" (:+ "o")) 42]
             [any-char (lex input-port)]))
(for/list ([tok (in-port lex
                         (open-input-string "foobar"))])
  tok)
(for/list ([tok (in-port lex
                         (open-input-string "fobar"))])
  tok)