;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; (toggle-frame-maximized)

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "DiegoAGtz"
      user-mail-address "diegogtz3435@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(map! :leader
      :desc "Org babel tangle" "m B" #'org-babel-tangle)
(after! org
  (setq org-directory "~/org/"
        org-agenda-files '("~/org/agenda.org")
        org-default-notes-file (expand-file-name "notes.org" org-directory)
        org-ellipsis " ▼ "
        org-superstar-headline-bullets-list '("◉" "●" "○" "◆" "●" "○" "◆")
        org-superstar-itembullet-alist '((?+ . ?➤) (?- . ?✦)) ; changes +/- symbols in item lists
        org-log-done 'time
        org-hide-emphasis-markers t
        org-table-convert-region-max-lines 20000))
                                        ; org-todo-keywords        ; This overwrites the default Doom org-todo-keywords
                                        ; '((sequence
                                        ;    "TODO(t)"           ; A task that is ready to be tackled
                                        ;    "BLOG(b)"           ; Blog writing assignments
                                        ;    "GYM(g)"            ; Things to accomplish at the gym
                                        ;    "PROJ(p)"           ; A project that contains other tasks
                                        ;    "VIDEO(v)"          ; Video assignments
                                        ;    "WAIT(w)"           ; Something is holding up this task
                                        ;    "|"                 ; The pipe necessary to separate "active" states and "inactive" states
                                        ;    "DONE(d)"           ; Task has been completed
                                        ;    "CANCELLED(c)" )))) ; Task has been cancelled

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;

;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq doom-font (font-spec :family "JetBrainsMono Nerd Font Mono" :size 17)
      doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font Mono" :size 15)
      doom-big-font (font-spec :family "JetBrainsMono Nerd Font Mono" :size 24))
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

(setq doom-theme 'doom-one)

(setq centaur-tabs-set-bar 'over
      centaur-tabs-set-icons t
      centaur-tabs-gray-out-icons 'buffer
      centaur-tabs-height 24
      centaur-tabs-set-modified-marker t
      centaur-tabs-style "bar"
      centaur-tabs-modified-marker "•")
(map! :leader
      :desc "Toggle tabs globally" "t c" #'centaur-tabs-mode
      :desc "Toggle tabs local display" "t C" #'centaur-tabs-local-mode)
(evil-define-key 'normal centaur-tabs-mode-map
  (kbd "g <right>") 'centaur-tabs-forward        ; default Doom binding is 'g t'
  (kbd "g <left>")  'centaur-tabs-backward       ; default Doom binding is 'g T'
  (kbd "g <down>")  'centaur-tabs-forward-group
  (kbd "g <up>")    'centaur-tabs-backward-group)

;; This setting ensures that emacsclient always opens on dashboard rather than scratch.
;; (setq initial-buffer-choice (lambda () (get-buffer "*doom*")))

;; LaTeX classes
;; (add-to-list 'org-latex-classes
;;              '("IEEEtran"
;;                "\\documentclass[conference]{IEEEtran}"))

(setq flutter-sdk-path "~/.flutter/flutter/bin/flutter") ;;Path to your dart-sdk

(setq org-latex-compilers '("latexmk" "pdflatex" "xelatex" "lualatex"))

(add-to-list 'load-path ".")
(require 'ox-extra)
(ox-extras-activate '(ignore-headlines))
;; (autoload 'babel "babel"
;;   "Use a web translation service to translate the message MSG." t)
;; (autoload 'babel-region "babel"
;;   "Use a web translation service to translate the current region." t)
;; (autoload 'babel-as-string "babel"
;;   "Use a web translation service to translate MSG, returning a string." t)
;; (autoload 'babel-buffer "babel"
;; "Use a web translation service to translate the current buffer." t)
