#lang br/quicklang

(module+ reader
  (provide read-syntax))

;; cut source-code into tokens using read
;; parse tokens into integer char->integer
;; integer-> char
;; join into string

(define (tokenize ip)
  ;; tokenize
  (for/list ([tok (in-port read ip)])
    tok
  ))

(define (tacostringtochar taco-string)
  (let* ((s (string-replace (string-replace taco-string "taco" "1") "()" "0"))
         (n (string->number s 2))
         (m (integer->char n)))
    n)
  )

(define (parse toks)
  (string-join (map tacostringtochar toks)))

(define (read-syntax src ip)
  (define toks (tokenize ip))
  (define parse-tree (parse toks))
  (strip-context
   (with-syntax ([PT parse-tree])
     #'(module untaco racket
         (display PT)
         
         ))))