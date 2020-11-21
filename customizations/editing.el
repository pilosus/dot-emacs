;; Customizations relating to editing a buffer.

;; Key binding to use "hippie expand" for text autocompletion
;; http://www.emacswiki.org/emacs/HippieExpand
(global-set-key (kbd "M-/") 'hippie-expand)

;; Lisp-friendly hippie expand
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol))

;; Remove region upon yank/input
(delete-selection-mode 1)

;; Cyrillic environment by toggle-input-method
(setq default-input-method "russian-computer")

;; Swith between buffers in multiframe window
;; substitute for C-x o or C-u [number] C-x o
(global-set-key (kbd "C-x <down>") 'previous-multiframe-window)
(global-set-key (kbd "C-x <up>") 'next-multiframe-window)

;; Show column number
(column-number-mode t)

;; Highlights matching parenthesis
(show-paren-mode 1)

;; Highlight current line
(global-hl-line-mode 1)

;; Interactive search key bindings. By default, C-s runs
;; isearch-forward, so this swaps the bindings.
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

;; Don't use hard tabs
(setq-default indent-tabs-mode nil)

;; When you visit a file, point goes to the last place where it
;; was when you previously visited the same file.
;; http://www.emacswiki.org/emacs/SavePlace
(require 'saveplace)
(setq-default save-place t)
;; keep track of saved places in ~/.emacs.d/places
(setq save-place-file (concat user-emacs-directory "places"))

;; Emacs can automatically create backup files. This tells Emacs to
;; put all backups in ~/.emacs.d/backups. More info:
;; http://www.gnu.org/software/emacs/manual/html_node/elisp/Backup-Files.html
(setq backup-directory-alist `(("." . ,(concat user-emacs-directory
                                               "backups"))))
(setq auto-save-default nil)


;; comments
(defun toggle-comment-on-line ()
  "comment or uncomment current line"
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))
(global-set-key (kbd "C-;") 'toggle-comment-on-line)

;; use 2 spaces for tabs
(defun die-tabs ()
  (interactive)
  (set-variable 'tab-width 2)
  (mark-whole-buffer)
  (untabify (region-beginning) (region-end))
  (keyboard-quit))

;; fix weird os x kill error
(defun ns-get-pasteboard ()
  "Returns the value of the pasteboard, or nil for unsupported formats."
  (condition-case nil
      (ns-get-selection-internal 'CLIPBOARD)
    (quit nil)))

(setq electric-indent-mode nil)

;;
;; Clipboard settings
;;

;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Clipboard.html#Clipboard
(setq ;; makes killing/yanking interact with the clipboard
      x-select-enable-clipboard t

      ;; Put selected text in X application to primary selection buffer
      ;; Pro: text selected somewhere with the mouse can be copied in emacs
      ;; Contra: text selected ("marked") in emacs overrides clipboard, 
      ;; so that when you marks a region to override with the clipboard, 
      ;; the clipboard changes to what's been just selected.
      ;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Primary-Selection.html#Primary-Selection
      ;;x-select-enable-primary t

      ;; Save clipboard strings into kill ring before replacing them.
      ;; When one selects something in another program to paste it into Emacs,
      ;; but kills something in Emacs before actually pasting it,
      ;; this selection is gone unless this variable is non-nil
      save-interprogram-paste-before-kill t

      ;; Shows all options when running apropos. For more info,
      ;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Apropos.html
      apropos-do-all t

      ;; Mouse yank commands yank at point instead of at click.
      mouse-yank-at-point t)
