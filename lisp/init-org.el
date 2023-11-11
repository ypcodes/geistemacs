;;; init-org.el --- Org mode setup -*- lexical-binding: t; -*-

;; Copyright (C) 2023 peng

;; Author: peng <peng@peng>
;; Keywords: lisp

;; This file sets up Org mode with various configurations and packages.

(defun geist/org-mode-setup ()
  "org-mode-initial-setup"
  (org-indent-mode t)
  )
;; Section 1: Org Mode Configuration
(use-package org
  :defer t
  :hook (org-mode . geist/org-mode-setup)
  :config
  (setq org-agenda-files '("~/org/Inbox.org" "~/org/diary.org" "~/org/todo.org"))
  (setq org-hide-leading-stars t)

  ;; Org styling and settings
  (setq org-auto-align-tags nil
        org-indent-mode t
        org-tags-column 0
        org-catch-invisible-edits 'show-and-error
        org-special-ctrl-a/e t
        org-insert-heading-respect-content t
        org-hide-emphasis-markers t
        org-pretty-entities t
        org-ellipsis "…"
        org-agenda-tags-column 0
        org-agenda-block-separator ?─
        org-agenda-time-grid
        '((daily today require-timed)
          (800 1000 1200 1400 1600 1800 2000)
          " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")
        org-agenda-current-time-string
        "◀── now ─────────────────────────────────────────────────")

  
  (defun geist/org-mode-visual-fill ()
    (setq visual-fill-column-width 100
          visual-fill-column-center-text t)
    (visual-fill-column-mode 1))

  ;; Section 1.1: Org mode visual-fill configuration
  (use-package visual-fill-column
    :hook (org-mode . geist/org-mode-visual-fill))

  ;; Section 1.2: Org Babel setup
  (with-eval-after-load 'org
    (org-babel-do-load-languages
     'org-babel-load-languages
     '((emacs-lisp . t)
       (C . t)
       (shell . t)
       (python . t)))
    (push '("conf-unix" . conf-unix) org-src-lang-modes)))

;; Section 2: Org Bullets Configuration
(use-package org-bullets
  :after org
  :config
  (org-bullets-mode t))

;; Section 3: Org Modern Configuration
(use-package org-modern
  :after org
  :config
  (global-org-modern-mode))

;; Section 4: Table of Contents Configuration
(use-package toc-org
  :after org
  :config
  (toc-org-mode t))

;; Section 5: Org Roam Configuration
(use-package org-roam
  :defer t
  :custom
  (org-roam-directory (file-truename "~/org"))
  :bind
  (("C-c n l" . org-roam-buffer-toggle)
   ("C-c n f" . org-roam-node-find)
   ("C-c n g" . org-roam-graph)
   ("C-c n i" . org-roam-node-insert)
   ("C-c n c" . org-roam-capture)
   ("C-c n j" . org-roam-dailies-capture-today))
  :config
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode))

;; Section 6: Global Key Bindings
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(setq org-habit-show-habits-only-for-today t)

;; Section 7: Org Clock and Refile Configurations
(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)
(setq org-src-fontify-natively t)
(advice-add 'org-refile :after 'org-save-all-org-buffers)
(setq org-startup-with-inline-images t)

;; Section 8: Org Super Agenda Configuration
(use-package org-super-agenda
  :after org-agenda
  :config
  (org-super-agenda-mode))

;; Section 9: Provide the feature
(provide 'init-org)
