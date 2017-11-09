;; time the loading of the .emacs
;; keep this on top of your .emacs
(defvar *emacs-load-start* (current-time))
(defun anarcat/time-to-ms (time)
  (+ (* (+ (* (car time) (expt 2 16)) (car (cdr time))) 1000000) (car (cdr (cdr time)))))
(defun anarcat/display-timing ()
  (message ".emacs loaded in %fms" (/ (- (anarcat/time-to-ms (current-time)) (anarcat/time-to-ms *emacs-load-start*)) 1000000.0)))
(add-hook 'after-init-hook 'anarcat/display-timing t)


(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(package-initialize)


(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;;(use-package evil-leader
  ;:ensure t)
;;(global-evil-leader-mode)
;;(evil-leader/set-leader "<SPC>")


(use-package evil
  :ensure t
  :config
(evil-mode 1)
;; more configuration

  (use-package evil-leader
    :ensure t
    :config
    (global-evil-leader-mode)
    (evil-leader/set-leader "<SPC>"))

  (use-package evil-surround
    :ensure t
    :config
    (global-evil-surround-mode))

  (use-package evil-indent-textobject
    :ensure t))


(use-package neotree
  :ensure t
  :config

  (setq projectile-switch-project-action 'neotree-projectile-action)
  (add-hook 'neotree-mode-hook
    (lambda ()
      (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
      (define-key evil-normal-state-local-map (kbd "I") 'neotree-hidden-file-toggle)
      (define-key evil-normal-state-local-map (kbd "z") 'neotree-stretch-toggle)
      (define-key evil-normal-state-local-map (kbd "R") 'neotree-refresh)
      (define-key evil-normal-state-local-map (kbd "m") 'neotree-rename-node)
      (define-key evil-normal-state-local-map (kbd "c") 'neotree-create-node)
      (define-key evil-normal-state-local-map (kbd "d") 'neotree-delete-node)

      (define-key evil-normal-state-local-map (kbd "s") 'neotree-enter-vertical-split)
      (define-key evil-normal-state-local-map (kbd "S") 'neotree-enter-horizontal-split)

      (define-key evil-normal-state-local-map (kbd "o") 'neotree-enter))))

(use-package helm
  :ensure t
  :config 
  (helm-mode t)
  :bind (("M-x" . helm-M-x)
	 ("M-<f5>" . helm-find-files)
	 ([f10] . helm-buffers-list)
	 ([S-f10] . helm-recentf)))

(setq helm-mode-fuzzy-match t)

(use-package projectile
  :ensure t)
(projectile-mode)
(use-package helm-projectile
  :ensure t)
(helm-projectile-on)

;; jumping to definition
(use-package dumb-jump
  :ensure t)

(use-package magit
  :ensure t
  :config
  (use-package evil-magit
    :ensure t
    :config
    (setq evil-magit-state 'normal))
  )
(use-package git-gutter
  :ensure t)

(global-git-gutter-mode t)
(setq evil-magit-state 'normal)

(use-package web-mode
  :ensure t)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js[x]\\'" . web-mode))

(use-package js2-mode
  :ensure t)
(add-to-list 'auto-mode-alist '("\\.js?\\'" . js2-jsx-mode))

(use-package php-mode
  :ensure t)

(use-package auto-complete
  :ensure t
  :config
  (ac-config-default))
  
(setq ac-use-menu-map t)
;; Default settings
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)

(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

(use-package ace-jump-mode
  :ensure t)

(use-package yasnippet
  :ensure t)
(yas-global-mode 1)

(use-package powerline
  :ensure t)
(powerline-vim-theme)

(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t)

;; keybinding
;;(define-key evil/leader (kbd "b") 'helm-buffers-list)
;;(define-key evil-normal-state-map [remap xref-find-definitions] 'dumb-jump-go) 
;; (define-key helm-map (kbd "C-[") 'helm-keyboard-quit)
(define-key evil-normal-state-map (kbd "gd") 'dumb-jump-go)
(define-key evil-normal-state-map (kbd "SPC ;") 'helm-M-x)
(define-key evil-normal-state-map (kbd "gcc") 'comment-line)
(define-key evil-insert-state-map (kbd "TAB") 'self-insert-command); # only in text-mode

(evil-leader/set-key 
  "bl" 'helm-buffers-list
  "bd" 'evil-delete-buffer
  "bev" 'eval-buffer
  "p" 'helm-projectile
  "e"  'neotree-toggle
  "g" 'magit-status
  "s" 'evil-ace-jump-char-mode
  "m" 'list-bookmarks
  "f" 'helm-find-files
  ;;"gd" 'dumb-jump-go
  )

; (define-key helm-map "\C-[" 'helm-keyboard-quit)
; (define-key evil-normal-state-map "\C-["  'keyboard-quit)
; (define-key evil-visual-state-map "\C-[" 'keyboard-quit)
; (define-key minibuffer-local-map "\C-[" 'minibuffer-keyboard-quit)
; (define-key minibuffer-local-ns-map "\C-[" 'minibuffer-keyboard-quit)
; (define-key minibuffer-local-completion-map "\C-[" 'minibuffer-keyboard-quit)
; (define-key minibuffer-local-must-match-map "\C-[" 'minibuffer-keyboard-quit)
; (define-key minibuffer-local-isearch-map "\C-[" 'minibuffer-keyboard-quit)
; (global-set-key "\C-[" 'evil-exit-emacs-state)

;; (evil-leader/set-key "e" 'evil-ace-jump-word-mode) ; ,e for Ace Jump (word)
;; (evil-leader/set-key "l" 'evil-ace-jump-line-mode) ; ,l for Ace Jump (line)
;; (evil-leader/set-key "x" 'evil-ace-jump-char-mode) ; ,x for Ace Jump (char)


;; save backups in different folder
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

(electric-pair-mode)

;; smoother scrollign
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time

(setq mouse-wheel-progressive-speed t) ;; don't accelerate scrolling

(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

(setq scroll-step 1) ;; keyboard scroll one line at a time

					; Use Source Code Pro 14pt in GUI
;;(when (display-graphic-p) (set-face-attribute 'default nil :font "Source Code Pro for Powerline-14"))
(use-package ample-theme
  :init (progn (load-theme 'ample t t)
               (load-theme 'ample-flat t t)
               (load-theme 'ample-light t t)
               ;; (enable-theme 'ample))
  :defer t
  :ensure t))
(use-package spacegray-theme
  :ensure t)
(load-theme 'spacegray t)

(use-package airline-themes
  :ensure t)
(load-theme 'airline-papercolor)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(show-paren-mode)

;; enable line numbers
(global-linum-mode t)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("9b1c580339183a8661a84f5864a6c363260c80136bd20ac9f00d7e1d662e936a" "3eb93cd9a0da0f3e86b5d932ac0e3b5f0f50de7a0b805d4eb1f67782e9eb67a4" "b563a87aa29096e0b2e38889f7a5e3babde9982262181b65de9ce8b78e9324d5" "b59d7adea7873d58160d368d42828e7ac670340f11f36f67fa8071dbf957236a" default)))
 '(package-selected-packages
   (quote
    (spacegray-theme airline-themes powerline ace-jump-mode git-gutter evil-magit js2-jsx-mode ample-theme auto-complete editorconfig php-mode web-mode magit dumb-jump evil-indent-textobject evil-surround evil-jumper helm-projectile projectile helm use-package evil-visual-mark-mode)))
 '(projectile-mode t nil (projectile)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
