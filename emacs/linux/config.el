(setq lexical-binding t)
(setq gc-cons-threshold (* 1024 1024 1024))
(setq native-comp-async-report-warnings-errors nil)

(require 'use-package-ensure)
(setq use-package-always-ensure t)

(use-package exec-path-from-shell
  :init (exec-path-from-shell-initialize))

(use-package gnu-elpa-keyring-update)


;; unbind cmd-keys
(unbind-key "s-,")
(unbind-key "s-'")
(unbind-key "s-`")
(unbind-key "s-~")
(unbind-key "s--")
(unbind-key "s-:")
(unbind-key "s-?")
(unbind-key "s-^")
(unbind-key "s-&")
(unbind-key "s-C")
(unbind-key "s-D")
(unbind-key "s-E")
(unbind-key "s-L")
(unbind-key "s-M")
(unbind-key "s-S")
(unbind-key "s-a")
(unbind-key "s-c")
(unbind-key "s-d")
(unbind-key "s-e")
(unbind-key "s-f")
(unbind-key "s-g")
(unbind-key "s-h")
(unbind-key "s-H")
(unbind-key "M-s-h")
(unbind-key "s-j")
(unbind-key "s-k")
(unbind-key "s-l")
(unbind-key "s-m")
(unbind-key "s-n")
(unbind-key "s-o")
(unbind-key "s-p")
(unbind-key "s-q")
(unbind-key "s-s")
(unbind-key "s-t")
(unbind-key "s-u")
(unbind-key "s-v")
(unbind-key "s-w")
(unbind-key "s-x")
(unbind-key "s-y")
(unbind-key "s-z")
(unbind-key "s-+")
(unbind-key "s-=")
(unbind-key "s--")
(unbind-key "s-0")
(unbind-key "s-|")
(unbind-key "<f10>")
(unbind-key "<f1>")
(unbind-key "<C-left>")
(unbind-key "<C-right>")

(unbind-key "C-x C-f") ;; find-file-read-only
(unbind-key "C-x C-d") ;; list-directory
(unbind-key "C-z") ;; suspend-frame
(unbind-key "M-o") ;; facemenu-mode
(unbind-key "<mouse-2>") ;; pasting with mouse-wheel click
(unbind-key "<C-wheel-down>") ;; text scale adjust
(unbind-key "<C-wheel-up>") ;; ditto

(setq
 ;; No need to see GNU agitprop.
 inhibit-startup-screen t
 ;; No need to remind me what a scratch buffer is.
 initial-scratch-message nil
 ;; Double-spaces after periods is morally wrong.
 sentence-end-double-space nil
 ;; Never ding at me, ever.
 ring-bell-function 'ignore
 ;; Prompts should go in the minibuffer, not in a GUI.
 use-dialog-box nil
 ;; Fix undo in commands affecting the mark.
 mark-even-if-inactive nil
 ;; Let C-k delete the whole line.
 kill-whole-line t
 ;; search should be case-sensitive by default
 case-fold-search nil
 ;; no need to prompt for the read command _every_ time
 compilation-read-command nil
 )

(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq-default c-basic-offset 2)
;; (setq indent-line-function 'insert-tab)

(defalias 'yes-or-no-p 'y-or-n-p) ; Accept 'y' in lieu of 'yes'.

(set-charset-priority 'unicode)
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))

(delete-selection-mode t)
(global-display-line-numbers-mode t)
(column-number-mode)

(setq
 make-backup-files nil
 auto-save-default nil
 create-lockfiles nil)

(setq custom-file null-device)
(setq custom-safe-themes t)

(require 'recentf)
(add-to-list 'recentf-exclude "\\elpa")

;; (if ( version< "27.0" emacs-version ) ; )
;;     (set-fontset-font "fontset-default" 'unicode "Apple Color Emoji" nil 'prepend)
;;   (warn "This Emacs version is too old to properly support emoji."))

(add-hook 'before-save-hook #'delete-trailing-whitespace)
(setq require-final-newline t)

(use-package keychain-environment
  :config
  (keychain-refresh-environment))

(defvar work-environment-p nil)
(if (or (file-exists-p "/Users/pgurkov") (file-exists-p "/home/pgurkov"))
    (setq work-environment-p t))

(exec-path-from-shell-copy-env "SSH_AGENT_PID")
(exec-path-from-shell-copy-env "SSH_AUTH_SOCK")
(exec-path-from-shell-copy-env "GOPATH")

(defalias 'view-emacs-news 'ignore)
(defalias 'describe-gnu-project 'ignore)

(use-package undo-tree
  :diminish
  :bind (("C-c _" . undo-tree-visualize) ("C-_" . undo-tree-undo))
  :config
  (global-undo-tree-mode +1)
  (unbind-key "M-_" undo-tree-map))

(setq enable-local-variables :all)

;; (ignore-errors (set-frame-font "Menlo-14"))
;; don't forget to try the emacs GUI mode here and figure out how JetBrains Mono is called here

;; maximize the window
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; remove window chrome
(when (window-system)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (tooltip-mode -1))

(use-package all-the-icons
  :defer 0.5)

;; Doom themes, useful for gui

(when (window-system)
  (use-package doom-themes
    :config
    (let ((chosen-theme 'doom-solarized-light))
      (doom-themes-visual-bell-config)
      (doom-themes-org-config)
      (setq doom-challenger-deep-brighter-comments t
            doom-challenger-deep-brighter-modeline t)
      (load-theme chosen-theme))))

;; https://stackoverflow.com/questions/18904529/after-emacs-deamon-i-can-not-see-new-theme-in-emacsclient-frame-it-works-fr
;; theme

(defvar my:theme 'doom-solarized-light)
(defvar my:theme-window-loaded nil)
(defvar my:theme-terminal-loaded nil)

(if (daemonp)
    (add-hook 'after-make-frame-functions(lambda (frame)
                                           (select-frame frame)
                                           (if (window-system frame)
                                               (unless my:theme-window-loaded
                                                 (if my:theme-terminal-loaded
                                                     (enable-theme my:theme)
                                                   (load-theme my:theme t))
                                                 (setq my:theme-window-loaded t))
                                             (unless my:theme-terminal-loaded
                                               (if my:theme-window-loaded
                                                   (enable-theme my:theme)
                                                 (load-theme my:theme t))
                                               (setq my:theme-terminal-loaded t)))))

  (progn
    (load-theme my:theme t)
    (if (display-graphic-p)
        (setq my:theme-window-loaded t)
      (setq my:theme-terminal-loaded t))))

;; (require 'gnutls)
;; (when (and (string= "27" (substring emacs-version 0 2))
;;     (null gnutls-algorithm-priority))
;;   ;; This appears to be a bug in emacs 26 that prevents the gnu archive from being downloaded.
;;   ;; This solution is from https://www.reddit.com/r/emacs/comments/cdf48c/failed_to_download_gnu_archive/
;;   (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.2"))

;; ;; Most major modes pollute the modeline, so we pull in diminish.el to quiesce them.
;; (use-package diminish
;;   :config (diminish 'eldoc-mode))

(use-package doom-modeline
  :init (setq doom-modeline-icon (display-graphic-p))
  :config (doom-modeline-mode))

(use-package dimmer
  :custom (dimmer-fraction 0.1)
  :config (dimmer-mode))

(show-paren-mode)

(use-package rainbow-delimiters
  :hook ((prog-mode . rainbow-delimiters-mode)))

(use-package tree-sitter
  :init (global-tree-sitter-mode)
  :hook ((ruby-mode . tree-sitter-hl-mode)
         (js-mode . tree-sitter-hl-mode)
         (typescript-mode . tree-sitter-hl-mode)
         (go-mode . tree-sitter-hl-mode)
         (c++-mode . tree-sitter-hl-mode)))

(use-package tree-sitter-langs)

;; enable scrolling to the beginning/end of file
(setq scroll-error-top-bottom t)


;; tabs (do I really need those?..)
(use-package centaur-tabs
  :demand
  :config
  (centaur-tabs-mode t)
  :custom
  (centaur-tabs-gray-out-icons 'buffer)
  (centaur-tabs-style "rounded")
  (centaur-tabs-height 36)
  (centaur-tabs-set-icons t)
  (centaur-tabs-set-modified-marker t)
  (centaur-tabs-modified-marker "●")
  (centaur-tabs-buffer-groups-function #'centaur-tabs-projectile-buffer-groups)

  :bind
  (("<C-iso-lefttab>" . #'centaur-tabs-backward)
   ("<C-tab>" . #'centaur-tabs-forward)))

;; (setq centaur-tabs-set-bar 'over)
;; (setq x-underline-at-descent-line t)

(use-package multiple-cursors
  :bind (("C-c m m" . #'mc/edit-lines )
         ("C-c m d" . #'mc/mark-all-dwim )))

(set-fill-column 135)

(use-package expand-region
  :bind (("<M-up>" . er/expand-region)
         ("<M-down>" . er/contract-region)))

(use-package avy
  :bind ("C-c l" . avy-goto-line))

(use-package ivy-avy)

(use-package iedit)

(electric-pair-mode)

(defun pt/eol-then-newline ()
  "Go to end of line, then newline-and-indent."
  (interactive)
  (move-end-of-line nil)
  (newline-and-indent))

(bind-key "s-<return>" #'pt/eol-then-newline)

(use-package sudo-edit)

(defun dired-up-directory-same-buffer ()
  "Go up in the same buffer."
  (find-alternate-file ".."))

(defun my-dired-mode-hook ()
  (put 'dired-find-alternate-file 'disabled nil) ; Disables the warning.
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
  (define-key dired-mode-map (kbd "^") (lambda () (interactive) (dired-up-directory-same-buffer))))

(add-hook 'dired-mode-hook #'my-dired-mode-hook)

(setq dired-use-ls-dired nil)

(global-so-long-mode)

(use-package duplicate-thing
  :init
  (defun my-duplicate-thing ()
    "Duplicate thing at point without changing the mark."
    (interactive)
    (save-mark-and-excursion (duplicate-thing 1)))
  :bind (("C-c u" . my-duplicate-thing)
         ("C-c C-u" . my-duplicate-thing)))

(setq read-process-output-max (* 10 1024 1024)) ; 1mb

(use-package which-key
  :custom
  (which-key-setup-side-window-bottom)
  (which-key-enable-extended-define-key t)
  :config
  (which-key-mode)
  (which-key-setup-minibuffer))

(defun revert-to-two-windows ()
  "Delete all other windows and split it into two."
  (interactive)
  (delete-other-windows)
  (split-window-right))

(bind-key "C-x 1" #'revert-to-two-windows)
(bind-key "C-x !" #'delete-other-windows) ;; Access to the old keybinding.

(bind-key "s-g" #'abort-recursive-edit)

(defun kill-this-buffer ()
  "Kill the current buffer."
  (interactive)
  (kill-buffer nil)
  )

(bind-key "C-x k" #'kill-this-buffer)
(bind-key "C-x K" #'kill-buffer)

(defun copy-file-name-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode) default-directory (buffer-file-name))))
    (when filename
      (kill-new filename)
      (message "Copied buffer file name '%s' to the clipboard." filename))))

(bind-key "C-c P" #'copy-file-name-to-clipboard)

(use-package ace-window
  :config
  ;; Show the window designators in the modeline.
  (ace-window-display-mode)

  ;; Make the number indicators a little larger. I'm getting old.
  (set-face-attribute 'aw-leading-char-face nil :height 2.0 )

  (defun my-ace-window (args)
    "As ace-window, but hiding the cursor while the action is active."
    (interactive "P")
    (cl-letf
        ((cursor-type nil)
         (cursor-in-non-selected-window nil))
      (ace-window nil)))


  :bind (("s-O" . my-ace-window))
  :custom
  (aw-keys '(?h ?t ?n ?s ?a ?o ?e ?u ?i ?d) "Designate windows by home row keys, not numbers.")
  (aw-background nil))

(setq enable-recursive-minibuffers t)
(minibuffer-depth-indicate-mode)

(defun switch-to-scratch-buffer ()
  "Switch to the current session's scratch buffer."
  (interactive)
  (switch-to-buffer "*scratch*"))

;; skipped orgmode section for now -- it seems very complex

(use-package magit
  :diminish magit-auto-revert-mode
  :diminish auto-revert-mode
  :bind (("C-c g" . #'magit-status))
  :custom
  (magit-repository-directories '(("~/git_tree" . 1)))
  :config
  (add-to-list 'magit-no-confirm 'stage-all-changes))

(use-package libgit)

(use-package magit-libgit
  :after (magit libgit))

(use-package forge
  :after magit)

;; todo : no ssh-agent access seemingly

(use-package projectile
  :init
                                        ;  (setq projectile-keymap-prefix (kbd "C-c p"))
  (setq projectile-keymap-prefix (kbd "s-p"))
  :diminish
  :bind (("s-p k" . #'projectile-kill-buffers)
         ("s-p M" . #'projectile-compile-project)
         ("s-p s-F" . #'projectile-ripgrep))
  :custom
  (projectile-completion-system 'ivy)
  (projectile-enable-caching t)
  :config
  (projectile-mode)
  (setq projectile-project-search-path '("~/git_tree" "~/gopath/src"))
  (setq projectile-sort-order 'recently-active))

(use-package ivy
  :diminish
  :custom
  (ivy-height 30)
  (ivy-use-virtual-buffers t)
  (ivy-use-selectable-prompt t)
  :config
  (ivy-mode 1)

  :bind (("C-c C-r" . #'ivy-resume)
         ("C-c s"   . #'swiper-thing-at-point)
         ("C-s"     . #'swiper)))

(setq ivy-re-builders-alist
      '((swiper . ivy--regex-plus)
        (t      . ivy--regex-fuzzy)))

(use-package ivy-rich
  :custom
  (ivy-virtual-abbreviate 'full)
  (ivy-rich-switch-buffer-align-virtual-buffer nil)
  (ivy-rich-path-style 'full)
  :config
  (setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line)
  (ivy-rich-mode))

(use-package counsel
  :init
  (counsel-mode 1)

  :bind (("C-c ;" . #'counsel-M-x)
         ("C-c U" . #'counsel-unicode-char)
         ("C-c i" . #'counsel-imenu)
         ("C-x f" . #'counsel-find-file)
         ("C-c y" . #'counsel-yank-pop)
         ("C-c r" . #'counsel-recentf)
         ("C-c v" . #'counsel-switch-buffer-other-window)
         ("C-c H" . #'counsel-projectile-rg)
         ("C-h h" . #'counsel-command-history)
         ("C-x C-f" . #'counsel-find-file)
         :map ivy-minibuffer-map
         ("C-r" . counsel-minibuffer-history))
  :diminish)

(use-package counsel-projectile
  :bind (("C-c f" . #'counsel-projectile)
         ("C-c F" . #'counsel-projectile-switch-project)))

;; todo read on flycheck
(use-package flycheck
  :after org
  :hook
  (org-src-mode . disable-flycheck-for-elisp)
  :custom
  (flycheck-emacs-lisp-initialize-packages t)
  ;; (flycheck-display-errors-delay 0.1)
  (flycheck-check-syntax-automatically '(save mode-enabled))
  :config
  (global-flycheck-mode)
  (flycheck-set-indication-mode 'left-margin)

  (defun disable-flycheck-for-elisp ()
    (setq-local flycheck-disabled-checkers '(emacs-lisp-checkdoc)))

  (add-to-list 'flycheck-checkers 'proselint)
  (setq-default flycheck-disabled-checkers '(haskell-stack-ghc)))

(use-package flycheck-inline
  :config (global-flycheck-inline-mode))

(use-package deadgrep
  :bind (("C-c h" . #'deadgrep)
         ("s-F" . #'deadgrep)))         ; todo: s-F to find

(use-package ripgrep)

;; todo: strange keybind
(use-package visual-regexp
  :bind (("M-%" . #'vr/replace)))

(use-package pcre2el)

(use-package visual-regexp-steroids)

;; irony

;; todo: bind doesn't work

(use-package company-irony)

(use-package company
  :diminish
  :bind (("C-." . #'company-capf))
  :hook (prog-mode . company-mode)
  :custom
  (company-dabbrev-downcase nil "Don't downcase returned candidates.")
  (company-show-numbers t "Numbers are helpful.")
  (company-tooltip-limit 20 "The more the merrier.")
  (company-tooltip-idle-delay 0.4 "Faster!")
  (company-async-timeout 20 "Some requests can take a long time. That's fine.")
  :config
  (add-to-list 'company-backends 'company-irony)
  ;; Use the numbers 0-9 to select company completion candidates
  ;; (let ((map company-active-map))
  ;;   (mapc (lambda (x) (define-key map (format "%d" x)
  ;;       		`(lambda () (interactive) (company-complete-number ,x))))
  ;;         (number-sequence 0 9)))
  )

;; look how to slow down communication with LSP a little bit

(use-package lsp-mode
  :commands (lsp lsp-execute-code-action)
  :hook ((go-mode . lsp-deferred)
         (lsp-mode . lsp-enable-which-key-integration)
         (lsp-mode . lsp-modeline-diagnostics-mode)
         (c++-mode . lsp-deferred))
  :bind (("C-c C-c" . #'lsp-execute-code-action)
         ("M-s-b" . #'lsp-find-references)
         ("M-b" . #'lsp-find-implementation)
         ("<f1>" . #'lsp-ui-doc-show)
         ("M-s-l" . #'lsp-format-region))
  :custom
  (lsp-diagnostics-modeline-scope :project)
  (lsp-file-watch-threshold 5000)
  (lsp-response-timeout 2)
  (lsp-enable-file-watchers nil))

;; todo: lsp doc show is very interesting
;; todo: review customized stuff
;; todo: enable dap-mode
;; todo: how to change lsp clang formatting style
;; todo: teach lsp to reformat the file on } in c++


(use-package lsp-ui
  :custom
  (lsp-ui-doc-mode t)
  (lsp-ui-doc-delay 50)
  (lsp-ui-doc-max-height 1000)
  (lsp-ui-doc-position 'at-point)
  (lsp-ui-sideline-show-hover nil)
  (lsp-ui-sideline-enable nil)
  (lsp-ui-peek-always-show nil)
  :after lsp-mode)

(use-package lsp-ivy
  :after (ivy lsp-mode))

(use-package company-lsp
  :disabled
  :custom (company-lsp-enable-snippet t)
  :after (company lsp-mode))

(use-package lsp-treemacs
  :config (lsp-treemacs-sync-mode 1)
  :after (lsp treemacs))

(use-package treemacs
  :bind
  (("s-&" . treemacs))
  :custom
  (treemacs-use-follow-mode nil)
  (treemacs-use-all-the-iconfs-theme t))

;; todo: can I just type and invoke Swiper?..

(use-package treemacs-projectile
  :after (treemacs projectile))

(use-package treemacs-icons-dired
  :after (treemacs dired)
  :config (treemacs-icons-dired-mode))

(use-package treemacs-magit
  :after (treemacs magit))

;; workaround
(use-package dash)

;; dap-mode

;; todo: redo the binds, probably install hydra and use the hydra dap-mode
;; install llvm-gdb dap so the experience is the same across the debuggers

(use-package dap-mode
  :bind
  (("C-c b b" . dap-breakpoint-toggle)
   ("C-c b r" . dap-debug-restart)
   ("C-c b l" . dap-debug-last)
   ("C-c b d" . dap-debug))
  :init
  (require 'dap-go)
  ;; NB: dap-go-setup appears to be broken, so you have to download the extension from GH, rename its file extension
  ;; unzip it, and copy it into the config so that the following path lines up
  (setq dap-go-debug-program `("node" ,(concat (getenv "HOME") "/.config/emacs/.extension/vscode/golang.go/extension/dist/debugAdapter.js")))
  :config
  (dap-mode)
  (dap-auto-configure-mode)
  (dap-ui-mode)
  (dap-ui-controls-mode)
  (dap-go-setup)         ;; this downloads the extension to some random /tmp/extXXXXX.zip file
  )
;; todo: bind various step-in, step-out, step-over, continue, run-to-cursor, etc


;; yasnippet

(use-package yasnippet
  :defer 3 ;; takes a while to load, so do it async
  :diminish yas-minor-mode
  :config (yas-global-mode)
  :custom (yas-prompt-functions '(yas-completing-prompt)))

(use-package yasnippet-snippets
  :defer 3 ;; takes a while to load, so do it async
  :after (yasnippet))

;; todo: C-; is a very interesting function
;; todo: company-complete binding (M-SPC)


;; keybindings
(bind-key "C-x k" #'kill-this-buffer)
(bind-key "C-x K" #'kill-buffer)

(bind-key "s-g" #'abort-recursive-edit)

(bind-key "<s-f1>" #'make-frame-command)
(bind-key "<C-f2>" #'split-window-right)
(bind-key "<C-S-f2>" #'split-window-below)
(bind-key "<C-f5>" #'delete-window)
(bind-key "<s-f5>" #'delete-frame)

(bind-key "s-w" #'delete-window)
(bind-key "s-W" #'delete-other-windows)
(bind-key "s-k" #'kill-this-buffer)
(bind-key "s-o" #'other-window)
(bind-key "s-t" #'split-window-right)
(bind-key "s-T" #'split-window-below)
(bind-key "s-s" #'save-buffer)
(bind-key "s-n" #'make-frame-command)
(bind-key "s-q" #'save-buffers-kill-terminal)
;; (bind-key "s-<" #'other-window)
(bind-key "s-v" #'yank)
(bind-key "s-c" #'kill-ring-save)
(bind-key "s-x" #'kill-region)
(bind-key "s-V" #'counsel-yank-pop)
(bind-key "s-z" #'undo-tree-undo)
(bind-key "s-Z" #'undo-tree-visualize)
(bind-key "<M-delete>" #'kill-word)
(bind-key "s--" #'tracking-next-buffer)
(bind-key "s-d" #'my-duplicate-thing)
(bind-key "s-'" #'reload-config)
(bind-key "s-e" #'ivy-switch-buffer)
(bind-key "s-E" #'projectile-recentf)
(bind-key "s-f" #'swiper)
(bind-key "s-r" #'vr/replace)
(bind-key "M-SPC" #'company-complete)
(bind-key "s-b" #'xref-find-definitions)
(bind-key "s-B" #'xref-pop-marker-stack)
(bind-key "<s-up>" #'backward-paragraph)
(bind-key "<s-down>" #'forward-paragraph)
;; (bind-key "C-c /" #'comment-or-uncomment-region)
(bind-key "C-c /" #'comment-dwim)
(bind-key "<f10>" #'ff-find-other-file) ; todo: maybe make lsp find the other file here
(bind-key "s-[" #'pop-global-mark)
(bind-key "<s-left>" #'move-beginning-of-line)
(bind-key "<s-right>" #'move-end-of-line)
(bind-key "<C-s-tab>" #'previous-buffer)
(bind-key "<C-s-iso-lefttab>" #'next-buffer)

(bind-key "<M-left>" #'left-word)
(bind-key "<M-right>" #'right-word)

(bind-key "<C-S-left>" #'windmove-left)
(bind-key "<C-S-right>" #'windmove-right)
(bind-key "<C-S-down>" #'windmove-down)
(bind-key "<C-S-up>" #'windmove-up)

;; (defun my:show-copyq ()
;;   "Run show copyq command."
;;   (interactive)
;;   (shell-command "copyq.sh"))

;; (bind-key "M-s-v" #'my:show-copyq)

(defun mark-from-point-to-end-of-line ()
  "Mark everything from point to end of line."
  (interactive)
  (set-mark (point))
  (activate-mark)
  (end-of-line))

(defun mark-from-point-to-beginning-of-line ()
  "Mark everything from point to beginning of line."
  (interactive)
  (set-mark (point))
  (activate-mark)
  (beginning-of-line))

(bind-key "<S-s-right>" #'mark-from-point-to-end-of-line)
(bind-key "<S-s-left>" #'mark-from-point-to-beginning-of-line)

(use-package sudo-edit)

(defun select-current-line ()
  "Select the current line"
  (interactive)
  (end-of-line) ; move to end of line
  (set-mark (line-beginning-position)))

(bind-key "s-;" #'select-current-line)

(defun move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

(bind-key "<M-S-up>" #'move-line-up)
(bind-key "<M-S-down>" #'move-line-down)
(bind-key "s-a" #'mark-whole-buffer)

;; (use-package eyebrowse
;;   :init
;;   (eyebrowse-mode t))

(use-package dumb-jump
  :init
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate))

(use-package quelpa)

(quelpa
 '(quelpa-use-package
   :fetcher git
   :url "https://github.com/quelpa/quelpa-use-package.git"))

(require 'quelpa-use-package)

(use-package gdb-mi :quelpa (gdb-mi :fetcher git
                                    :url "https://github.com/weirdNox/emacs-gdb.git"
                                    :files ("*.el" "*.c" "*.h" "Makefile"))
  :init
  (fmakunbound 'gdb)
  (fmakunbound 'gdb-enable-debug))
;; todo: look at emacs-gdb bindings here and get them in accordance to whatever we set for dap-mode

;; irony

(use-package irony
  :config
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'objc-mode-hook 'irony-mode)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))


;; (eval-after-load 'company
;;   '(add-to-list 'company-backends 'company-irony))

(use-package command-log-mode)

;; (defun c-indent-mode-hook ()
;;   (c-set-offset 4))
;; (add-hook 'c-mode-common-hook 'c-indent-mode-hook)

;; org mode configuration

(use-package org-bullets
  :ensure t
  :hook (org-mode . org-bullets-mode))

(use-package org-fancy-priorities
  :diminish
  :ensure t
  :hook (org-mode . org-fancy-priorities-mode)
  :config
  (setq org-fancy-priorities-list '("🅰" "🅱" "🅲" "🅳" "🅴")))

(defun isamert/toggle-side-bullet-org-buffer ()
  "Toggle `bullet.org` in a side buffer for quick note taking.  The buffer is opened in side window so it can't be accidentaly removed."
  (interactive)
  (isamert/toggle-side-buffer-with-file "~/Documents/notes/bullet.org"))

(defun isamert/buffer-visible-p (buffer)
  "Check if given BUFFER is visible or not.  BUFFER is a string representing the buffer name."
  (or (eq buffer (window-buffer (selected-window))) (get-buffer-window buffer)))

(defun isamert/display-buffer-in-side-window (buffer)
  "Just like `display-buffer-in-side-window' but only takes a BUFFER and rest of the parameters are for my taste."
  (select-window
   (display-buffer-in-side-window
    buffer
    (list (cons 'side 'right)
          (cons 'slot 0)
          (cons 'window-width 84)
          (cons 'window-parameters (list (cons 'no-delete-other-windows t)
                                         (cons 'no-other-window nil)))))))

(defun isamert/remove-window-with-buffer (the-buffer-name)
  "Remove window containing given THE-BUFFER-NAME."
  (mapc (lambda (window)
          (when (string-equal (buffer-name (window-buffer window)) the-buffer-name)
            (delete-window window)))
        (window-list (selected-frame))))

(defun isamert/toggle-side-buffer-with-file (file-path)
  "Toggle FILE-PATH in a side buffer. The buffer is opened in side window so it can't be accidentaly removed."
  (interactive)
  (let ((fname (file-name-nondirectory file-path)))
    (if (isamert/buffer-visible-p fname)
        (isamert/remove-window-with-buffer fname)
      (isamert/display-buffer-in-side-window
       (save-window-excursion
         (find-file file-path)
         (current-buffer))))))

(bind-key "s-m" #'isamert/toggle-side-bullet-org-buffer)

(setq calendar-week-start-day 1)

(with-eval-after-load 'org
  (bind-key "<C-s-up>" #'org-do-promote org-mode-map)
  (bind-key "<C-s-down>" #'org-do-demote org-mode-map)
  (bind-key "<C-S-s-up>" #'org-promote-subtree org-mode-map)
  (bind-key "<C-S-s-down>" #'org-demote-subtree org-mode-map))

(bind-key "s-M" #'org-agenda-list)

(setq org-agenda-files (list "~/Documents/notes/bullet.org"))

;; (org-agenda)

;; appt
(require 'appt)
(appt-activate t)

(setq appt-message-warning-time 1) ; Show notification 5 minutes before event
(setq appt-display-interval appt-message-warning-time) ; Disable multiple reminders
(setq appt-display-mode-line nil)

                                        ; Use appointment data from org-mode
(defun my-org-agenda-to-appt ()
  (interactive)
  (setq appt-time-msg-list nil)
  (org-agenda-to-appt))

                                        ; Update alarms when...
                                        ; (1) ... Starting Emacs
                                        ; doesn't work if agenda wasn't opened before
;; (my-org-agenda-to-appt)

                                        ; (2) ... Everyday at 12:05am (useful in case you keep Emacs always on)
;; (run-at-time "12:05am" (* 24 3600) 'my-org-agenda-to-appt)

                                        ; (3) ... When TODO.txt is saved

(add-hook 'after-save-hook
          '(lambda ()
             (if (string= (buffer-file-name) (concat (getenv "HOME") "/Documents/notes/bullet.org"))
                 (my-org-agenda-to-appt))))

                                        ; (4) ... Quitting org-agenda.
(advice-add 'org-agenda-quit :after #'my-org-agenda-to-appt)

                                        ; (5) ... Each time agenda is opened
(add-hook 'org-agenda-finalize-hook 'my-org-agenda-to-appt)

                                        ; Display appointments as a window manager notification
(setq appt-disp-window-function 'my-appt-display)
(setq appt-delete-window-function (lambda () t))

(setq my-appt-notification-app (concat (getenv "HOME") "/bin/appt-notification.sh"))

(defun my-appt-display (min-to-app new-time msg)
  (if (atom min-to-app)
      (start-process "my-appt-notification-app" nil my-appt-notification-app min-to-app msg)
    (dolist (i (number-sequence 0 (1- (length min-to-app))))
      (start-process "my-appt-notification-app" nil my-appt-notification-app (nth i min-to-app) (nth i msg)))))


;; purpose
;; (use-package window-purpose)
;; (purpose-mode)
;; (require 'window-purpose-x)
;; (add-to-list 'purpose-user-mode-purposes '(c++-mode . cpp))
;; (purpose-compile-user-configuration)

;; the reason purpose works badly is - probably - that it overrides C-x b, which I don't use.

;; perspective

(use-package perspective
  :bind
  (("M-s-e" . persp-ivy-switch-buffer)   ; or use a nicer switcher, see below
   ("<C-M-tab>" . persp-next)
   ("<C-M-iso-lefttab>" . persp-prev))
  :hook
  (kill-emacs . persp-state-save)
  :custom
  (persp-state-default-file (concat (getenv "HOME") "/.config/emacs/perspectives"))
  (persp-sort 'created))

(progn
  (persp-mode)
  (persp-state-load persp-state-default-file)
  (persp-switch "main"))

;; from perspective's author:

(setq display-buffer-alist
      '((".*"
         (display-buffer-reuse-window display-buffer-same-window)
         (reusable-frames . t))))

(setq even-window-sizes nil)  ; display-buffer hint: avoid resizing

;; go-mode

(use-package go-mode
  :custom
  (lsp-enable-links nil)
  :config
  (add-hook 'before-save-hook #'gofmt-before-save))

(use-package go-snippets)

(use-package go-projectile)

(use-package gotest
  :bind (:map go-mode-map
              ("C-c a t" . #'go-test-current-test)))

;; dashboard

(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  :custom
  (dashboard-projects-backend 'projectile)
  (dashboard-items '((recents  . 10)
                     (projects . 10)
                     (agenda . 10)
                     (bookmarks . 5)
                     (registers . 5))))


;; cursor color

(set-cursor-color "#DC322F")

(use-package all-the-icons-dired
  :after all-the-icons
  :hook (dired-mode . all-the-icons-dired-mode))

;; git-gutter
;; todo: replace with diff-hl
;; (use-package git-gutter
;;   :config
;;   (global-git-gutter-mode +1))

;; diff-hl
(use-package diff-hl
  :config
  (global-diff-hl-mode)
  :hook
  (magit-pre-refresh . diff-hl-magit-pre-refresh)
  (magit-post-refresh . diff-hl-magit-post-refresh)
  :after (magit))

;; custom-file
(setq custom-file "~/.config/emacs/emacs-custom.el")
(load custom-file)

(provide 'config)
;;; config.el ends here
