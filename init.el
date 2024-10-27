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



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;        User Interface
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Disable tool bar, menu bar
(tool-bar-mode -1)
(menu-bar-mode -1)

;; Download and enable Evil if not present already
(unless (package-installed-p 'evil)
  (package-install 'evil))
(require 'evil)
(evil-mode 1)

;; Enable line numbers on all buffers
(global-display-line-numbers-mode t)

;; Enable 'company' in all sessions
(global-company-mode t)
;; Disable 'company' delay
(setq company-idle-delay 0.0)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;        Colours and Fonts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Customise theme
(setq spacemacs-theme-comment-italic t)
;; Load theme
(load-theme 'spacemacs-dark)

;; UTF-8 everywhere
(setq prefer-coding-system 'utf-8)

;;Font of choice
(set-frame-font "Fira Code" nil t)

;; Add Nerd icons
(use-package nerd-icons :defer t
  :custom
  (nerd-icons-color-icons nil))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;        Files and Backups
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Store backups in separate folder
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
      backup-by-copying t    ; Don't delink hardlinks
      version-control t      ; Use version numbers on backups
      delete-old-versions t  ; Automatically delete excess backups
      kept-new-versions 20   ; Number of new versios to keep
      kept-old-versions 5    ; Number of old version to keep
      )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;        Text, Tab, and Indentation
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Never use tabs
(setq indent-tabs-mode nil)
;; Set tab width to 4 spaces
(setq tab-width 4)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;        Plug-ins
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;        Misc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
