#lang br/quicklang

(module+ reader
  (provide read-syntax))

;(define (tokenize ip)
;  (define next-datum (read ip))
;  (if (eof-object? next-datum)
;      empty
;      (cons next-datum (tokenize ip))))

(define (tokenize)
  (for/list ([tok (in-port read)])
    tok))


;  
;  (let ((tokens '()))
;  (while #t
;  (define input (read ip))
;  (if (eof-object? input)
;    (begin (set! tokens (cons input tokens))
;           (continue))
;    (break)))
;    (reverse tokens)))

(define (parse toks)
  ;; turns datums into atoms -> taco symbols
  (if (cons? toks)
      (map parse toks)
      'taco))

(define (read-syntax src ip)
  (define toks (tokenize ip))
  (define parse-tree (parse toks))
  (with-syntax ([(PT ...) parse-tree])
    #'(module tacofied racket
        'PT ...)))