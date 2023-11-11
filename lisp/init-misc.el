(use-package vterm
  :defer t
  :commands (vterm)
  )

(use-package vterm-toggle
  :after vterm)

;; spell checker
(use-package jinx
  :hook (emacs-startup . global-jinx-mode)
  :config (setq jinx-languages "en_US")
  (evil-define-key 'normal 'global (kbd "<leader>cw") 'jinx-correct))

(provide 'init-misc)
