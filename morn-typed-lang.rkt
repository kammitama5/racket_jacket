
#lang racket
; e.g., save this to file "morn-typed-lang.rkt"
(require (for-syntax syntax/parse syntax/stx))
(provide (rename-out [typechecking-mb #%module-begin])
         + - if lambda)
 
; A TyStx is a syntax object representing a type.
; A ExprStx is a syntax object representing an expression.
; A IdStx is an identifier syntax object.
 
(begin-for-syntax
  ; compute: ExprStx -> TyStx
  ; computes the type of the given term
  (define (compute e)
    (syntax-parse e
      [:integer #'Int]
      [:number   #'Float]
      [:string #'String]
      [:boolean #'Bool]
      [((~literal if) e1 e2 e3)
      #:when (check #'e1 #'Bool)
      #:with t2 (compute #'e2)
      #:when (check #'e3 #'t2)
      #'t2]
      [((~literal lambda) (x) e)
       #'8]
      [(~literal +) #'(-> Int Int)]
      [((~literal +) e1 e2)
       #:when (check #'e1 #'Int)
       #:when (check #'e2 #'Int)
       #'Int]
      [(~literal -) #'(-> Int Int)]
      [((~literal -) e1 e2)
       #:when (check #'e1 #'Int)
       #:when (check #'e2 #'Int)
       #'Int]
      [e (raise-syntax-error
          'compute
          (format "could not compute type for term: ~a" (syntax->datum #'e)))]))  ; check : ExprStx TyStx -> Bool
  ; checks that the given term has the given type
  (define (check e t-expected)
    (define t (compute e))
    (or (type=? t t-expected)
        (raise-syntax-error
         'check
         (format "error while checking term ~a: expected ~a; got ~a")
                 (syntax->datum e)
                 (syntax->datum t-expected)
                 (syntax->datum t
                                e))))
 
  ; type=? : TyStx TyStx -> Bool
  ; type equality here is is stx equality
  (define (type=? t1 t2)
    (or (and (identifier? t1) (identifier? t2) (free-identifier=? t1 t2))
        (and (stx-pair? t1) (stx-pair? t2)
             (= (length (syntax->list t1))
                (length (syntax->list t2)))
             (andmap type=? (syntax->list t1) (syntax->list t2))))))
 
(define-syntax typechecking-mb
  (syntax-parser
    [(_ e ...)
     ; prints out each term e and its type, it if has one;
     ; otherwise raises type error
     #:do[(stx-map
           (λ (e)
               (printf "~a : ~a\n"
                       (syntax->datum e)
                       (syntax->datum (compute e))))
           #'(e ...))]
     ; this language only checks types,
     ; it doesn't run anything
     #'(#%module-begin (void))]))
