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
               '("\\.py\\'" flymake-pyflakes-init))

;; flymake+coffeelint
; http://blog.kzfmix.com/entry/1334315825 
  (defun flymake-coffeelint-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "coffeelint" (list "--csv" local-file))))

  (add-to-list 'flymake-err-line-patterns
                 '(".+,\\(.+\\),\\(.+\\),\\(.+\\)"
                   nil 1 nil 3)) 
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.coffee\\'" flymake-coffeelint-init))
;; flymake+jslint
;; http://lapin-bleu.net/riviera/?p=191
(defun flymake-jslint-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
		       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "jslint" (list "--terse" local-file))))

  (setq flymake-err-line-patterns
	(cons '("^\\(.*\\)(\\([[:digit:]]+\\)):\\(.*\\)$"
		1 2 nil 3)
	      flymake-err-line-patterns))

  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.tss\\'" flymake-jslint-init)))

(load-library "flymake-cursor")
