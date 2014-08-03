#lang racket/base

(require "adventure.rkt")

(define-deaths "Dungeons and Dodecahedrons" start-journey
  run-away "You have shamfeully failed. Care to try again?")

(define-states "Dungeons and Dodecahedrons"
  (start-journey "You see a dark cave."
                 "Enter" enter-cave
                 "Flee" run-away)
  (enter-cave "You are in a dark tunnel."))
  

(run-game start-journey
          #:servlet-path "/"
          #:port 8080
          #:launch-browser? #f)
