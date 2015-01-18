A library for making choose-your-own-adventure games for the web. Just write the the states and run. The library will automatically build a working website for you!

Here's an example game.

<img src="http://i.imgur.com/8Wosrn3.png"/>

Lets go inside.

<img src="http://i.imgur.com/PPs1Adf.png"/>

Charge on!

<img src="http://i.imgur.com/arcJgxq.png"/>

...and we died.

Here are what the death definitions look like.
```racket
;; Excerpt from the example game.
(define-deaths "Dungeons and Dodecahedrons" start-journey
  run-away "You have shamfeully failed. Care to try again?"
  eaten-by-grue "You have been eaten by a glutounous grue. Care to try again?"
  ...rest-of-code-goes-here...)

;; Form of death definitions.
(define-deaths title-text the-start-state-so-we-can-try-again
  one-possible-death text-for-that-death
  ...)

```

Here are what state definitions look like.
```racket
;; Excerpt from the example game.
(define-states "Dungeons and Dodecahedrons"
  (start-journey "You see a dark cave."
                 "Enter" enter-cave
                 "Flee" run-away)
  (enter-cave "You are in a dark tunnel."
              "Proceed" eaten-by-grue
              "Light a Torch" view-cave)
  ...rest-of-code-goes-here...)

;; Form of state definitions.
(define-states title-text
  (name-of-state description-text
                 choice-text state-to-jump-to
                 ...)
  ...)
```

