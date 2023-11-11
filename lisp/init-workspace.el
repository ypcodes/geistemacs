
(use-package persp-mode
  :hook (window-setup . persp-mode)
  :custom
  (setq wg-morph-on nil)
  (setq persp-autokill-buffer-on-remove 'kill-weak)
  :config
  (evil-define-key 'normal 'global (kbd "<leader> TAB c") 'persp-add-new)
  (evil-define-key 'normal 'global (kbd "<leader> TAB n") 'persp-next)
  (evil-define-key 'normal 'global (kbd "<leader> TAB p") 'persp-prev)
  (evil-define-key 'normal 'global (kbd "<leader> TAB s") 'persp-switch)
  )

(provide 'init-workspace)
