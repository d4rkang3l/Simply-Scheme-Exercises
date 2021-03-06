; Generalize Exercise 23.14 by implementing an array structure that can have any
; number of dimensions. Instead of taking two numbers as index arguments, as the matrix
; procedures do, the array procedures will take one argument, a list of numbers. The
; number of numbers is the number of dimensions, and it will be constant for any particular
; array. For example, here is a three-dimensional array (4 * 5 * 6):
;
; > (define a1 (make-array '(4 5 6)))
; > (array-set! a1 '(3 2 3) '(the end))

(define (make-array dimensions)
  (let ((revdim (reverse dimensions)))
    (m-a-helper (cdr revdim)
                (make-list '()
                           (car revdim)
                           0))))

; This accepts the dimensions in reverse-order
; and then builds the array from the inside-out.
(define (m-a-helper dimensions vec)
  (let ((array (apply vector vec)))
    (if (null? dimensions)
      array
      (m-a-helper (cdr dimensions)
                  (make-list '()
                             (car dimensions)
                             array)))))

(define (make-list lst amount value)
  (if (= amount 0)
    lst
    (make-list (cons value lst)
               (- amount 1)
               value)))

(define (array-set! array dimension value)
  (if (null? dimension)
    #f
    (vector-set! (array-ref array (bl dimension))
                 (last dimension)
                 value)))

(define (array-ref array dimension)
  (if (null? dimension)
    array
    (array-ref (vector-ref array (car dimension))
               (cdr dimension))))
