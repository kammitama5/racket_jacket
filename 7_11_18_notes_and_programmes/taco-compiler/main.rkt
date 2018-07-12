#lang br/quicklang

(module+ reader
  (provide read-syntax))

;; read a character
;; turn it into a taco string 
(define (tokenize ip)
  ;; tokenize
  (for/list ([ch (in-port read-char ip)])
  ch))
  
(define (char-to-taco-string ch)
  (let* ((n (char->integer ch))
         (s (number->string n 2))
         (taco-string (string-replace (string-replace s "1" "taco") "0" "()")))
    (string-append "(" taco-string ")")))

(define (parse toks)
  (string-join (map char-to-taco-string toks) "\n"))

(define (read-syntax src ip)
  (define toks (tokenize ip))
  (define parse-tree (parse toks))
  (strip-context
   (with-syntax ([PT parse-tree])
     #'(module tacofied racket
         (display PT)
         ))))