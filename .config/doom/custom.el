(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("835868dcd17131ba8b9619d14c67c127aa18b90a82438c8613586331129dda63" "234dbb732ef054b109a9e5ee5b499632c63cc24f7c2383a849815dacc1727cb6" default))
 '(doom-themes-treemacs-theme "doom-colors")
 '(flycheck-golangci-lint-enable-all nil)
 '(flycheck-golangci-lint-executable "/home/ag/go/bin/golangci-lint")
 '(flycheck-golangci-lint-fast t)
 '(flycheck-golangci-lint-tests t)
 '(ignored-local-variable-values
   '((eval add-to-list 'org-export-before-processing-hook
           (lambda
             (be)
             (org-babel-tangle)))
     (eval setq org-latex-pdf-process
           (list "latexmk -pdf %f"))
     (eval require 'doi-utils)
     (eval require 'org-ref)
     (eval ox-extras-activate
           '(ignore-headlines))
     (eval require 'ox-extra)
     (eval eval
           (flyspell-mode t))
     (eval setq ispell-local-dictionary "american")
     (eval setq ess-ask-for-ess-directory nil)
     (eval setq org-src-fontify-natively t)
     (eval setq org-alphabetical-lists t)
     (eval add-to-list 'org-latex-classes
           '("IEEEtran" "\\documentclass[conference, 10pt, compsocconf]{IEEEtran}
 [NO-DEFAULT-PACKAGES]
 [EXTRA]
  \\usepackage{graphicx}
  \\usepackage{hyperref}"
             ("\\section{%s}" . "\\section*{%s}")
             ("\\subsection{%s}" . "\\subsection*{%s}")
             ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
             ("\\paragraph{%s}" . "\\paragraph*{%s}")
             ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
     (eval unless
           (boundp 'org-latex-classes)
           (setq org-latex-classes nil))
     (eval setq org-confirm-babel-evaluate nil)
     (eval org-babel-do-load-languages 'org-babel-load-languages
           '((shell . t)
             (R . t)
             (perl . t)
             (python . t)))
     (eval require 'org-install)
     (eval add-to-list 'load-path ".")))
 '(org-latex-classes
   '(("article" "\\documentclass[11pt]{article}"
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
      ("\\paragraph{%s}" . "\\paragraph*{%s}")
      ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
     ("report" "\\documentclass[11pt]{report}"
      ("\\part{%s}" . "\\part*{%s}")
      ("\\chapter{%s}" . "\\chapter*{%s}")
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
     ("book" "\\documentclass[11pt]{book}"
      ("\\part{%s}" . "\\part*{%s}")
      ("\\chapter{%s}" . "\\chapter*{%s}")
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
     ("IEEEtran" "\\documentclass[conference]{IEEEtran}"
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
      ("\\paragraph{%s}" . "\\paragraph*{%s}")
      ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))
 '(org-latex-pdf-process
   '("latexmk -shell-escape -bibtex -f -pdf -%latex -interaction=nonstopmode -output-directory=%o %f")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-comment-face ((t (:slant italic))))
 '(font-lock-keyword-face ((t (:slant italic)))))
