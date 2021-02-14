;;;; chaos-game.asd

(asdf:defsystem #:chaos-game
  :description "Describe chaos-game here"
  :author "Your Name <your.name@example.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :depends-on ("trivial-gamekit")
  :components ((:file "package")
               (:file "chaos-game")))
