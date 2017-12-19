(package-initialize)

(require 'cask "~/.cask/cask.el")
(cask-initialize)

(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

(require 'perspective)
(persp-mode t)
(global-set-key (kbd "C-M-S-n") 'persp-next)
(global-set-key (kbd "C-M-S-p") 'persp-prev)

(require 'which-key)
(which-key-mode)

(projectile-mode 1)
(require 'helm-projectile)
(helm-projectile-on)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x C-r") 'helm-for-files)
(setq helm-ff-skip-boring-files t)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(global-set-key (kbd "C-h a") 'helm-apropos)
(global-set-key (kbd "M-Y") 'helm-show-kill-ring)
(global-set-key (kbd "C-h C-m") 'helm-man-woman)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (pdf-tools auto-complete sourcerer-theme org-babel-eval-in-repl which-key perspective helm-projectile)))
 '(persp-mode t)
 '(send-mail-function (quote smtpmail-send-it))
 '(smtpmail-smtp-server "smtp.gmail.com")
 '(smtpmail-smtp-service 25))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; -*- mode: elisp -*-

;; Disable the splash screen (to enable it agin, replace the t with 0)
(setq inhibit-splash-screen t)

;; Enable transient mark mode
(transient-mark-mode 1)

;;;;Org mode configuration
;; Enable Org mode
(require 'org)
;; Make Org mode work with files ending in .org
;; (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; The above is the default in recent emacsen

(setq org-todo-keywords
'((sequence "TODO" "STARTED" "|" "DONE")))

(setq org-log-done 'time)
(setq org-log-done 'note)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'sourcerer t)

(ac-config-default)

;; Keeps ~Cask~ file in sync with the packages
;; that you install/uninstall via ~M-x list-packages~
;; https://github.com/rdallasgray/pallet
(require 'pallet)

(require 'multiple-cursors)
(global-set-key (kbd "M-n") 'mc/mark-next-like-this)
(global-set-key (kbd "M-p") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c M-n") 'mc/mark-all-like-this)
(global-set-key (kbd "C-c M-p") 'mc/mark-all-words-like-this)

(global-unset-key (kbd "M-<down-mouse-1>"))
(global-set-key (kbd "M-<mouse-1>") 'mc/add-cursor-on-click)

(require 'restclient)
(require 'know-your-http-well)

;; JS
(require 'js2-mode)
(require 'indium)
(require 'js2-refactor)
(add-hook 'js2-mode-hook #'js2-refactor-mode)
(js2r-add-keybindings-with-prefix "C-c C-m")
(require 'xref-js2)
(define-key js-mode-map (kbd "M-.") nil)
(add-hook 'js2-mode-hook (lambda ()
			   (add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t)))
(require 'prettier-js)

(require 'editorconfig)
(editorconfig-mode 1)

(require 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'css-mode-hook 'emmet-mode) ;; enable Emmet's css abbreviation.
(setq emmet-expand-jsx-className? t)

(require 'yasnippet)
(yas-global-mode 1)

;; Git
(require 'magit)
(eval-after-load 'magit
  (progn '(global-set-key (kbd "C-x g") 'magit-status)))

(global-git-gutter+-mode)
(eval-after-load 'git-gutter+
  '(progn
     (define-key git-gutter+-mode-map (kbd "M-g M-n") 'git-gutter+-next-hunk)
     (define-key git-gutter+-mode-map (kbd "M-g M-p") 'git-gutter+-previous-hunk)
     (define-key git-gutter+-mode-map (kbd "M-g M-s") 'git-gutter+-show-hunk-inline-at-point)
     (define-key git-gutter+-mode-map (kbd "M-g M-r") 'git-gutter+-revert-hunks)
     (define-key git-gutter+-mode-map (kbd "M-g M-u") 'git-gutter+-unstage-whole-buffer)))

;; Ledger - command-line accounting
(autoload 'ledger-mode "ledger-mode" "A major mode for Ledger" t)
(add-to-list 'load-path
             (expand-file-name "/home/smoothpie/ledger/source/lisp/"))
(add-to-list 'auto-mode-alist '("\\.ledger$" . ledger-mode))
