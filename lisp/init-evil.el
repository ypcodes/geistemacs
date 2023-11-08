;; evil
(use-package evil
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  (evil-mode 1)

  :config
  ;; keybinding
  (evil-set-leader 'motion (kbd "SPC"))
  (evil-define-key 'normal 'global (kbd "<leader>fs") 'save-buffer)
  (evil-define-key 'normal 'global (kbd "<leader>:") 'execute-extended-command)
  (evil-define-key 'normal 'global (kbd "<leader>SPC") 'project-find-file)
  (evil-define-key 'normal 'global (kbd "<leader>ff") 'find-file)
  (evil-define-key 'normal 'global (kbd "<leader>bk") 'kill-current-buffer)
  (evil-define-key 'normal 'global (kbd "<leader>bb") 'consult-buffer)
  (evil-define-key 'normal 'global (kbd "<leader>bi") 'ibuffer)
  (evil-define-key 'normal 'global (kbd "<leader>bk") 'kill-current-buffer)
  (evil-define-key 'normal 'global (kbd "<leader>qq") 'save-buffers-kill-emacs)
  (evil-define-key 'normal 'global (kbd "<leader>gl") 'avy-goto-line)
  (evil-define-key 'normal 'global (kbd "<leader>gc") 'avy-goto-char-2)
  (evil-define-key 'normal 'global (kbd "<leader>gw") 'avy-goto-word-0)
  
  (defalias 'evil-insert-state 'evil-emacs-state)
  (define-key evil-emacs-state-map (kbd "<escape>") 'evil-normal-state)
  (setq evil-emacs-state-cursor 'bar)
  )

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;;; evil setup
(use-package org-evil
  :defer t
  :after evil
)

;; which key
(use-package which-key
  :init (which-key-mode))

(provide 'init-evil)
