(add-hook 'coffee-mode-hook '(lambda ()
  (make-local-variable 'tab-width)
  (set 'tab-width 2)
  (local-set-key "\C-j" (lambda () (interactive)(insert " -> ")))
  (local-set-key "\M-j" (lambda ()(interactive)(insert " => ")))))

