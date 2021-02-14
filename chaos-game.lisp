;;;; chaos-game.lisp

(in-package #:chaos-game)

(defparameter *speed* 10)
(defparameter *static-points* '())
(defparameter *created-points* '())
(defparameter *previous-choosen* nil)
(defparameter *current-point* nil)
(defparameter *jump-distance* 0.5)
(defparameter *paused* t)

(gamekit:defgame chaos-game () ()
  (:viewport-title "Chaos Game")
  (:viewport-width 1000)
  (:viewport-height 1000))

(defmethod gamekit:post-initialize ((app chaos-game))
  (gamekit:bind-button :space :pressed (lambda () (setf *paused* (not *paused*))))
  (setf *static-points* '())
  (setf *created-points* '())
  (push (make-instance 'point :point-position (gamekit:vec2 500 900)) *static-points*)
  (push (make-instance 'point :point-position (gamekit:vec2 100 100)) *static-points*)
  (push (make-instance 'point :point-position (gamekit:vec2 900 100)) *static-points*)
  (setf *current-point* (first *static-points*)))

(defmethod gamekit:draw ((app chaos-game))
  (loop for p in *created-points* do
    (draw-point p)))

(defmethod gamekit:act ((app chaos-game))
  (when (not *paused*)
    (dotimes (i *speed*)
      (make-point))))

(defclass point ()
  ((point-position
    :initarg :point-position
    :accessor point-position
    :initform (error "No position for point given."))))

(defmethod draw-point ((p point))
  (gamekit:draw-circle (point-position p) 1 :fill-paint (gamekit:vec4 1 0 0 1)))

(defun choose-vertex ()
  (let ((v (nth (random (length *static-points*)) *static-points*)))
    (if (eq v *previous-choosen*)
					;(choose-vertex)
	(setf *previous-choosen* v)
	(setf *previous-choosen* v))))

(defun make-point ()
  (let* ((chop (point-position (choose-vertex)))
	 (curp (point-position *current-point*))
	 (calp (gamekit:vec2
		(* (+ (gamekit:x chop) (gamekit:x curp)) *jump-distance*)
		(* (+ (gamekit:y chop) (gamekit:y curp)) *jump-distance*)))
	 (pnt (make-instance 'point :point-position calp)))
    (setf *current-point* pnt)
    (push pnt *created-points*)))
