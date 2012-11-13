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


;; flymake+pyflakes+pep8
; http://d.hatena.ne.jp/cou929_la/20110525/1306321857

(add-hook 'find-file-hook 'flymake-find-file-hook)
(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list (expand-file-name "~/bin/pycheckers")  (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pyflakes-init)))

(load-library "flymake-cursor")

;; ac-python
; http://chrispoole.com/project/ac-python/
;(require 'ac-python)

;; jedi
;(autoload 'jedi:setup "jedi" nil t)
;(add-hook 'python-mode-hook 'jedi:ac-setup)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:setup-keys t)
;(setq jedi:complete-on-dot t)
(require 'jedi)
