;; haskell ghc-mod
;; https://github.com/kazu-yamamoto/ghc-mod
;;(setq ghc-ghc-options '("-i/Users/kzfm/Library/Haskell/bin"))
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook '(lambda ()
                                (local-set-key "\C-j" (lambda () (interactive)(insert " -> ")))
                                (local-set-key "\M-j" (lambda () (interactive)(insert " => ")))
                                (local-set-key "\C-l" (lambda ()(interactive)(insert " <- ")))
                                ))

(autoload 'ghc-init "ghc" nil t)
;(add-hook 'haskell-mode-hook (lambda () (ghc-init)))﻿
(add-hook 'haskell-mode-hook (lambda () (ghc-init) (flymake-mode)))﻿

;; http://comments.gmane.org/gmane.comp.lang.haskell.cafe/85859
(defadvice inferior-haskell-load-file (after change-focus-after-load)
  "Change focus to GHCi window after C-c C-l command"
  (other-window 1))

(ad-activate 'inferior-haskell-load-file)

(add-hook 'coffee-mode-hook '(lambda ()
                                (make-local-variable 'tab-width)
				(set 'tab-width 2)
                                (local-set-key "\C-j" (lambda () (interactive)(insert " -> ")))
                                (local-set-key "\M-j" (lambda ()(interactive)(insert " => ")))
                                ))

