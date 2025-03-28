;;;;
;; Go lang
;;;;

;; Enable lsp-mode for go-buffers
;; requires gopls installation:
;; go install golang.org/x/tools/gopls@latest
(add-hook 'go-mode-hook 'lsp-deferred)
(add-hook 'go-mode-hook 'company-mode)

(add-hook 'before-save-hook 'gofmt-before-save)
