(use-package doom-themes
  :init (load-theme 'doom-one t))

(use-package doom-modeline
  :init (doom-modeline-mode 1))

(use-package better-defaults
  :defer t
  :config
  (ido-mode nil))

(provide 'init-ui)
