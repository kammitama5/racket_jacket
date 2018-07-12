#lang racket
(require (for-syntax syntax/parse))
(provide #%module-begin
         (rename-out [literal-datum #%datum]
                     [app   #%app]
                     ))
(module reader syntax/module-reader atomic-taco)

(define-syntax (literal-datum stx)
  (syntax-parse stx
    [(_ . other) #'(#%datum . taco)]))

(define-syntax (app stx)
  (syntax-parse stx
    [(_ name body ...) #'`(taco,body ... )]))

