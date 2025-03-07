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
(unless (package-installed-p 'evil)
  (package-install 'evil))
(require 'evil)
(setq evil-want-integration t
   evil-want-keybinding nil
   evil-want-C-i-jump nil
   evil-respect-visual-line-mode t
   evil-want-minibuffer t)
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
   evil-replace-state-tag        " R ")

;; Enable line numbers on all buffers
(global-display-line-numbers-mode t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;        Colours and Fonts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Use spacemacs-theme
(unless (package-installed-p 'spacemacs-theme)
  (package-install 'spacemacs-theme))
(require 'spacemacs-theme)
(setq spacemacs-theme-comment-italic t)
(load-theme 'spacemacs-dark)

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
(unless (package-installed-p 'company)
  (package-install 'company))
(global-company-mode t)
(setq company-idle-delay 0.0)

;; Avy to jump around
(unless (package-installed-p 'avy)
  (package-install 'avy))
(evil-define-key 'normal 'global (kbd "f") 'avy-goto-char-2)    ;; Set f as trigger key 
(setq avy-background t
      avy-single-candidate-jump nil)

;; Use doom-modeline
(unless (package-installed-p 'doom-modeline)
  (package-install 'doom-modeline))
(require 'doom-modeline)
(doom-modeline-mode 1)
(setq doom-modeline-major-mode-icon t
      doom-modeline-height 30)

;; Commentary for supercharging comments
(unless (package-installed-p 'evil-commentary)
  (package-install 'evil-commentary))
(require 'evil-commentary)
(evil-commentary-mode)

;; Read, annotate and work with pdfs
(unless (package-installed-p 'pdf-tools)
  (package-install 'pdf-tools))

;; Add Nerd icons
(unless (package-installed-p 'nerd-icons)
  (package-install 'nerd-icons)) 
(setq nerd-icons-color-icons nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;        Misc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;        EOF - Vanilla Emacs Config
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
