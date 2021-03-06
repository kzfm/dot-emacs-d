;;; ロードパスの追加
(setq load-path (append
                 '("~/.emacs.d"
                   "~/.emacs.d/packages/emacs-jedi"
                   "~/.emacs.d/packages/json-mode"
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

;; env
;(setq exec-path (cons "/Users/kzfm/.nvm/v0.8.10/bin:/usr/local/bin" exec-path))
(setenv "PATH"
  (concat "/Users/kzfm/.nvm/v0.8.10/bin:/usr/local/share/python:/Users/kzfm/bin:/usr/local/bin:/Users/kzfm/Library/Haskell/bin:" (getenv "PATH")))
(dolist (path (reverse (split-string (getenv "PATH") ":")))
(add-to-list 'exec-path path t))

(when (>= emacs-major-version 23)
 (set-face-attribute 'default nil
                     :family "monaco"
                     :height 140)
 (set-fontset-font
  (frame-parameter nil 'font)
  'japanese-jisx0208
  '("Hiragino Maru Gothic Pro" . "iso10646-1"))
 (set-fontset-font
  (frame-parameter nil 'font)
  'japanese-jisx0212
  '("Hiragino Maru Gothic Pro" . "iso10646-1"))
 (set-fontset-font
  (frame-parameter nil 'font)
  'mule-unicode-0100-24ff
  '("monaco" . "iso10646-1"))
 (setq face-font-rescale-alist
      '(("^-apple-hiragino.*" . 1.2)
        (".*osaka-bold.*" . 1.2)
        (".*osaka-medium.*" . 1.2)
        (".*courier-bold-.*-mac-roman" . 1.0)
        (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
        (".*monaco-bold-.*-mac-roman" . 0.9)
        ("-cdac$" . 1.3))))

;; keyboard bindings
(define-key global-map (kbd "C-h") 'delete-backward-char)
(define-key global-map (kbd "M-?") 'help-for-help)
(define-key global-map (kbd "M-C-g") 'grep)
; Magit rules!
;(global-set-key (kbd "C-x g") 'magit-status)
; 動的略語展開
(define-key global-map "\C-o" 'dabbrev-expand)
;; key-chord
(require 'key-chord)
(key-chord-mode 1)
(key-chord-define-global "ms" 'magit-status)
(key-chord-define-global "jk" 'delete-window)


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

;; auto-complete
(require 'auto-complete)
(global-auto-complete-mode t)

(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)

;; http://d.hatena.ne.jp/TakashiHattori/20120629/1340942555
(add-hook 'emacs-startup-hook
	  (function (lambda ()
		      (require 'auto-complete-config)
		      (ac-config-default))))

;; custom-theme
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes (quote (manoj-dark)))
 '(safe-local-variable-values (quote ((encoding . utf-8)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-function-name-face ((t (:foreground "mediumspringgreen" :weight normal :height 1.0)))))

;; ignore active-process

(defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
  "Prevent annoying \"Active processes exist\" query when you quit Emacs."
  (flet ((process-list ())) ad-do-it))

;;

(defun scss-custom ()
  "scss-mode-hook"
  (and
   (set (make-local-variable 'css-indent-offset) 2)
   (set (make-local-variable 'scss-compile-at-save) nil)
   )
  )
(add-hook 'scss-mode-hook
  '(lambda() (scss-custom)))

;; JSON
(require 'json-mode)
(add-to-list 'auto-mode-alist '("\\.tss$" . json-mode))
(add-hook 'json-mode-hook 'electric-pair-mode)
(add-hook 'json-mode-hook '(lambda ()
			     (setq js-indent-level 2)
			     ))

;; other settings
(load "conf/init-common")
(load "conf/init-python")
(load "conf/init-coffee")
(load "conf/init-sgml")
(load "conf/init-flymake")
(load "conf/init-haskell")
