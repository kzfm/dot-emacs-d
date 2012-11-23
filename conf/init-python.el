(add-hook 'python-mode-hook
                   '(lambda()
                        (setq indent-tabs-mode nil)
                        (setq indent-level 4)
                        (setq python-indent 4)
                        (setq tab-width 4)))

;; http://d.hatena.ne.jp/cou929_la/20110525/1306321857

(add-hook 'python-mode-hook '(lambda () 
     (define-key python-mode-map "\C-m" 'newline-and-indent)))

;; electric-pair-mode

(add-hook 'python-mode-hook 'electric-pair-mode)

;; jedi
;(autoload 'jedi:setup "jedi" nil t)
;(add-hook 'python-mode-hook 'jedi:ac-setup)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:setup-keys t)
(setq jedi:complete-on-dot t)
(require 'jedi)
