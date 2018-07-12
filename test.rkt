#lang s-exp "morn-typed-lang.rkt"
; e.g., save this to file "morn-typed-prog.rkt"
;5
;#f
;"five"
;1.1 ;; err
;(if 1 2 3) ;; err
;(if #f 2 3)
;+
;(+ 1 2)
;(+ #f 1) ;; err
 
; Running the program prints:
5 ;: Int
#f; : Bool
"five"; : String
 (if #f 2 3); : Int
 + ;: (-> Int Int Int)
 (+ 1 2); : Int
-
(- 2 3); : Int