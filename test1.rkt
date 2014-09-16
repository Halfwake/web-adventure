#lang racket/base

(require "adventure.rkt")

(define-deaths "Dungeons and Dodecahedrons" start-journey
  run-away "You have shamfeully failed. Care to try again?"
  eaten-by-grue "You have been eaten by a glutounous grue. Care to try again?"
  skeletons-flank "The skeletons surround you and tear your limbs off. Care to try again?"
  skeletons-backstab "As you run a skeleton ont he floor grabs your ankle and pulls you down. Another stabs you while you're on the ground. Care to try again?"
  dragon-fire "The Dragon knocks you into the ceiling with a flick of his tail. You hit the ground and stop moving. You are dead. Care to try again?")

(define-states "Dungeons and Dodecahedrons"
  (start-journey "You see a dark cave."
                 "Enter" enter-cave
                 "Flee" run-away)
  (enter-cave "You are in a dark tunnel."
              "Proceed" eaten-by-grue
              "Light a Torch" view-cave)
  (view-cave "You see skeletons adorned with beautiful jewlery."
             "Collect Some Gold" skeletons-awake
             "Descend Farther Into the Cave" enter-dragon-room)
  (skeletons-awake "You hear a rattling sound coming from all directions. The skeletons are coming to life."
                   "Stay and Fight" skeletons-flank
                   "Flee" skeletons-backstab)
  (enter-dragon-room "You enter a room filled with gold. A dragon is laying on a pile of gold. He glances at you briefly."
                     ))
  

(run-game start-journey
          #:servlet-path "/"
          #:port 8080
          #:launch-browser? #f)
