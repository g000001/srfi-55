;;;; package.lisp

(cl:in-package :cl-user)


(defpackage "https://github.com/g000001/srfi-55"
  (:use)
  (:export find-extension
           register-extension
           require-extension))


(defpackage "https://github.com/g000001/srfi-55#internals"
  (:use "https://github.com/g000001/srfi-55"
        cl
        mbe
        fiveam)
  (:shadowing-import-from srfi-23 error))


;;; *EOF*
