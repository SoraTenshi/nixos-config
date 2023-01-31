#! /usr/bin/env -S guile --no-auto-compile -s
!# 

(use-modules (ice-9 popen))
(use-modules (ice-9 rdelim))

(define (capture-output command)
  (let ((port (open-input-pipe command)))
    (let loop ((lines '()))
      (let ((line (read-line port)))
        (if (or (null? line) (eq? (length lines) 9))
          (begin
            (close-pipe port)
            (map (lambda (line) (string-append line "\n"))
              (reverse lines)))
          (loop (cons line lines)))))))

; (define (get-workspaces monitor)
;   (let ((output (capture-output "wmctrl -d")))
;     (filter (lambda (line)
;               (and (not (string-match "NSP" line))
;                    (string-match monitor line)))
;             (string-split output "\n"))))

; (display (get-workspaces 1))
(display (capture-output "wmctrl -d"))
