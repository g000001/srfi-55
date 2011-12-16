;;;; package.lisp

(cl:in-package :cl-user)

(defpackage :srfi-55
  (:use)
  (:export :find-extension
           :register-extension
           :require-extension))

(defpackage :srfi-55.internal
  (:use :srfi-55 :cl :mbe :fiveam)
  (:shadowing-import-from :srfi-23 :error))

