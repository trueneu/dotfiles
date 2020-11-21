(setq lexical-binding t)
(setq gc-cons-threshold 100000000)
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

(unbind-key "C-x C-f") ;; find-file-read-only
(unbind-key "C-x C-d") ;; list-directory
(unbind-key "C-z") ;; suspend-frame
(unbind-key "M-o") ;; facemenu-mode
(unbind-key "<mouse-2>") ;; pasting with mouse-wheel click
(unbind-key "<C-wheel-down>") ;; text scale adjust
(unbind-key "<C-wheel-up>") ;; ditto

(setq custom-file "~/.config/emacs/emacs-custom.el")
(load custom-file)

(add-hook 'before-save-hook #'delete-trailing-whitespace)
(setq require-final-newline t)

(use-package keychain-environment
  :config
  (keychain-refresh-environment))

(exec-path-from-shell-copy-env "SSH_AGENT_PID")
(exec-path-from-shell-copy-env "SSH_AUTH_SOCK")

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

(use-package all-the-icons)
(use-package all-the-icons-dired
  :after all-the-icons
  :hook (dired-mode . all-the-icons-dired-mode))

;; maximize the window
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; remove window chrome
(when (window-system)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (tooltip-mode -1))

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
         (go-mode . tree-sitter-hl-mode)))
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
  (("s-{" . #'centaur-tabs-backward)
   ("s-}" . #'centaur-tabs-forward)))

(use-package multiple-cursors
  :bind (("C-c m m" . #'mc/edit-lines )
         ("C-c m d" . #'mc/mark-all-dwim )))

(set-fill-column 135)

(use-package expand-region
  :bind (("<M-up>" . er/expand-region)))

;; todo: find what's binded to C-/ and rebind it somewhere else,
;; bind this to C-/
(bind-key "C-c /" #'comment-dwim)

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

;; todo: add :ensure t to each use-package?

(setq read-process-output-max (* 1024 1024)) ; 1mb

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
  ; (set-face-attribute 'aw-leading-char-face nil :height 1.0 :background "black")

  (defun my-ace-window (args)
    "As ace-window, but hiding the cursor while the action is active."
    (interactive "P")
    (cl-letf
        ((cursor-type nil)
         (cursor-in-non-selected-window nil))
      (ace-window nil)))


  :bind (("s-," . my-ace-window))
  :custom
  (aw-keys '(?a ?o ?e ?u ?i ?d ?h ?t ?n ?s) "Designate windows by home row keys, not numbers.")
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
  (setq projectile-keymap-prefix (kbd "C-c p"))
  :diminish
  :bind (("C-c k" . #'projectile-kill-buffers)
         ("C-c M" . #'projectile-compile-project))
  :custom
  (projectile-completion-system 'ivy)
  (projectile-enable-caching t)
  :config
  (projectile-mode)
  (setq projectile-project-search-path '("~/git_tree")))

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
  (flycheck-display-errors-delay 0.1)
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
  :bind (("C-c h" . #'deadgrep)))

;; todo: strange keybind
(use-package visual-regexp
  :bind (("M-%" . #'vr/replace)))

(use-package pcre2el)

(use-package visual-regexp-steroids)

;; todo: bind doesn't work
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

  ;; Use the numbers 0-9 to select company completion candidates
  (let ((map company-active-map))
    (mapc (lambda (x) (define-key map (format "%d" x)
			`(lambda () (interactive) (company-complete-number ,x))))
	  (number-sequence 0 9))))

;; todo: lsp section omitted
;; todo: no ssh-agent access

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
(bind-key "s-t" #'split-window-right)
(bind-key "s-T" #'split-window-below)
(bind-key "s-s" #'save-buffer)
(bind-key "s-n" #'make-frame-command)
(bind-key "s-q" #'save-buffers-kill-terminal)
(bind-key "s-<" #'other-window)
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
(bind-key "s-f" #'swiper)
(bind-key "s-r" #'vr/replace)

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

(provide 'config)
;;; config.el ends here
