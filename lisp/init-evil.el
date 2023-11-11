;; evil
(use-package evil
  :defer t
  :commands (evil-next-line)
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  (evil-mode 1)

  :config
  ;; keybinding
  (evil-set-leader 'motion (kbd "SPC"))
  (evil-define-key 'normal 'global (kbd "<leader>fs") 'save-buffer)
  (evil-define-key 'normal 'global (kbd "<leader>;") 'execute-extended-command)
  (evil-define-key 'normal 'global (kbd "<leader>SPC") 'project-find-file)
  (evil-define-key 'normal 'global (kbd "<leader>ff") 'find-file)
  (evil-define-key 'normal 'global (kbd "<leader>fr") 'recentf)
  (evil-define-key 'normal 'global (kbd "<leader>bk") 'kill-current-buffer)
  (evil-define-key 'normal 'global (kbd "<leader>bb") 'consult-buffer)
  (evil-define-key 'normal 'global (kbd "<leader>bi") 'ibuffer)
  (evil-define-key 'normal 'global (kbd "<leader>bk") 'kill-current-buffer)
  (evil-define-key 'normal 'global (kbd "<leader>qq") 'save-buffers-kill-emacs)
  (evil-define-key 'normal 'global (kbd "<leader>jj") 'avy-goto-line)
  (evil-define-key 'normal 'global (kbd "<leader>jc") 'avy-goto-char-2)
  (evil-define-key 'normal 'global (kbd "<leader>jw") 'avy-goto-word-1)
  (evil-define-key 'normal 'global (kbd "<leader>gg") 'magit)
  (evil-define-key 'normal 'global (kbd "<leader>ga") 'magit-stage-file)
  (evil-define-key 'normal 'global (kbd "<leader>gp") 'magit-push-current-to-upstream)
  (evil-define-key 'normal 'global (kbd "<leader>ot") 'vterm-toggle)
  (evil-define-key 'normal 'global (kbd "<leader>os") 'eaf-search-it)
  (evil-define-key 'normal 'global (kbd "<leader>ob") 'eaf-open-browser-with-history)
  (evil-define-key 'normal 'global (kbd "<leader>oe") 'eaf-open)
  
  ;; search
  
  (evil-define-key 'normal 'global (kbd "<leader>ss") 'consult-line)
  (evil-define-key 'normal 'global (kbd "<leader>so") 'consult-outline)

  ;; helpful
  (evil-define-key 'normal 'global (kbd "<leader>hk") 'helpful-key)
  (evil-define-key 'normal 'global (kbd "<leader>hf") 'helpful-function)
  (evil-define-key 'normal 'global (kbd "<leader>hv") 'helpful-variable)
  (evil-define-key 'normal 'global (kbd "<leader>hc") 'helpful-command)
  
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
  :defer t
  :init (which-key-mode))

(use-package multiple-cursors
  :defer t
  :after evil
  :config
  (evil-define-key 'normal 'global (kbd "M-d") 'mc/mark-next-like-this-word)
  (evil-define-key 'normal 'global (kbd "M-S-d") 'mc/mark-previous-like-this-word)
  (evil-define-key 'normal 'global (kbd "<leader>ml") 'mc/edit-lines)
  )

(provide 'init-evil)
