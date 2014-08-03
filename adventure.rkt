#lang racket

(provide run-game
         define-states
         define-deaths)

(require racket/list
         racket/function
         racket/match
         xml
         web-server/servlet
         web-server/servlet-env
         web-server/page
         (for-syntax syntax/parse))

(module+ test
  (require rackunit))

(define handler/c (-> request? can-be-response?))

(define embed/url/c (-> handler/c string?))

(define/contract (chunkify lst n)
  (-> list? (and/c integer? positive?) (listof list?))
  (let loop ([start-lst lst]
             [new-lst '()])
    (if (null? start-lst)
        new-lst
        (loop (drop-right start-lst n) (cons (take-right start-lst n) new-lst)))))

(module+ test
  (check-equal? (chunkify (range 4) 2) '((0 1) (2 3)))
  (check-equal? (chunkify '() 3) '())
  (check-exn exn:fail:contract?
             (lambda ()
               (chunkify '(1 2 3) 2)))
  (check-exn exn:fail:contract?
             (lambda ()
               (chunkify '(1) 3))))

(define/contract (html-wrapper game-name state-html)
  (-> string? xexpr/c xexpr/c)
  `(html (head (title ,game-name))
         (body (h2 ,game-name)
               ,state-html)))

(define/contract (choice embed/url text handler)
  (-> embed/url/c string? handler/c xexpr/c)
  `(li (a ([href ,(embed/url handler)]) ,text)))

(define/contract (choices embed/url choice-clauses)
  (-> embed/url/c (listof list) xexpr/c)
  `(ol ,@(for/list ([choice-clause choice-clauses])
           (match-define (list text handler) choice-clause)
           (choice embed/url text handler))))

(define/contract (state embed/url description . choice-clauses)
  (->* (embed/url/c string?) #:rest (listof list) xexpr/c)
  `(div (p ,description)
        ,(choices embed/url (chunkify choice-clauses 2))))

(define-syntax-rule (define-state name title-message description choice-clauses ...)
  (define (name req)
    (page
     (response/xexpr
      (html-wrapper title-message
                    (state embed/url
                           description
                           choice-clauses ...))))))

(define-syntax (define-deaths stx)
  (define-splicing-syntax-class death-clause
    (pattern (~seq name:id description:expr)))
  (syntax-parse stx
    [(_ title-message:expr return-point:id death-clause:death-clause ...+)
     #'(begin
         (define-state
           death-clause.name
           title-message
           death-clause.description
           "Retry"
           return-point) ...)]))


(define-syntax-rule (define-states title-message [name description choices ...] ...)
  (begin
    (define-state name title-message description choices ...) ...))

(define run-game serve/servlet)


                