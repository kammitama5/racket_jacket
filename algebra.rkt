#lang racket

(require (for-syntax syntax/parse))

(provide #%module-begin
         (rename-out [number-datum #%datum]
                     [plus +]
                     [subb -]
                     [allops ~]
                     [elsethen if]
                     [complain-app #%app]))

(define-syntax (number-datum stx)
  (syntax-parse stx
    [(_ . v:number) #'(#%datum . v)]
    [(_ . v:boolean) #'(#%datum . v)]
    [(_ . other) (raise-syntax-error #f "not allowed" #'other)]))

(define-syntax (elsethen stx)
  (syntax-parse stx #:datum-literals(then else)
    [(_ e0 then e1 else e2) #'(if e0 e1 e2)]
    [(_ e0 then e1) #'(if (e0) e1)]
    [(_ . other) (raise-syntax-error #f "bad syntax" #'other)]))

(define-syntax (plus stx)
  (syntax-parse stx
    [(_ n1 n2) #'(+ n1 n2)]))

(define-syntax (subb stx)
  (syntax-parse stx
    [(_ n1 n2) #'(- n1 n2)]))

;; helper function macro for all operations
(define-syntax (allops stx)
  (syntax-parse stx
    [(_ n1 n2) #'(~ n1 n2)]))

(define-syntax (complain-app stx)
  (define (complain msg src-stx)
    (raise-syntax-error 'parentheses msg src-stx))
  (define without-app-stx
    (syntax-parse stx [(_ e ...) (syntax/loc stx (e ...))]))
  (syntax-parse stx
    [(_)
     (complain "empty parentheses are not allowed" without-app-stx)]
    [(_ n:number)
     (complain "extra parentheses are not allowed around numbers" #'n)]
    [(_ x:id _ ...)
     (complain "unknown operator" #'x)]
    [_
     (complain "something is wrong here" without-app-stx)]))

(define-syntax (complain-top stx)
  (syntax-parse stx
    [(_ . x:id)
     (raise-syntax-error 'variable "unknown" #'x)]))