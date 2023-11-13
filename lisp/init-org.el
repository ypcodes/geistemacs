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
  (setq org-default-notes-file (concat org-directory "/gtd.org"))
  (setq org-hide-leading-stars t)

  (setq org-capture-templates
	'(("t" "Todo" entry (file+headline "~/org/Inbox.org" "Tasks")
           "* TODO %?\n  %i\n  %a")
          ("j" "Journal" entry (file+datetree "~/org/diary.org")
           "* %?\nEntered on %U\n  %i\n  %a")
	  ("n" "Note" entry (file "~/org/notes.org")
           "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
	  ("b" "Book" entry (file+olp+datetree
                             (concat org-directory "/book.org"))
	   "* Topic: %^{Description}  %^g %? Added: %U")
	  ))

  ;; org embedded YouTube

  (defvar yt-iframe-format
    ;; You may want to change your width and height.
    (concat "<iframe width=\"440\""
            " height=\"335\""
            " src=\"https://www.youtube.com/embed/%s\""
            " frameborder=\"0\""
            " allowfullscreen>%s</iframe>"))

  (org-add-link-type
   "yt"
   (lambda (handle)
     (browse-url
      (concat "https://www.youtube.com/embed/"
              handle)))
   (lambda (path desc backend)
     (cl-case backend
       (html (format yt-iframe-format
                     path (or desc "")))
       (latex (format "\href{%s}{%s}"
                      path (or desc "video"))))))
  
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

  ;; syntex-highlighting
  (use-package htmlize)
  ;;Don’t include a footer...etc in exported HTML document.
  (setq org-html-postamble nil)
  (setq org-src-window-setup 'current-window)

  (add-hook 'org-babel-after-execute-hook 'org-display-inline-images)
  (add-hook 'org-mode-hook 'org-display-inline-images)
  (custom-set-variables
   '(org-export-backends '(ascii beamed html calendar latex DOT)))


  (defun geist/org-mode-visual-fill ()
    (setq visual-fill-column-width 100
          visual-fill-column-center-text t)
    (visual-fill-column-mode 1))
  
  ;; Section 1.1: Org mode visual-fill configuration
  (use-package visual-fill-column
    :hook (org-mode . geist/org-mode-visual-fill))
  
  ;; latex
  (setq org-latex-pdf-process
	'("xelatex -interaction nonstopmode %f"
	  "xelatex -interaction nonstopmode %f"))
  ;; code执行免应答（Eval code without confirm）
  (setq org-confirm-babel-evaluate nil)
  ;; Auctex
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq-default TeX-master nil)
  (defun org-mode-article-modes ()
    (reftex-mode t)
    (and (buffer-file-name)
	 (file-exists-p (buffer-file-name))
	 (reftex-parse-all)))
  (add-hook 'org-mode-hook
            (lambda ()
              (if (member "REFTEX" org-todo-keywords-1)
                  (org-mode-article-modes))))
  (unless (boundp 'org-export-latex-classes)
    (setq org-export-latex-classes nil))

  (require 'ox-latex)


  (add-to-list 'org-latex-classes
               '("org-article"
		 "\\documentclass{article}
                 \\usepackage{graphicx}
                 \\usepackage{xcolor}
                 \\usepackage{xeCJK}
                 \\usepackage{ctex}
                 \\usepackage{fixltx2e}
                 \\usepackage{longtable}
                 \\usepackage{float}        
                 \\usepackage{tikz}         
                 \\usepackage{wrapfig}      
                 \\usepackage{latexsym,amssymb,amsmath}
                 \\usepackage{textcomp}
                 \\usepackage{listings}     
                \\usepackage{marvosym}     
                \\usepackage{textcomp}     
                \\usepackage{latexsym}     
                \\usepackage{natbib}       
                \\usepackage{geometry}     
                [NO-DEFAULT-PACKAGES]      
                [PACKAGES]                 
                [EXTRA]"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))


  (add-to-list 'org-latex-classes
               '("cn-article"
		 "\\documentclass[10pt,a4paper]{article}
\\usepackage{graphicx}
\\usepackage{xcolor}
\\usepackage{xeCJK}
\\usepackage{lmodern}
\\usepackage{ctex}
\\usepackage{verbatim}
\\usepackage{fixltx2e}
\\usepackage{longtable}
\\usepackage{float}
\\usepackage{tikz}
\\usepackage{wrapfig}
\\usepackage{soul}
\\usepackage{textcomp}
\\usepackage{listings}
\\usepackage{geometry}
\\usepackage{algorithm}
\\usepackage{algorithmic}
\\usepackage{marvosym}
\\usepackage{wasysym}
\\usepackage{latexsym}
\\usepackage{natbib}
\\usepackage{fancyhdr}
\\usepackage[xetex,colorlinks=true,CJKbookmarks=true,
linkcolor=blue,
urlcolor=blue,
menucolor=blue]{hyperref}
\\usepackage{fontspec,xunicode,xltxtra}
\\setmainfont[BoldFont=Adobe Heiti Std]{Adobe Song Std}  
\\setsansfont[BoldFont=Adobe Heiti Std]{AR PL UKai CN}  
\\setmonofont{Bitstream Vera Sans Mono}  
\\newcommand\\fontnamemono{AR PL UKai CN}%等宽字体
\\newfontinstance\\MONO{\\fontnamemono}
\\newcommand{\\mono}[1]{{\\MONO #1}}
\\setCJKmainfont[Scale=0.9]{Adobe Heiti Std}%中文字体
\\setCJKmonofont[Scale=0.9]{Adobe Heiti Std}
\\hypersetup{unicode=true}
\\geometry{a4paper, textwidth=6.5in, textheight=10in,
marginparsep=7pt, marginparwidth=.6in}
\\definecolor{foreground}{RGB}{220,220,204}%浅灰
\\definecolor{background}{RGB}{62,62,62}%浅黑
\\definecolor{preprocess}{RGB}{250,187,249}%浅紫
\\definecolor{var}{RGB}{239,224,174}%浅肉色
\\definecolor{string}{RGB}{154,150,230}%浅紫色
\\definecolor{type}{RGB}{225,225,116}%浅黄
\\definecolor{function}{RGB}{140,206,211}%浅天蓝
\\definecolor{keyword}{RGB}{239,224,174}%浅肉色
\\definecolor{comment}{RGB}{180,98,4}%深褐色
\\definecolor{doc}{RGB}{175,215,175}%浅铅绿
\\definecolor{comdil}{RGB}{111,128,111}%深灰
\\definecolor{constant}{RGB}{220,162,170}%粉红
\\definecolor{buildin}{RGB}{127,159,127}%深铅绿
\\punctstyle{kaiming}
\\title{}
\\fancyfoot[C]{\\bfseries\\thepage}
\\chead{\\MakeUppercase\\sectionmark}
\\pagestyle{fancy}
\\tolerance=1000
[NO-DEFAULT-PACKAGES]
[NO-PACKAGES]"
		 ("\\section{%s}" . "\\section*{%s}")
		 ("\\subsection{%s}" . "\\subsection*{%s}")
		 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
		 ("\\paragraph{%s}" . "\\paragraph*{%s}")
		 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

  ;; 使用Listings宏包格式化源代码(只是把代码框用listing环境框起来，还需要额外的设置)
  (setq org-export-latex-listings t)
  ;; Options for \lset command（reference to listing Manual)
  (setq org-export-latex-listings-options
	'(
          ("basicstyle" "\\color{foreground}\\small\\mono")           ; 源代码字体样式
          ("keywordstyle" "\\color{function}\\bfseries\\small\\mono") ; 关键词字体样式
          ("identifierstyle" "\\color{doc}\\small\\mono")
          ("commentstyle" "\\color{comment}\\small\\itshape")         ; 批注样式
          ("stringstyle" "\\color{string}\\small")                    ; 字符串样式
          ("showstringspaces" "false")                                ; 字符串空格显示
          ("numbers" "left")                                          ; 行号显示
          ("numberstyle" "\\color{preprocess}")                       ; 行号样式
          ("stepnumber" "1")                                          ; 行号递增
          ("backgroundcolor" "\\color{background}")                   ; 代码框背景色
          ("tabsize" "4")                                             ; TAB等效空格数
          ("captionpos" "t")                                          ; 标题位置 top or buttom(t|b)
          ("breaklines" "true")                                       ; 自动断行
          ("breakatwhitespace" "true")                                ; 只在空格分行
          ("showspaces" "false")                                      ; 显示空格
          ("columns" "flexible")                                      ; 列样式
          ("frame" "single")                                          ; 代码框：阴影盒
          ("frameround" "tttt")                                       ; 代码框： 圆角
          ("framesep" "0pt")
          ("framerule" "8pt")
          ("rulecolor" "\\color{background}")
          ("fillcolor" "\\color{white}")
          ("rulesepcolor" "\\color{comdil}")
          ("framexleftmargin" "10mm")
          ))
  ;; Make Org use ido-completing-read for most of its completing prompts.
  ;;(setq org-completion-use-ido t)
  ;; 各种Babel语言支持
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((R . t)
     (emacs-lisp . t)
     (matlab . t)
     (C . t)
     (perl . t)
     (shell . t)
     (ditaa . t)
     (python . t)
     (haskell . t)
     (dot . t)
     (latex . t)
     (js . t)
     ))

  ;; 导出Beamer的设置
  ;; allow for export=>beamer by placing #+LaTeX_CLASS: beamer in org files
  ;;-----------------------------------------------------------------------------
  (add-to-list 'org-export-latex-classes
               ;; beamer class, for presentations
               '("beamer"
		 "\\documentclass[11pt,professionalfonts]{beamer}
\\mode
\\usetheme{{{{Warsaw}}}}
%\\usecolortheme{{{{beamercolortheme}}}}

\\beamertemplateballitem
\\setbeameroption{show notes}
\\usepackage{graphicx}
\\usepackage{tikz}
\\usepackage{xcolor}
\\usepackage{xeCJK}
\\usepackage{amsmath}
\\usepackage{lmodern}
\\usepackage{fontspec,xunicode,xltxtra}
\\usepackage{polyglossia}
\\setmainfont{Times New Roman}
\\setCJKmainfont{DejaVu Sans YuanTi}
\\setCJKmonofont{DejaVu Sans YuanTi Mono}
\\usepackage{verbatim}
\\usepackage{listings}
\\institute{{{{beamerinstitute}}}}
\\subject{{{{beamersubject}}}}"
		 ("\\section{%s}" . "\\section*{%s}")
		 ("\\begin{frame}[fragile]\\frametitle{%s}"
                  "\\end{frame}"
                  "\\begin{frame}[fragile]\\frametitle{%s}"
                  "\\end{frame}")))

  (setq ps-paper-type 'a4
	ps-font-size 16.0
	ps-print-header nil
	ps-landscape-mode nil)
  )

;; org contrib
;; Installing and configure ORG-CONTRIB 
(use-package org-contrib
  :config
  (require 'ox-extra)
  (ox-extras-activate '(latex-header-blocks ignore-headlines)))


;; Section 2: Org Bullets Configuration
(use-package org-bullets
  :after org
  :custom
  (org-bullets-bullet-list '("◉" "☯" "○" "☯" "✸" "☯" "✿" "☯" "✜" "☯" "◆" "☯" "▶"))
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
