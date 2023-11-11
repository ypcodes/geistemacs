(use-package catppuccin-theme
  :custom
  (setq catppuccin-flavor 'mocha)
  :config
  (load-theme 'catppuccin :no-confirm)
)

(use-package doom-modeline
  :init (doom-modeline-mode 1))

(use-package better-defaults
  :defer t
  :config
  (ido-mode nil))

(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-banner-logo-title "Welcome to Geist Emacs")
  (setq dashboard-startup-banner 'logo)
  ;; Value can be
  ;; - nil to display no banner
  ;; - 'official which displays the official emacs logo
  ;; - 'logo which displays an alternative emacs logo
  ;; - 1, 2 or 3 which displays one of the text banners
  ;; - "path/to/your/image.gif", "path/to/your/image.png" or "path/to/your/text.txt" which displays whatever gif/image/text you would prefer
  ;; - a cons of '("path/to/your/image.png" . "path/to/your/text.txt")
  
  ;; Content is not centered by default. To center, set
  (setq dashboard-center-content t)
  
  ;; To disable shortcut "jump" indicators for each section, set
  
  (setq dashboard-display-icons-p t) ;; display icons on both GUI and terminal
  (setq dashboard-icon-type 'nerd-icons) ;; use `nerd-icons' package
  
  ;; (setq dashboard-set-heading-icons t)
  ;; (setq dashboard-set-file-icons t)
  
  ;; ;;(add-to-list 'dashboard-items '(agenda) t)

  ;; (setq dashboard-week-agenda t)
  ;; (setq dashboard-items '((recents  . 5)
  ;;                       (bookmarks . 5)
  ;;                       (projects . 5)
  ;;                       (agenda . 5)
  ;;                       (registers . 5)))
  ;; (setq dashboard-item-names '(("Recent Files:" . "Recently opened files:")
  ;;                            ("Agenda for today:" . "Today's agenda:")
  ;;                            ("Agenda for the coming week:" . "Agenda:")))
  ;; (setq dashboard-set-navigator t)
)

(use-package aggressive-indent
  :after vertico
  :config
  (global-aggressive-indent-mode))


(provide 'init-ui)
