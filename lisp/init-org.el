;;; init-org.el --- org mode setup                   -*- lexical-binding: t; -*-

;; Copyright (C) 2023  peng

;; Author: peng <peng@peng>
;; Keywords: lisp, 
(use-package org
  :defer t
  :hook (org-mode . (lambda() (org-indent-mode t) (visual-line-mode t)))
  :config

  ;; Choose some fonts
  ;; (set-face-attribute 'default nil :family "Iosevka")
  ;; (set-face-attribute 'variable-pitch nil :family "Iosevka Aile")
  ;; (set-face-attribute 'org-modern-symbol nil :family "Iosevka")

  ;; Add frame borders and window dividers
  ;;(setq org-indent-mode t)
  (setq
   ;; Edit settings
   org-auto-align-tags nil
   org-indent-mode t
   org-tags-column 0
   org-catch-invisible-edits 'show-and-error
   org-special-ctrl-a/e t
   org-insert-heading-respect-content t

   ;; Org styling, hide markup etc.
   org-hide-emphasis-markers t
   org-pretty-entities t
   org-ellipsis "…"

   ;; Agenda styling
   org-agenda-tags-column 0
   org-agenda-block-separator ?─
   org-agenda-time-grid
   '((daily today require-timed)
     (800 1000 1200 1400 1600 1800 2000)
     " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")
   org-agenda-current-time-string
   "◀── now ─────────────────────────────────────────────────")
  )

(use-package org-bullets
  :after org
  :config
  (org-bullets-mode t)
)

(use-package org-modern
  :after org
  :config
  (global-org-modern-mode))

(use-package toc-org
  :after org
  :config
  (toc-org-mode t))

(use-package org-roam
  :defer t
  :custom
  (org-roam-directory (file-truename "~/org"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode))

(provide 'init-org)
