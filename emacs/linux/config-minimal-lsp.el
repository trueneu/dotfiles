(setq lexical-binding t)
(setq gc-cons-threshold 100000000)

(require 'use-package-ensure)
(setq use-package-always-ensure t)

(use-package lsp-mode
  :commands (lsp lsp-execute-code-action)
  :hook ((c++-mode . lsp))
  :bind (("<f1>" . #'lsp-ui-doc-show))
  :custom
  (lsp-diagnostics-modeline-scope :project)
  (lsp-file-watch-threshold 5000)
  (lsp-response-timeout 2)
  (lsp-enable-file-watchers nil))

;; todo: lsp doc show is very interesting
;; todo: review customized stuff
;; todo: enable dap-mode

(use-package lsp-ui)

;; custom-file
(setq custom-file "~/.config/emacs/emacs-custom.el")
(load custom-file)

(provide 'config)
;;; config.el ends here
