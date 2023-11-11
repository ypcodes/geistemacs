
(use-package persp-mode
  :hook (window-setup . persp-mode)
  :custom
  (setq wg-morph-on nil)
  (setq persp-autokill-buffer-on-remove 'kill-weak)
  :config
  (evil-define-key 'normal 'global (kbd "<leader>wc") 'persp-add-new)
  (evil-define-key 'normal 'global (kbd "<leader>wn") 'persp-next)
  (evil-define-key 'normal 'global (kbd "<leader>wp") 'persp-prev)
  (evil-define-key 'normal 'global (kbd "<leader>ws") 'persp-switch)
  )

(provide 'init-workspace)
