
;; Do not show startup screen
(setq inhibit-startup-message t)

;; Disable tool bar, menu bar
(tool-bar-mode -1)
(menu-bar-mode -1)

;; Use 'command' as 'meta' in macOS
(setq mac-command-modifier 'meta)

;; Do not use 'init.el' for 'custom-*' code, use 'custom-file.el' instead
(setq custom-file "~/.emacs.d/custom-file.el")
(load-file custom-file)



;; Require and initialise package
(require 'package)
(package-initialize)

;; Add 'melpa' to 'package-archives'
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)

;; Customise theme
(setq spacemacs-theme-comment-italic t)
;; Load theme
(load-theme 'spacemacs-dark)

;; Download and enable Evil if not present already
(unless (package-installed-p 'evil)
  (package-install 'evil))
(require 'evil)
(evil-mode 1)

;; Enable 'company' in all sessions
(global-company-mode t)

;; Disable 'company' delay
(setq company-idle-delay 0.0)

(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
      backup-by-copying t    ; Don't delink hardlinks
      version-control t      ; Use version numbers on backups
      delete-old-versions t  ; Automatically delete excess backups
      kept-new-versions 20   ; Number of new versios to keep
      kept-old-versions 5    ; Number of old version to keep
      )
