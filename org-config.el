;; -*- mode: emacs-lisp-mode -*- 



;;; org-config.el --- My config for org
;; 
;; Author: Gilberto Conde
;; Maintainer: Gilberto Conde
;; 
;; Created: origen anterior, pero 1 dic 2019
;; Version: 9.3
;; URL: 
;; Keywords: 
;; Compatibility: 
;; 
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or
;; (at your option) any later version.
;; 
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;; 
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;; 
;;; Commentary: Tome codigo prestado de otros sitios y lo puse aqui
;; 
;;  Ver mas ideas de https://notabug.org/thievol/emacs-config/src/master/org-config.el
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;; Code:




(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map [C-c l] 'org-store-link)
(setq org-default-notes-file "~/org/notes.org");;for capture
(global-set-key "\C-cb" 'org-iswitchb)
;; (global-set-key (kbd "<f7> O") 'org-clock-out)
;; (global-set-key (kbd "<f7> I") 'org-clock-in)
;; (global-set-key (kbd "<f7> M") 'org-clock-menu)
;; (global-set-key (kbd "<f7> G") 'org-clock-goto)
;; (global-set-key (kbd "<f7> R") 'org-clock-report)


(setq org-emphasis-alist (quote (("*" bold "<b>" "</b>") 
				 ("/" italic "<i>" "</i>")
				 ("_" underline 
				  "<span style=\"text-decoration:underline;\">" "</span>")
				 ("=" org-code "<code>" "</code>" verbatim)
				 ("~" org-verbatim "<code>" "</code>" verbatim)
				 ("+" (:strike-through t) "<del>" "</del>")
				 ("@" org-warning "<b>" "</b>")))
      org-latex-emphasis-alist (quote 
				       (("*" "\\textbf{%s}" nil)
					("/" "\\emph{%s}" nil) 
					("_" "\\underline{%s}" nil)
					("+" "\\texttt{%s}" nil)
					("=" "\\verb=%s=" nil)
					("~" "\\verb~%s~" t)
					("@" "\\alert{%s}" nil)))
      )


;;
;;                               Capture
;;

(setq org-capture-templates
      '(
	("t" "Todo" entry (file+headline "~/org/TODO.org" "Tasks")
	 "* TODO [#A] %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n%a\n")
	 ;; "* TODO %?\n %i\n %a\nEntered on %U\n")
        ("j" "Journal" entry (file+datetree "~/org/JOURNAL.org")
             "* %?\nEntered on %U\n  %i\n  %a" :clock-in t :clock-resume t)
        ("w" "Work log" entry (file+datetree "~/org/JOURNAL.org")
             "* %? :WORK:\nEntered on %U\n  %i\n  %a" :clock-in t :clock-resume t)
	("i" "Idea" entry (file+headline "~/org/notes.org" "New Ideas")
	     "* %^{Title}\n %i\n %a")
	("p" "Phone call" entry (file+datetree "~/org/JOURNAL.org")
       	     "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
       ;; ("f" "Pendientes" entry (file+datetree "~/Documents/perso/otros/pendientes/pendientes.org")
       ;;       "* TODO %?\n %i\n %a\nEntered on %U\n")
))


;;
;;                         org agenda 
;;


(setq org-agenda-files (list "~/org/gtd.org"
			     "~/org/TODO.org"
			     "~/org/recurrentes.org"
			     "~/org/notes.org"
;;			     "~/Documents/perso/otros/pendientes/pendientes.org"
;;			     "~/org/cursos.org"
;;			     "~/org/ponencias.org"
			     ))
(setq org-todo-keywords
      '((sequence "TODO(t)" "INPROGRESS(i)" "WAITING(w@/!)" "|" "DONE(d!/!)" "CANCELLED(c@/!)")
	))




;;
;;                      org export ox 
;;


(require 'ox-freemind)
(require 'ox-texinfo)

;;
;;                      org misc
;;

(setq org-export-with-smart-quotes t)

;; ESTAS COSAS VIENEN DEL REPOSITORIO DE ORGMODE
(require 'org-mac-iCal)

(require 'org-annotate-file)
(global-set-key (kbd "C-c C-l") 'org-annotate-file) ; for example

(require 'org-passwords)
(setq org-passwords-file "~/documents/passwords.gpg")
(setq org-passwords-random-words-dictionary "/etc/dictionaries-common/words")



;; algunas cositas útiles que encontré en
;; http://newartisans.com/2007/08/using-org-mode-as-a-day-planner/

;; Permite la importaci'on del Calendario de la Mac al diary de Emacs.

;; 'esta (modificada) la encontr'e en
;; http://lists.gnu.org/archive/html/emacs-orgmode/2007-08/msg00253.html
;; y sirve para ver todo un mes de agenda
;;(setq org-agenda-custom-commands '("W" agenda "" (org-agenda-ndays 31)))
;; pero es m'as f'acil redisponer la agenda con 'v m' o 'v y' si se
;; quiere ver el a~no completo, seg'un se explica en
;; http://orgmode.org/manual/Agenda-commands.html

(setq org-agenda-skip-scheduled-if-done t)
(setq org-agenda-todo-list-sublevels 2)
;; Estas son algunas claves para completar :TAGS: en org-mode

(setq org-tag-alist '(
		      ("Write" . ?w)
		      ("Update" . ?p)
		      ("Check" . ?c)
		      ("noexport" . ?n)
		      ("urgente" . ?u)
                      ("phone" . ?t)
 		      ("crypt" . ?y)
		      ("mail" . ?m)
;;                      ("wait" . ?w)
                      ("EAA" . ?a)
;;                      ("R&C" . ?r)
;;                      ("producir" . ?p)
;;                      ("docencia" . ?d)
		      (:startgroup . nil)
		      ("@errands" . ?e)
                      ("@home" . ?h)
                      ("@colmex" . ?x)
                      (:endgroup . nil)
;;                      ("draft" . ?d)
		      ))


;;; define filter. The filter is called on each entry in the agenda.
;;; It defines a regexp to search for two timestamps, gets the start
;;; and end point of the entry and does a regexp search. It also
;;; checks if the category of the entry is in an exclude list and
;;; returns either t or nil to skip or include the entry. tomado de 
;;; http://orgmode.org/worg/org-tutorials/org-google-sync.html#sec-3

(defun org-mycal-export-limit ()
  "Limit the export to items that have a date, time and a
range. Also exclude certain categories."
  (setq org-tst-regexp "<\\([0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\} ... [0-9]\\{2\\}:[0-9]\\{2\\}[^\r\n>]*?\\)>")
  (setq org-tstr-regexp (concat org-tst-regexp "--?-?" org-tst-regexp))
  (save-excursion
    ; get categories
    (setq mycategory (org-get-category))
    ; get start and end of tree
    (org-back-to-heading t)
    (setq mystart    (point))
    (org-end-of-subtree)
    (setq myend      (point))
    (goto-char mystart)
    ; search for timerange
    (setq myresult (re-search-forward org-tstr-regexp myend t))
    ; search for categories to exclude
    (setq mycatp (member mycategory org-exclude-category))
;;;    (setq mycatp (member mycategory org-export-exclude-category))
    ; return t if ok, nil when not ok
    (if (and myresult (not mycatp)) t nil)))



;; ; Activate appointments so we get notifications
(appt-activate t)


;; Use-enter-to-follow-links 
(setq org-return-follows-link t)






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;     Pre'ambulo preambulos y bloques de texto para org-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;  org: para definir un texto en español, en
;;  ingl'es y franc'es
;;
;;  ahora lo puse en abbrevs como
;;  - orgesw, orgenw y orgfrw
;;  - rgbeamw para beamer 
;;  - orgtrw para trasliteracion del arabe
;;  - orgcommentw: bloque de comentario
;;  - orgledgerw: bloque ledger
;;  - orglispw: bloque src elisp



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;               Define estructura de clase "report" 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(with-eval-after-load 'ox-latex
   (add-to-list 'org-latex-classes
                '("report"
                  "\\documentclass{report}"
                  ("\\chapter{%s}" . "\\chapter*{%s}")
                  ("\\section{%s}" . "\\section*{%s}")
                  ("\\subsection{%s}" . "\\subsection*{%s}")
                  ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))))


(provide 'org-config)

;;; org-config.el ends here

