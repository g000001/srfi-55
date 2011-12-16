;;;; srfi-55.asd

(cl:in-package :asdf)

(defsystem :srfi-55
  :serial t
  :depends-on (:mbe
               :srfi-23
               :fiveam)
  :components ((:file "package")
               (:file "srfi-55")))

(defmethod perform ((o test-op) (c (eql (find-system :srfi-55))))
  (load-system :srfi-55)
  (or (flet ((_ (pkg sym)
               (intern (symbol-name sym) (find-package pkg))))
         (let ((result (funcall (_ :fiveam :run) (_ :srfi-55.internal :srfi-55))))
           (funcall (_ :fiveam :explain!) result)
           (funcall (_ :fiveam :results-status) result)))
      (error "test-op failed") ))

