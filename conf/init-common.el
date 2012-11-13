;;; emacs起動時のwelcome ぽい画面を表示しない
(setq inhibit-splash-screen t) 

;;; メタキーとoption入れ替え
(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))
;(set-keyboard-coding-system nil)
;(setq mac-command-key-is-meta t)

;;; メニューバーとツールバーの非表示
(menu-bar-mode -1)
(tool-bar-mode -1)

(display-time-mode 1) ; 時間の表示
(line-number-mode 1) ; 行番号の表示
(column-number-mode 1) ; 列番号の表示
(display-battery-mode 1) ; バッテリー残量の表示
(setq ring-bell-function (lambda ())) ; ビープを無効化し画面のちらつきも防ぐ

(set-frame-parameter (selected-frame)  'alpha  '(80 40))

;;; 行番号表示
(global-linum-mode t)
(setq linum-format "%4d")

;;; max-frame
;(require 'maxframe)
;(add-hook 'window-setup-hook 'maximize-frame t)
(set-frame-size (selected-frame) 150 40)

;; 括弧の対応をハイライト.
(show-paren-mode 1)

;; BS で選択範囲を消す
(delete-selection-mode 1)

;;ビープ音を消す
;;(setq ring-bell-function 'ignore)

;;リージョン色づけ
(setq transient-mark-mode t)

;;一行カット
(setq kill-whole-line t)

;; iswitch
(iswitchb-mode 1)

;; 画面分割
;; (defun other-window-or-split ()
;;   (interactive)
;;   (when (one-window-p)
;;     (split-window-horizontally))
;;   (other-window 1))

;; (global-set-key (kbd "<C-tab>") 'other-window-or-split)
