;;;; srfi-55.asd

(cl:in-package :asdf)


(defsystem :srfi-55
  :version "20200209"
  :description "SRFI 55 for CL: require-extension"
  :long-description "SRFI 55 for CL: require-extension
https://srfi.schemers.org/srfi-55"
  :author "Felix L. Winkelmann and D.C. Frost"
  :maintainer "CHIBA Masaomi"
  :license "Unlicense"
  :serial t
  :depends-on (:mbe
               :srfi-23
               :fiveam)
  :components ((:file "package")
               (:file "srfi-55")))


(defmethod perform :after ((o load-op) (c (eql (find-system :srfi-55))))
  (let ((name "https://github.com/g000001/srfi-55")
        (nickname :srfi-55))
    (if (and (find-package nickname)
             (not (eq (find-package nickname)
                      (find-package name))))
        (warn "~A: A package with name ~A already exists." name nickname)
        (rename-package name name `(,nickname)))))


(defmethod perform ((o test-op) (c (eql (find-system :srfi-55))))
  (let ((*package*
         (find-package
          "https://github.com/g000001/srfi-55#internals")))
    (eval
     (read-from-string
      "
      (or (let ((result (run 'srfi-55)))
            (explain! result)
            (results-status result))
          (error \"test-op failed\") )"))))


;;; *EOF*


