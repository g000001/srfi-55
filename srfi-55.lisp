;;;; srfi-55.lisp

(cl:in-package :srfi-55.internal)

(def-suite srfi-55)

(in-suite srfi-55)

;;;; Reference implementation for SRFI-55
;
; Requirements: SRFI-23 (error reporting)

(defvar *available-extensions* '())

(defun register-extension (id action &optional (compare #'equal))
  (assert (functionp action))
  (assert (functionp compare))
  (setq *available-extensions*
        (cons (list compare
                    id
                    action)
              *available-extensions*)) )

(defun find-extension (id)
  (labels ((lookup (exts)
             (if (null exts)
                 (error "extension not found - please contact your vendor" id)
                 (let ((ext (car exts)))
                   (if (funcall (car ext) (cadr ext) id)
                       (funcall (caddr ext))
                       (lookup (cdr exts)) ) ) )))
    (lookup *available-extensions*)) )

(define-syntax require-extension
  (syntax-rules (srfi)
    ((_ "internal" (srfi id ***))
     (progn (find-extension '(srfi id) ***)) )
    ((_ "internal" id)
     (find-extension 'id) )
    ((_ clause ***)
     (progn (require-extension "internal" clause) ***)) ) )

; Example of registering extensions:
;
;   (register-extension '(srfi 1) (lambda () (load "/usr/local/lib/scheme/srfi-1.scm")))
;
; (register-extension '(srfi 1)
;                     #+quicklisp
;                     (lambda () (ql:quickload :srfi-1)))

;(require-extension (srfi 1))
;>>  To load "srfi-1":
;>>    Load 1 ASDF system:
;>>      srfi-1
;>>  ; Loading "srfi-1"
;>>
;>>
;=>  (:SRFI-1)

(test require-extension
  (is (equal '() (require-extension)))
  (is (equal (#+sbcl sb-cltl2:macroexpand-all
                     '(require-extension (srfi 1 13 14)))
             '(PROGN (PROGN (FIND-EXTENSION '(SRFI 1) '(SRFI 13) '(SRFI 14)))))))


;;; eof
