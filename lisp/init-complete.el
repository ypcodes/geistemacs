;;; init-complete.el --- Configuration for completion packages -*- lexical-binding: t; -*-

;; Copyright (C) 2023 peng

;; Author: peng <peng@peng>
;; Keywords: lisp

;; This file sets up various completion-related packages.

;; Section 1: Consult and Marginalia Configuration
(use-package consult
  :defer t)

(use-package marginalia
  :after vertico
  :bind (:map minibuffer-local-map
	      ("M-A" . marginalia-cycle))
  :init
  (marginalia-mode))

;; Section 2: Embark Configuration
(use-package embark
  :after consult
  :bind
  (("C-." . embark-act)
   ("C-;" . embark-dwim)
   ("C-h B" . embark-bindings))
  :init
  (setq prefix-help-command #'embark-prefix-help-command)
  (add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target)
  :config
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

(use-package embark-consult
  :after embark
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

;; Section 3: Vertico Configuration
(use-package vertico
  :defer t
  :commands (execute-extended-command)
  :init
  (vertico-mode)
  :config
  (keymap-set vertico-map "?" #'minibuffer-completion-help)
  (keymap-set vertico-map "M-RET" #'minibuffer-force-complete-and-exit)
  (keymap-set vertico-map "M-TAB" #'minibuffer-complete)
  (setq completion-styles '(substring orderless basic)))

;; Section 4: Nerd Icons Completion
(use-package nerd-icons-completion
  :after vertico
  :config (nerd-icons-completion-mode t))

;; Section 5: Vertico Directory Configuration
(use-package vertico-directory
  :after vertico
  :load-path "lib/vertico/extensions/"
  :bind
  (:map vertico-map
        ("RET" . vertico-directory-enter)
        ("DEL" . vertico-directory-delete-char)
        ("M-DEL" . vertico-directory-delete-word))
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))

;; Section 6: Orderless Configuration
(use-package orderless
  :init
  (setq completion-styles '(orderless basic)
        completion-ctegory-defaults nil
        completion-category-overrides '((file (styles partial-completion))))
  (setq read-file-name-completion-ignore-case t
        read-buffer-completion-ignore-case t
        completion-ignore-case t))

;; Section 7: Avy Configuration
(use-package avy
  :after vertico
  :defer t
  :config
  (avy-setup-default))

;; Section 8: Yasnippet Configuration
(use-package yasnippet
  :defer t
  :init (yas-global-mode 1)
  :config
  (evil-define-key 'normal 'global (kbd "<leader>is") 'yas-insert-snippet))

;; Section 9: LSP Bridge Configuration
(use-package lsp-bridge
  :after yasnippet
  :init
  (global-lsp-bridge-mode)
  :config
  (evil-define-key 'normal 'global (kbd "<leader>cf") 'lsp-bridge-code-format))

;; Section 10: Tempel Configuration
(use-package tempel
  :defer t
  :commands (tempel-insert)
  :init
  (defun tempel-setup-capf ()
    (setq-local completion-at-point-functions
                (cons #'tempel-expand
                      completion-at-point-functions)))
  (add-hook 'conf-mode-hook 'tempel-setup-capf)
  (add-hook 'prog-mode-hook 'tempel-setup-capf)
  (add-hook 'text-mode-hook 'tempel-setup-capf)
  (add-hook 'prog-mode-hook #'tempel-abbrev-mode)
  (evil-define-key 'normal 'global (kbd "<leader>it") 'tempel-insert)
  (evil-define-key 'normal 'global (kbd "<leader>ic") 'tempel-complete)
  (global-tempel-abbrev-mode))

;; Section 11: Tempel Collection Configuration
(use-package tempel-collection
  :after tempel)

;; Section 12: Expand Region Configuration
(use-package expand-region
  :bind ("C-=" . er/expand-region))

(provide 'init-complete)
