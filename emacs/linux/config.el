(setq lexical-binding t)
(setq gc-cons-threshold 100000000)
(setq use-package-always-ensure t)

(use-package exec-path-from-shell
  :init (exec-path-from-shell-initialize))

(use-package gnu-elpa-keyring-update)

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

;; (unbind-key "C-x C-f") ;; find-file-read-only
;; (unbind-key "C-x C-d") ;; list-directory
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
