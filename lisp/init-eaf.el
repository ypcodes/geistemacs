;; eaf
(use-package eaf
  :defer t
  :commands (eaf-open-browser eaf-open eaf-search-it eaf-open-browser-with-history eaf-open-browser-other-window eaf-open-pyqterminal)
  :custom
  (eaf-browser-continue-where-left-off t)
  (eaf-browser-enable-adblocker t)
  (browse-url-browser-function 'eaf-open-browser)
  ;; maps
  :config
  (require 'eaf-pyqterminal)
  (require 'eaf-browser)
  (require 'eaf-pdf-viewer)
  (setq eaf-evil-leader-key "C-SPC")
  (defalias 'browse-web #'eaf-open-browser)
  (eaf-bind-key scroll_up "C-n" eaf-pdf-viewer-keybinding)
  (eaf-bind-key scroll_down "C-p" eaf-pdf-viewer-keybinding)
  (eaf-bind-key nil "M-q" eaf-browser-keybinding)
  (setq eaf-browser-default-search-engine "google")
  (setq eaf-proxy-type "http")
  (setq eaf-proxy-host "127.0.0.1")
  (setq eaf-proxy-port "7890"))

(provide 'init-eaf)
