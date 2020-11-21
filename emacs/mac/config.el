(setq lexical-binding t)
(setq gc-cons-threshold 100000000)
(setq use-package-always-ensure t)

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

(use-package exec-path-from-shell
  :init (exec-path-from-shell-initialize))

;; (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
;; (use-package gnu-elpa-keyring-update)

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
  :init (progn
          (setq doom-modeline-icon (display-graphic-p))
          (setq doom-modeline-vcs-max-length 30))
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

;; This section was added on macOS
(setq projectile-keymap-prefix (kbd "C-c p"))

(use-package projectile
  :diminish
  :bind (("C-c k" . #'projectile-kill-buffers)
         ("C-c M" . #'projectile-compile-project))
  :custom
  (projectile-completion-system 'ivy)
  (projectile-enable-caching t)
  :config (projectile-mode))

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

;; (setq ivy-re-builders-alist
;;       '((swiper . ivy--regex-plus)
;;         (t      . ivy--regex-fuzzy)))

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

(setq projectile-project-search-path '("~/git_tree/"))

;; Helm seems nice but it uses its own buffer which may be an overkill.
;; But, it allows to open multiple files at once, which is oh my god!
;; (use-package helm
;;   :ensure t
;;   :demand
;;   :bind (("M-x" . helm-M-x)
;;          ("C-x C-f" . helm-find-files)
;;          ("C-x b" . helm-buffers-list)
;;          ("C-x c o" . helm-occur)) ;SC
;;          ("M-y" . helm-show-kill-ring) ;SC
;;          ("C-x r b" . helm-filtered-bookmarks) ;SC
;;   :preface (require 'helm-config)
;;   :config (helm-mode 1))


;; linux migration part
(bind-key "s-w" #'kill-this-buffer)

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

(use-package magit
  :diminish magit-auto-revert-mode
  :diminish auto-revert-mode
  :bind (("C-c g" . #'magit-status))
  :custom
  (magit-repository-directories '(("~/src" . 1)))
  :config
  (add-to-list 'magit-no-confirm 'stage-all-changes))

(use-package libgit)

(use-package magit-libgit
  :after (magit libgit))

(use-package forge
  :after magit)

(setq auth-sources '("~/.authinfo"))

(add-to-list 'forge-alist '("gitlab.booking.com" "gitlab.booking.com/api/v4" "gitlab.booking.com" forge-gitlab-repository))


;; slack
(defvar my:slack-started nil)

(use-package alert
  :after slack
  :init
  ;; (alert-define-style
  ;;  'default-style
  ;;  :title "Default alert style"
  ;;  :notifier
  ;;  (lambda (info)
  ;;    ;; The message text is :message
  ;;    (plist-get info :message)
  ;;    ;; The :title of the alert
  ;;    (plist-get info :title)
  ;;    ;; The :category of the alert
  ;;    (plist-get info :category)
  ;;    ;; The major-mode this alert relates to
  ;;    (plist-get info :mode)
  ;;    ;; The buffer the alert relates to
  ;;    (plist-get info :buffer)
  ;;    ;; Severity of the alert.  It is one of:
  ;;    ;;   `urgent'
  ;;    ;;   `high'
  ;;    ;;   `moderate'
  ;;    ;;   `normal'
  ;;    ;;   `low'
  ;;    ;;   `trivial'
  ;;    (plist-get info :severity)
  ;;    ;; Whether this alert should persist, or fade away
  ;;    (plist-get info :persistent)
  ;;    ;; Data which was passed to `alert'.  Can be
  ;;    ;; anything.
  ;;    (plist-get info :data))

  ;;  ;; Removers are optional.  Their job is to remove
  ;;  ;; the visual or auditory effect of the alert.
  ;;  ;; :remover
  ;;  ;; (lambda (info)
  ;;  ;;   ;; It is the same property list that was passed to
  ;;  ;;   ;; the notifier function.
  ;;  ;;   )
  ;;  )
  (setq alert-default-style 'notifier))

(use-package slack
  ;;  :commands (slack-start)
  :init
  (setq slack-prefer-current-team t)
  :bind (("C-z c s" . #'slack-channel-select)
         ("C-z c j" . #'slack-channel-join)
         ("C-z c l" . #'slack-channel-leave)
         ("C-z c u" . #'slack-channel-list-update)
         ("C-z m e" . #'slack-message-edit)
         ("C-z m E" . #'slack-message-cancel-edit)
         ("C-z m d" . #'slack-message-delete)
         ("C-z m m" . #'slack-message-embed-mention)
         ("C-z m c" . #'slack-message-embed-channel)
         ("C-z i s" . #'slack-im-select)
         ("C-z i o" . #'slack-im-open)
         ("C-z i c" . #'slack-im-close)
         ("C-z g s" . #'slack-group-select)
         ("C-z u" . #'slack-select-unread-rooms)
         ("C-z t" . #'slack-thread-show-or-create))
  :config
  (unless my:slack-started
    (slack-register-team
     :name "booking-slack"
     :default t
     :token (auth-source-pick-first-password
             :host "bk.slack.com"
             :user "pavel.gurkov@booking.com"
             )
     :full-and-display-names t)
    (slack-start)
    (setq my:slack-started t)))

;; slack alerting
(defun slack-user-status (_id _team) "")

(with-eval-after-load 'tracking
  (define-key tracking-mode-map [f11]
    #'tracking-next-buffer))
;; Ensure the buffer exists when a message arrives on a
;; channel that wasn't open.
(setq slack-buffer-create-on-notify t)

;;; Channels
(setq slack-message-notification-title-format-function
      (lambda (_team room threadp)
        (concat (if threadp "Thread in #%s") room)))

(defun endless/-cleanup-room-name (room-name)
  "Make group-chat names a bit more human-readable."
  (replace-regexp-in-string
   "--" " "
   (replace-regexp-in-string "#mpdm-" "" room-name)))

;;; Private messages and group chats
(setq
 slack-message-im-notification-title-format-function
 (lambda (_team room threadp)
   (concat (if threadp "Thread in %s")
           (endless/-cleanup-room-name room))))

(add-to-list 'alert-user-configuration
             '(((:category . "slack")) ignore nil))

(add-to-list
 'alert-user-configuration
 '(((:title . "\\(streaming-infra\\|streaming\\)")
    (:category . "slack"))
   notifier nil))

(add-to-list
 'alert-user-configuration
 '(((:message . "@pgurkov")
    (:category . "slack"))
   notifier nil))

;; which-key
(use-package which-key
  :custom
  (which-key-setup-side-window-bottom)
  (which-key-enable-extended-define-key t)
  :config
  (which-key-mode)
  (which-key-setup-minibuffer))

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


  :bind (("s-," . my-ace-window))
  :custom
  (aw-keys '(?a ?o ?e ?u ?i ?d ?h ?t ?n ?s) "Designate windows by home row keys, not numbers.")
  (aw-background nil))


(use-package visual-regexp
  :bind (("M-%" . #'vr/replace)))

(use-package pcre2el)

(use-package visual-regexp-steroids)

(defun kill-this-buffer ()
  "Kill the current buffer."
  (interactive)
  (kill-buffer nil)
  )

(use-package duplicate-thing
  :init
  (defun my-duplicate-thing ()
    "Duplicate thing at point without changing the mark."
    (interactive)
    (save-mark-and-excursion (duplicate-thing 1)))
  :bind (("C-c u" . my-duplicate-thing)
         ("C-c C-u" . my-duplicate-thing)))

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

;; (customize-set-variable
;;  'display-buffer-alist
;;  '("\\*Slack - Booking" (display-buffer-same-window)))

(customize-set-variable
 'display-buffer-alist
 nil)

;; todo: make slack alerts closable
;; make buffers appear where I open them
