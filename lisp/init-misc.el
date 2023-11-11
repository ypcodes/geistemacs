(if (not (eq system-type 'ms-dos))
    (progn
      (use-package vterm
	:defer t
	:commands (vterm))

      (use-package vterm-toggle
	:after vterm)
      )
  )

;; spell checker
(use-package jinx
  :hook (emacs-startup . global-jinx-mode)
  :config
  (setq jinx-languages "en_US")
  (evil-define-key 'normal 'global (kbd "<leader>cw") 'jinx-correct))
(use-package helpful
  :commands (helpful-callable helpful-variable helpful-command helpful-key)
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key)
  )
(provide 'init-misc)
