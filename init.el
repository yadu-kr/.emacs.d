;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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

;; Disable TLS1.3 (use only for Emacs <= 26.2)
;;(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

;; Faster start by reducing garbage collection rate
(setq gc-cons-threshold (* 50 1000 1000))

;; Skip checking signatures of packages
(setq package-check-signature nil)

;; Do not use 'init.el' for 'custom-*' code, use 'custom-file.el' instead
(setq custom-file "~/.emacs.d/custom-file.el")
(load-file custom-file)

;; Require and initialise package
(require 'package)
;; Add 'melpa' to 'package-archives'
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; use-package to help with package management
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)

;; Stop littering persistent/config data files
(use-package no-littering
  :ensure t
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
(set-frame-parameter nil 'fullscreen 'fullboth)

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

;; Inject some malevolence
(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode 1))

;; Inject some malevolence
(use-package evil
  :ensure t
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

;; Enable line numbers on all buffers
(global-display-line-numbers-mode t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;        Colours and Fonts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Use spacemacs-theme
(use-package spacemacs-theme
  :ensure t
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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;        Packages
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Company for autocompletion
(use-package company
  :ensure t
  :config
  (global-company-mode t)
  (setq company-idle-delay 0.0))

;; Avy to jump around
(use-package avy
  :ensure t
  :init
  (evil-define-key 'normal 'global (kbd "f") 'avy-goto-char-2)    ;; Set f as trigger key 
  (setq avy-background t
        avy-single-candidate-jump nil))

;; Use doom-modeline
(use-package doom-modeline
  :ensure t
  :after (spacemacs-theme)
  :config
  (doom-modeline-mode 1)
  (setq doom-modeline-major-mode-icon t
        doom-modeline-height 30))

;; Commentary for supercharging comments
(use-package evil-commentary
  :ensure t
  :config
  (evil-commentary-mode))

;; Read, annotate and work with pdfs
 (use-package pdf-tools
   :ensure t)

;; Add Nerd icons
(use-package nerd-icons
  :ensure t
  :config
  (setq nerd-icons-color-icons nil))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;        Misc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;        EOF - Vanilla Emacs Config
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
