;;; ロードパスの追加
(setq load-path (append
                 '("~/.emacs.d"
                   "~/.emacs.d/packages"
                   "~/.emacs.d/auto-install"
                   "~/.emacs.d/conf")
                 load-path))

;;; packages.el
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;;; auto-install.el
(require 'auto-install)
(auto-install-compatibility-setup)

; 言語を日本語にする
(set-language-environment 'Japanese)

; 極力UTF-8とする
(prefer-coding-system 'utf-8)

;;; 行番号表示
(global-linum-mode t)

;;; 分割
(defun other-window-or-split ()
  (interactive)
  (when (one-window-p)
    (split-window-horizontally))
  (other-window 1))

(global-set-key (kbd "<C-tab>") 'other-window-or-split)
(global-set-key (kbd "<C-S-tab>") 'delete-window)

(add-to-list 'load-path (expand-file-name "~/.emacs.d"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/site-lisp/auto-install"))

;; C-h
(define-key global-map (kbd "C-h") 'delete-backward-char)
(define-key global-map (kbd "M-?") 'help-for-help)
(define-key global-map (kbd "C-x C-g") 'grep)

;;; 再帰的にgrep
(require 'grep)
(setq grep-command-before-query "grep -nH -r -e ")
(defun grep-default-command ()
  (if current-prefix-arg
      (let ((grep-command-before-target
             (concat grep-command-before-query
                     (shell-quote-argument (grep-tag-default)))))
        (cons (if buffer-file-name
                  (concat grep-command-before-target
                          " *."
                          (file-name-extension buffer-file-name))
                (concat grep-command-before-target " ."))
              (+ (length grep-command-before-target) 1)))
    (car grep-command)))
(setq grep-command (cons (concat grep-command-before-query " .")
                         (+ (length grep-command-before-query) 1)))

;; recentf
(setq recentf-max-saved-items 5000)
(require 'recentf-ext)
(global-set-key "\C-]" 'recentf-open-files)

(load "conf/init-python")

(require 'auto-complete)
(global-auto-complete-mode t)

(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)
