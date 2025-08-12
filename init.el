;;; -*- lexical-binding: t; -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;
;;     Vanilla Emacs config
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;        General settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Disable TLS1.3 (only for Emacs <= 26.2)
(if (version<= emacs-version "26.2")
    (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3"))

;; Faster start by reducing garbage collection rate
(setq gc-cons-threshold (* 50 1000 1000))

;; Skip checking signatures of packages
(setq package-check-signature nil)

;; Do not use 'init.el' for 'custom-*' code, use 'custom-file.el' instead
(setq custom-file (concat user-emacs-directory "custom-file.el"))
(load-file custom-file)

;; Add custom lisp directory to load path
(add-to-list 'load-path (concat user-emacs-directory "lisp/"))

;; Require and initialise package
(require 'package)
;; Add 'melpa' to 'package-archives'
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; use-package to help with package management
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(require 'use-package-ensure)
(setq use-package-always-ensure t)

;; Stop littering persistent/config data files
(use-package no-littering
  :config
  (no-littering-theme-backups))

;; Do not show startup screen, inhibit scratch buffer message
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)

;; Use 'command' as 'meta' in macOS
(setq mac-command-modifier 'meta)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;        User Interface
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Disable tool bar, menu bar, and scroll bar
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; Use fullscreen always
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Smooth scrolling and mouse support
(setq redisplay-dont-pause t
      scroll-margin 1
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1
      mouse-wheel-scroll-amount '(1 ((shift) . 1)) ;; one line at a time
      mouse-wheel-progressive-speed nil            ;; don't accelerate scrolling
      mouse-wheel-follow-mouse 't)                 ;; scroll window under mouse

;; Line highlight
(global-hl-line-mode)

;; Display column number on modeline
(column-number-mode)

;; Enable line numbers on all buffers
(global-display-line-numbers-mode t)

;; vim-like undo
(use-package undo-tree
  :config
  (global-undo-tree-mode 1))

;; Inject some malevolence
(use-package evil
  :init
  (setq evil-want-integration t
	evil-want-keybinding nil
	evil-want-C-i-jump nil
	evil-respect-visual-line-mode t
	evil-undo-system 'undo-tree
	evil-want-minibuffer t)
  :config
  (evil-mode 1)
  (setq-default
   evil-emacs-state-tag          " E "
   evil-normal-state-tag         " N "
   evil-insert-state-tag         " I "
   evil-visual-char-tag          " V "
   evil-visual-line-tag          " VL "
   evil-visual-screen-line-tag   " VSL "
   evil-visual-block-tag         " VB "
   evil-motion-state-tag         " M "
   evil-operator-state-tag       " O "
   evil-replace-state-tag        " R "))

;; evil-collection for better key bindings
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; Customise ediff buffer setup
(setq ediff-window-setup-function 'ediff-setup-windows-plain
      ediff-split-window-function 'split-window-horizontally)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;        Colours and Fonts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Use spacemacs-theme
(use-package spacemacs-theme
  :init
  (setq spacemacs-theme-comment-italic t)
  :config
  (load-theme 'spacemacs-dark))

;; UTF-8 everywhere
(setq prefer-coding-system 'utf-8)

;;Font of choice
(add-to-list 'default-frame-alist
	     '(font . "FiraCode Nerd Font-11"))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;        Files and Backups
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Store backups in separate folder
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
      backup-by-copying t    ;; Don't delink hardlinks
      version-control t      ;; Use version numbers on backups
      delete-old-versions t  ;; Automatically delete excess backups
      kept-new-versions 20   ;; Number of new version to keep
      kept-old-versions 5    ;; Number of old version to keep
      )



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;        Text, Tab, and Indentation
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Never use tabs
(setq indent-tabs-mode nil)

;; Set tab width to 4 spaces
(setq tab-width 4)

;; Turn off line wrapping
(set-default 'truncate-lines t)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;        Packages
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Better terminal emulation
(use-package vterm
  :after evil-collection
  :config
  (setq vterm-max-scrollback 10000)
  (evil-set-initial-state 'vterm-mode 'insert))

;; Company for autocompletion
(use-package company
  :config
  (global-company-mode t)
  (setq company-idle-delay 0.0))

;; IDE functionality using eglot
(use-package eglot
  :hook
  ((verilog-mode-hook . eglot-ensure)
   (c-mode . eglot-ensure)
   (c++-mode . eglot-ensure)      
   (c-ts-mode . eglot-ensure)     
   (c++-ts-mode . eglot-ensure)
   (python-mode . eglot-ensure)
   (python-ts-mode . eglot-ensure))
  :config
  (setq eglot-autoshutdown t))

;; Python LSP
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs '((python-mode python-ts-mode) . ("pylsp"))))

;; Verilog LSP
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(verilog-mode . ("verible-verilog-ls"))))

;; Verilog support
(use-package verilog-mode
  :config
  (setq verilog-auto-newline nil))

;; vivado-mode for editing XDC and Tcl files
(use-package vivado-mode
  :load-path load-path
  :config
  (setq auto-mode-alist (cons  '("\\.xdc\\'" . vivado-mode) auto-mode-alist))
  (add-hook 'vivado-mode-hook #'(lambda () (font-lock-mode 1)))
  (autoload 'vivado-mode "vivado-mode"))

;; gptel for LLM model interfacing
(use-package gptel
  :config
  (setq gptel-model 'claude-3.7-sonnet
	gptel-backend (gptel-make-gh-copilot "Copilot")))

;; git interfacing with magit
(use-package magit
  :commands (magit-status magit-get-current-branch)
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)
  :init
  (autoload 'magit-project-status "magit-extras"))

;; Commentary for supercharging comments
(use-package evil-commentary
  :config
  (evil-commentary-mode))

;; Highlighting updgrade with evil-anzu
(use-package evil-anzu
  :config
  (global-anzu-mode +1))

;; Delimiter colouring
(use-package rainbow-delimiters
  :hook ((org-mode prog-mode) . rainbow-delimiters-mode))

;; Indentation help
(use-package highlight-indent-guides
  :after (spacemacs-theme)
  :config
  (setq highlight-indent-guides-method 'character
	highlight-indent-guides-character ?|
	highlight-indent-guides-auto-enabled nil)
  (set-face-foreground 'highlight-indent-guides-character-face "DimGray")
  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode))

;; Quick help for keybindings
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.2))

;; Avy to jump around
(use-package avy
  :init
  (evil-define-key 'normal 'global (kbd "f") 'avy-goto-char-2)    ;; Set f as trigger key 
  (setq avy-background t
        avy-single-candidate-jump nil))

;; Use doom-modeline
(use-package doom-modeline
  :after (spacemacs-theme)
  :config
  (doom-modeline-mode 1)
  (setq doom-modeline-major-mode-icon t
        doom-modeline-height 30))

;; Read, annotate and work with pdfs
(use-package pdf-tools
  :mode ("\\.pdf\\'" . pdf-view-mode)
  :config
  (setq-default pdf-view-display-size 'fit-page)
  (setq pdf-view-use-scaling t
  	pdf-view-use-imagemagick nil)
  ;; Fix flickering pdfs when evil-mode is enabled
  (add-hook 'pdf-view-mode-hook #'(lambda () (setq-local evil-normal-state-cursor (list nil))))
  (add-hook 'pdf-view-mode-hook 'pdf-view-midnight-minor-mode)
  (add-hook 'pdf-view-midnight-minor-mode-hook (lambda () (setq pdf-view-midnight-colors '("#ebdbb2" . "#282828"))))
  (add-hook 'pdf-view-mode-hook 'pdf-history-minor-mode)
  (add-hook 'pdf-view-mode-hook 'pdf-isearch-minor-mode))

;; Add Nerd icons
(use-package nerd-icons
  :config
  (setq nerd-icons-color-icons nil))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;        Misc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;        EOF - Vanilla Emacs Config
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
