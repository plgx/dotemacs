;; Configure before loading org mode (package-initialize)  
(package-initialize)


;; Esta versi'on de Emacs la obtuve de
;; http://vgoulet.act.ulaval.ca/en/emacs/mac/
;; donde podr'e bajar las versiones actualizadas en el futuro.

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-file-name-transforms (quote ((".*" "~/.emacs.d/autosaves/\\1" t))))
 '(blink-cursor-mode t)
 '(calendar-christian-all-holidays-flag t)
 '(calendar-islamic-all-holidays-flag t)
 '(calendar-view-holidays-initially-flag t)
 '(holiday-islamic-holidays t)
 '(holiday-local-holidays t)
 '(ido-enable-flex-matching t)
 '(ido-mode (quote both) nil (ido))
 '(org-agenda-show-all-dates t)
 '(org-agenda-skip-deadline-if-done t)
 '(org-agenda-span 7)
 '(org-agenda-start-on-weekday nil)
 '(org-directory "~/Documents/org")
 '(org-reverse-note-order t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(autoload 'ebib "ebib" "Ebib, a BibTeX database manager." t)

;; autoevidente. el segundo renglon no se para que sirve

(prefer-coding-system 'utf-8)
(modify-coding-system-alist 'file "\\.sjs\\'" 'shift_jis)


(let ((default-directory "~/.emacs.d/lisp/"))
  (normal-top-level-add-subdirs-to-load-path))
(let ((default-directory "~/.emacs.d/site-lisp/"))
  (normal-top-level-add-subdirs-to-load-path))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                   ASPELL FLYSPELL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (require 'ispell)

;; ;; diccionario ortográfico
(setq ispell-program-name "aspell")
;; (setq ispell-extra-args '("--sug-mode=fast"))
(setq ispell-list-command "list")

;; lo que sigue es lo m'as 'util que he encontrado (de DiogoRamos en
;; http://www.emacswiki.org/emacs/FlySpell)
(let ((langs '("es" "en" "fr")))
  (setq lang-ring (make-ring (length langs)))
  (dolist (elem langs) (ring-insert lang-ring elem)))
(defun cycle-ispell-languages ()
  (interactive)
  (let ((lang (ring-ref lang-ring -1)))
    (ring-insert lang-ring lang)
    (ispell-change-dictionary lang)))
(global-set-key [M-f6] 'cycle-ispell-languages)



;; de ah'i mismo, pero autor an'onimo:
(global-set-key (kbd "C-<f6>") 
		'flyspell-check-previous-highlighted-word)
;; esta de arriba creo que funciona con C-. o algo as'i
(global-set-key (kbd "<f6>") 'ispell-word)
(defun flyspell-check-next-highlighted-word ()
  "Custom function to spell check next highlighted word"
  (interactive)
  (flyspell-goto-next-error)
  (ispell-word)
  )
(global-set-key (kbd "C-M-<f6>") 
		'flyspell-check-next-highlighted-word)

(global-set-key (kbd "C-S-<f6>") 
		'flyspell-buffer)

;; (global-set-key (kbd "<C-f6>") 'ispell-change-dictionary)




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                 Funciones encuentra mis archivos
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;; ALGUNOS archivos predefinidos como registros para abrirlos fcilmente.
;; es una especie de CDPATH

;; este en realidad est predefinido como funcin, que me parece ms
;; fcil, por ahora.


;; abre formato cartas
(defun carta ()
   (interactive)
   (find-file 
    "~/Documents/cartas/cartasTeX/cartaMembrete.tex")
)

(defun carta-Eng ()
   (interactive)
   (find-file 
    "~/Documents/cartas/cartasTeX/englMembrete.tex")
)


;; abre formato cartas
(defun carta-estilo ()
   (interactive)
   (find-file 
    "~/Library/texmf/tex/latex/wsumathletter.sty")
)


;; algunos archivos predefinidos como registros para abrirlos fcilmente.
;; predefinido como funcin, que me parece ms fcil, por ahora.
(defun vib ()
   (interactive)
   (find-file "~/Library/texmf/bibtex/bib/vib-2.bib")
)



;; abre el archivo .mailrc para editar (o consultar) mis aliases de
;; correo. Ser'ia bueno usar bbdb?
(defun mailrc ()
   (interactive)
   (find-file "~/.mailrc")
)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                   Save new macro
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Macro para guardar macros nuevos en este archivo

  (defun save-macro (name)                  
    "Save a macro. Take a name as argument
     and save the last defined macro under 
     this name at the end of your .emacs"
     (interactive "SName of the macro :")  ; ask for the name of the macro    
     (kmacro-name-last-macro name)         ; use this name for the macro    
     (find-file "~/.emacs.d/init.el")                ; open the .emacs file 
     (goto-char (point-max))               ; go to the end of the .emacs
     (newline)                             ; insert a newline
     (insert-kbd-macro name)               ; copy the macro 
     (newline)                             ; insert a newline
     (switch-to-buffer nil))               ; return to the initial buffer




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       Package mode - Elpa
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; make function? Tal vez deberia hacer una funci'on "package" que
;; carge 'package, para usarlo 'unicamente cuando quiera cargar m'as
;; paquetes, ya que de lo contrario tarda mucho el arranque de Emacs

;; ;; (NEW - emacs 24.x) elpa files for orgmode
(defun package ()
"Carga el paquete 'package'. Tambien se puede cargar con C-c Cp"
(interactive)
(load-file 'package)
(unless package-archive-contents    ;; Refrech the packages descriptions
  (package-refresh-contents))
(setq package-load-list '(all))     ;; List of packages to load
)
;;
;; include packages from the mermalade repository
;;
(if (fboundp 'package-archives)
    (add-to-list 'package-archives
		 '("marmalade" . "http://marmalade-repo.org/packages/") t)
  )

;;(unless (package-installed-p 'org)  ;; Make sure the Org package is
;;  (package-install 'org))           ;; installed, install it if not
;;(package-initialize)                ;; Initialize & Install Package
;; -*- include org package archives
;;(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)


;; for MELPA
;; (require 'package) ;; You might already have this line
(add-to-list 'package-archives
	     '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       ORG
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; incluir org-mode (version instalada en archivo org en las Aplications
;; activar org-mode 

;; (add-to-list 'load-path "/usr/share/emacs/site-lisp/org/lisp")
;; (add-to-list 'load-path "/usr/share/emacs/site-lisp/org/contrib/lisp") ;; estas dos l'ineas son de versiones anteriores

(add-to-list 'load-path "/Users/gc/.emacs.d/site-lisp")
(add-to-list 'load-path "/Users/gc/.emacs.d/lisp")

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map [C-c l] 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-default-notes-file "~/Documents/org/stage/notes.org");;for capture
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key (kbd "<f7> O") 'org-clock-out)
(global-set-key (kbd "<f7> I") 'org-clock-in)
(global-set-key (kbd "<f7> M") 'org-clock-menu)
(global-set-key (kbd "<f7> G") 'org-clock-goto)
(global-set-key (kbd "<f7> R") 'org-clock-report)


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
;;                               capture
;;

(setq org-capture-templates
      '(
	("t" "Todo" entry (file+headline "~/Documents/org/stage/notes.org" "Tasks")
             "* TODO %?\n %i\n %a\nEntered on %U\n")
        ("j" "Journal" entry (file+datetree "~/Documents/org/stage/JOURNAL.org")
             "* %?\nEntered on %U\n  %i\n  %a" :clock-in t :clock-resume t)
        ("w" "Work log" entry (file+datetree "~/Documents/org/stage/JOURNAL.org")
             "* %? :WORK:\nEntered on %U\n  %i\n  %a" :clock-in t :clock-resume t)
	("i" "Idea" entry (file+headline "~/Documents/org/stage/notes.org" "New Ideas")
	     "* %^{Title}\n %i\n %a")
	("p" "Phone call" entry (file+datetree "~/Documents/org/stage/JOURNAL.org")
       	     "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
        ("f" "Pendientes" entry (file+datetree "~/Documents/perso/otros/cuentosYcuentas/pendientes/pendientes.org")
             "* TODO %?\n %i\n %a\nEntered on %U\n")
))


;;
;;                       Diary and agenda in org
;;


;; ;; para que la agenda incluya lo escrito en el 'diary'
;; (setq org-agenda-include-diary t)


;; ;; (setq org-log-done t)

;; ;; poner el archivo 'diary' dentro del directorio de org ~/org/diary 
;; (setq diary-file "~/Documents/org/diary") 

;; (defun diary ()
;;    (interactive)
;;    (find-file "~/Documents/org/diary")
;; )


;; (add-hook 'org-agenda-cleanup-fancy-diary-hook
;; 	  (lambda ()
;; 	    (goto-char (point-min))
;; 	    (save-excursion
;; 	      (while (re-search-forward "^[a-z]" nil t)
;; 		(goto-char (match-beginning 0))
;; 		(insert "0:00-24:00 ")))
;; 	    (while (re-search-forward "^ [a-z]" nil t)
;; 	      (goto-char (match-beginning 0))
;; 	      (save-excursion
;; 		(re-search-backward "^[0-9]+:[0-9]+-[0-9]+:[0-9]+ " nil t))
;; 	      (insert (match-string 0)))))


;;
;;                         org agenda 
;;


(setq org-agenda-files (list "~/Documents/org/gtd.org"
			     "~/Documents/org/stage/TODO.org"
			     "~/Documents/org/stage/notes.org"
			     "~/Documents/org/stage/cursos.org"
			     "~/Documents/org/stage/ponencias.org"
			     "~/Documents/org/stage/publicaciones.org"
			     ))
(setq org-todo-keywords
      '((sequence "TODO(t)" "INPROGRESS(i)" "WAITING(w@/!)" "|" "DONE(d!/!)" "CANCELLED(c@/!)")
;;	(sequence "WAITING(w@/!)"  "OPEN(O@)" "|" "CANCELLED(c@/!)" "REJECTED(r)")
;;	(sequence "SOMEDAY(S!)" "|" "APPROVED(A@)" "EXPIRED(E@)")
;;	(sequence "TODO" "WAIT" "|" "DONE" "DELEGATED" "PUTOFF");;anterior
))

;; Las siguientes lineas definen la funcion M-x 'gtd que abre el
;; archivo gtd.org (sin tener que usar algun registro del tipo C-x r j
;; X, como hago para habrir preferences.el y otros archivos. Esta idea
;; viene de un blog sobre org que tengo en los bookmarks de Safari.



;;
;;                  org agenda a iCal
;;

;; Guardar calendario unificado. Luego hay que automatizar recarga por iCal
;; (setq org-combined-agenda-icalendar-file
;;     "~/Library/Calendars/OrgMode.ics")
;; (add-hook 'org-after-save-iCalendar-file-hook
;; 	  (lambda ()
;; 	    (shell-command
;; 	     "open ~/Library/Calendars/")))




;;
;;                       GTD
;;

(defun gtd ()
   (interactive)
   (find-file "~/Documents/org/gtd.org")
)
(setq initial-buffer-choice "~/Documents/org/gtd.org")

(defun init ()
   (interactive)
   (find-file "~/.emacs.d/init.el")
)

;;
;;                       Remember
;;


;; Las siguientes lineas permiten utilizar rembember.el en
;; org-mode. Esta idea viene del manual de org-mode.

;; (autoload 'remember "remember" nil t)
;; (setq org-directory "~/Documents/org/")
;; (define-key global-map "\C-cr" 'org-remember)
;; (require 'remember)

;; ;; Se supone que las lineas que siguen forman modelos de org files en
;; ;; remember.el. Esta idea viene del manual de org-mode.

(setq org-remember-templates '(
("Todo" ?t "* TODO %?\n %i\n %a" "~/Documents/org/stage/notes.org" "Tasks")
("Journal" ?j "* %U %?\n\n %i\n %a" "~/Documents/org/stage/JOURNAL.org")
("Idea" ?i "* %^{Title}\n %i\n %a" "~/Documents/org/stage/notes.org" "New Ideas")
))




;;
;;                      org export ox 
;;


;;(require 'ox-latex)
;; (add-to-list 'org-latex-classes
;;              '("beamer"
;;                "\\documentclass\[presentation\]\{beamer\}"
;;                ("\\section\{%s\}" . "\\section*\{%s\}")
;;                ("\\subsection\{%s\}" . "\\subsection*\{%s\}")
;;                ("\\subsubsection\{%s\}" . "\\subsubsection*\{%s\}")))

;; (require 'ox-freemind)
;; (require 'ox-texinfo)

;;
;;                      org misc
;;

;; ESTAS COSAS VIENEN DEL REPOSITORIO DE ORGMODE
;; (require 'org-mac-iCal)

;; (require 'org-annotate-file)
;; (global-set-key (kbd "C-c C-l") 'org-annotate-file) ; for example

;; (require 'org-passwords)
;; (setq org-passwords-file "~/documents/passwords.gpg")
;; (setq org-passwords-random-words-dictionary "/etc/dictionaries-common/words")



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

;; como no logro hacer funcionar el mobileorg, voy a intentar exportar
;; regularmente mis agendas a icalendar y subscribirme a ellas en iCal
;; para luego sincronizar con mi iPod. Suena un poco complejo, pero a
;; ver si funciona. Saqué unas cosas
;; de... http://orgmode.org/org.html#iCalendar-export

;; (setq org-icalendar-include-todo t)
;; ;; (setq org-export-exclude-category org-done-keywords)
;; (setq org-icalendar-use-deadline '(todo-start event-if-todo))
;; (setq org-icalendar-use-scheduled '(todo-start event-if-todo))
;; ;;    org-icalendar-alarm-time t
;; (setq org-icalendar-store-UID t)


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


;;; activate filter and call export function
;; (require 'ox-icalendar)
;; (defun org-mycal-export () 
;;   (let ((org-icalendar-verify-function 'org-mycal-export-limit))
;;     (org-icalendar-combine-agenda-files)))
;;    (org-export-icalendar-combine-agenda-files))
;; )

;; (require 'ox-freemind.el)


;; Add Mexican and other hollidays to the Calendar ;; NO FUNCION'O
;; (setq holiday-other-holidays '(
;; 			       (holiday-fixed 5 1 "Día del trabajo")
;;       (if (zerop (% displayed-year 4))
;;          (holiday-fixed 11
;;                 (calendar-extract-day
;;                   (calendar-gregorian-from-absolute
;;                     (1+ (calendar-dayname-on-or-before
;;                           1 (+ 6 (calendar-absolute-from-gregorian
;;                                    (list 11 1 displayed-year)))))))
;;                 "US Presidential Election"))
;;       ))
     

;; (setq holiday-general-holidays nil
;;       holiday-bahai-holidays nil
;;       holiday-local-holidays nil
;;       holiday-christian-holidays nil
;;       holiday-islamic-holidays nil
;;       holiday-hebrew-holidays nil
;;       holiday-oriental-holidays nil
;;       holiday-other-holidays nil)


;; ; Activate appointments so we get notifications
(appt-activate t)




(global-set-key (kbd "\C-ct b")
		(lambda ()
		  (interactive)
		  (insert 
"#+STARTUP: beamer overview hidestars indent

#+TITLE:    
#+SUBTITLE: 
#+AUTHOR:   
#+EMAIL:    
#+DATE:     
#+LaTeX_HEADER: %\\institute[CEAA-Colmex] {Centro de Estudios de Asia y África \\\\ El Colegio de México}
#+DESCRIPTION: 
#+KEYWORDS:  
#+LANGUAGE:  es
#+OPTIONS:   H:2 num:t toc:t \\n:nil @:t ::t |:t ^:t -:t f:t *:t <:t
#+OPTIONS:   TeX:t LaTeX:t skip:t d:nil todo:t pri:nil tags:not-in-toc
#+INFOJS_OPT: view:nil toc:t ltoc:t mouse:underline buttons:0 path:http://orgmode.org/org-info.js
#+EXPORT_SELECT_TAGS: export
#+EXPORT_EXCLUDE_TAGS: noexport
#+LINK_UP:   
#+LINK_HOME: 
#+LaTeX_CLASS: beamer
#+LaTeX_CLASS_OPTIONS: [notes,presentation]
#+LATEX_HEADER: \\setbeameroption{show notes}
#+BEAMER_FRAME_LEVEL: 2
#+BEAMER_THEME: Warsaw
#+BEAMER_COLOR_THEME: crane
#+COLUMNS: %40ITEM %10BEAMER_env(Env) %9BEAMER_envargs(Env Args) %4BEAMER_col(Col) %10BEAMER_extra(Extra)
#+LaTeX_HEADER: \\AtBeginSection[]{\\begin{frame}<beamer>\\frametitle{Tema}\\tableofcontents[currentsection]\\end{frame}}


* This is the first structural section
** Frame 1
#+Beamer: \\framesubtitle{A subtitle}
*** Thanks to Eric Fraga 				      :BMCOL:B_block:
         :PROPERTIES:
         :BEAMER_env: block
         :BEAMER_envargs: C[t]
         :BEAMER_col: 0.5
         :END:
         for the first viable beamer setup in Org
*** Thanks to everyone else 				      :BMCOL:B_block:
         :PROPERTIES:
         :BEAMER_col: 0.5
         :BEAMER_env: block
         :BEAMER_envargs: <2->
         :END:
         for contributing to the discussion

*** Some note                                                          :B_note:
    :PROPERTIES:
    :BEAMER_env: note
    :END:

This is a note.

- Stress this first.
- Then this.



** Frame 2 \\\\ where we will not use columns
*** Request 							    :B_block:
         Please test this stuff!
         :PROPERTIES:
         :BEAMER_env: block
         :END:
* This is the second
** Frame 3
#+Beamer: \\framesubtitle{A subtitle}
#+ATTR_LaTeX: width=\\textwidth
\[ \[\~/Documents/Directory/Image/IMAGE.jpg\] \]

https://github.com/fniessen/refcard-org-beamer

"
)))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                    Mis datos de base
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;
;; variables de arranque para definir datos basicos. Utilizadas por
;; varios subprogramas de Emacs, como por el cliente de correo o por
;; org.
;;

(setq user-full-name "Gilberto Conde"
;;      user-mail-address 
      mail-signature "\tGilberto Conde"
      major-mode 'text-mode)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                      MAIL - GNUS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;; Mail config
;; Preferencias para el envio de correo (necesitan las variables de
;; "arranque" siguientes si no se usa gnus)

;; (setq starttls-use-gnutls t)

;; (setq send-mail-function 'smtpmail-send-it
;;       message-send-mail-function 'smtpmail-send-it
;;       smtpmail-starttls-credentials
;;       '(("smtp.gmail.com" 587 nil nil))
;;       smtpmail-auth-credentials
;;       (expand-file-name "~/.authinfo")
;;       smtpmail-default-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-service 587
;;       smtpmail-debug-info t)
;; (require 'smtpmail)


;; Auto-wrap lines in mails
;; (defun fc-mail-fill-column ()
;;   (turn-on-auto-fill)
;;   (set-fill-column 66))
;; (add-hook 'mail-mode-hook 'fc-mail-fill-column)
;; (add-hook 'message-mode-hook 'fc-mail-fill-column)
;; (add-hook 'message-mode-hook (lambda () (auto-save-mode 0)))
;; (add-hook 'message-mode-hook (lambda () (flyspell-mode 1)))
;; (setq mail-user-agent 'gnus-user-agent)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                      Synonyms -desactivado
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;  Put this in your initialization file (~/.emacs): SYNONYMS NO ME
;; ACUERDO COMO FUNCIONA OCT 2011: ya revisé y lo que se necesita es
;; cargar los documentos mthesaur.txt y cache.txt cuando te los
;; pide. Sólo que es medio jodida la manera de cargarlos. Hay que
;; copiar hasta Aqua y luego usar autocompletion (a causa del escaped
;; space que se encuentra en el nombre del directorio). Se supone que
;; debe aceptar como default la palabra que está debajo del cursor o
;; seleccionada, pero no me lo hizo la última vez que intenté. SOLO
;; TENGO THESAURUS EN INGLES!!!!! Pero es útil.  ;; The file names are
;; absolute, not relative, locations ;; -
;; e.g. /foobar/mthesaur.txt.cache, not mthesaur.txt.cache (load-file
;; "~/Library/Preferences/Aquamacs Emacs/mthes10/mthesaur.txt")
;; (load-file "~/Library/Preferences/Aquamacs
;; Emacs/mthes10/cache.txt") (require 'synonyms)




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                      TeX - LaTeX - RefTeX
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; AUCTeX and RefTeX: Don’t forget to put something in your .emacs to
;; make RefTeX work properly with AUCTeX: (although this is already
;; loaded by the site-lisp or another file)

(setq TeX-auto-save t
      TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
;; (add-hook 'auto-fill-mode)
;; (add-hook 'LaTeX-mode-hook 'flyspell-mode) 
;;innecesario: puesto para todo texto abajo 
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
;; Set a default bibliography for AUCTeX (custom-set-variables
;;'(reftex-default-bibliography (quote
;;("~/Library/texmf/bibtex/bib/vib-2")))) (custom-set-faces)
(setq reftex-bibpath-environment-variables
                '("~/Library/texmf/bibtex/bib/"))



;; esto deber'ia abrir todos los buffers con el citado input-method:
;; (defadvice switch-to-buffer (after activate-input-method activate)
;;   (activate-input-method "spanish-prefix")) 


;; InfoLook. Da informacion para diversos major modes, incluyendo LatexMode
(require 'info-look)
    (info-lookup-add-help
     :mode 'latex-mode
     :regexp ".*"
     :parse-rule "\\\\?[a-zA-Z]+\\|\\\\[^a-zA-Z]"
     :doc-spec '(("(latex2e)Concept Index" )
                 ("(latex2e)Command Index")))



;; pone comillas de latex alrededor del texto seleccionado
(defadvice TeX-insert-quote (around wrap-region activate)
  (cond
   (mark-active
    (let ((skeleton-end-newline nil))
      (skeleton-insert `(nil ,TeX-open-quote _ ,TeX-close-quote) -1)))
   ((looking-at (regexp-opt (list TeX-open-quote TeX-close-quote)))
    (forward-char (length TeX-open-quote)))
   (t
    ad-do-it)))
(put 'TeX-insert-quote 'delete-selection nil)

(define-key global-map "\C-cq" 'TeX-insert-quote)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                  Texto en espanol español
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; algunas caracter'isticas para todos los text modes (flyspell on y
;; spanish prefix input method).
(add-hook 'text-mode-hook 
	  (lambda () "Defaults for text modes"
            ;; flyspell mode to spell check everywhere
            (flyspell-mode 1)
	    ;; spanish-prefix to always have it on
	    (activate-input-method "spanish-prefix")
	    ;; El diccionario está puesto automáticamente en 'espa~nol'
	    (setq ispell-dictionary "es"
		  ispell-silently-savep t ;; creo que esto hace que se
					  ;; grabe autom'aticamente el
					  ;; diccionario personal sin
					  ;; preguntar
		  )

))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;              CALCULADORA DE PAGOS DE UN CRÉDITO. 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; 
;; Funciona super bien. Quisiera que el message fuera copiado al kill
;; ring
;;

(defun loan-payment-calculator (amount rate years)
"Calculate what the payments for a loan of AMOUNT dollars when
annual percentage rate is RATE and the term of the loan is
YEARS years.  The RATE should expressed in terms of the percentage 
\(i.e. \'8.9\' instead of \'.089\'\).  The total amount of
interest charged over the life of the loan is also given."
  (interactive "nLoan Amount: \nnAPR: \nnTerm (years): ")
  (let ((payment (/ (* amount (/ rate 1200.00)) (- 1 (expt (+ 1 (/ rate 1200.00)) (* years -12.0))))))
	 (message "%s payments of $%.2f. Total interest $%.2f"
                  (* years 12) payment (- (* payment years 12) amount)))
)

(defalias 'loan 'loan-payment-calculator)


;;código para convertir texto marcado a texto/html usando markdown
(defun mimedown ()
  (interactive)
  (save-excursion
    (message-goto-body)
    (let* ((sig-point (save-excursion (message-goto-signature) (forward-line -1) (point)))
           (orig-txt (buffer-substring-no-properties (point) sig-point)))
      (shell-command-on-region (point) sig-point "Markdown.pl" nil t)
      (insert "<#multipart type=alternative>\n")
      (insert orig-txt)
      (insert "<#part type=text/html>\n")
;; esta parte (antes de cerrar comillas anteriores) parece inneceesaria:
;; < html>\n< head>\n< title> HTML version of email</title>\n</head>\n< body>
      (exchange-point-and-mark)
      (insert "<#/multipart>\n"))))
;; por lo tanto, ésta también es redundante:
;; \n</body>\n</html>\n
;; (después de abrir las comillas anteriores



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                  Pre'ambulos latex
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




(global-set-key (kbd "\C-ct o")
		(lambda () 
		  (interactive) 
		  (insert 
"#+STARTUP: overview hidestars indent

#+OPTIONS:   H:2 num:t toc:nil \\n:nil @:t ::t |:t ^:t -:t f:t *:t <:t
#+OPTIONS:   TeX:t LaTeX:t skip:t d:nil todo:t pri:nil tags:not-in-toc
#+LANGUAGE:  es
#+LaTeX_HEADER: \\usepackage[english,french,spanish]{babel}
#+LaTeX_HEADER: \\usepackage[doublespacing]{setspace}
#+LaTeX_HEADER: \\usepackage{natbib,bibentry} \\nobibliography*
#+LaTeX_HEADER: \\urlstyle{same}
#+LATEX_HEADER: \\newcommand{\\comment}[1]{}
#+LATEX_HEADER: \\setcitestyle{notesep={, }}%{: }
#+TITLE:  
#+DATE:     
#+AUTHOR:  





\\bibliographystyle{colef}
\\bibliography{vib-2,mios}

")))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                      Word Count
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;
;; count words word count
;;

(defun count-words (&optional begin end)
  "count words between BEGIN and END (region); if no region defined, count words in buffer"
  (interactive "r")
  (let ((b (if mark-active begin (point-min)))
	(e (if mark-active end (point-max))))
    (message "Word count: %s" (how-many "\\w+" b e))))

(defalias 'word-count 'count-words)

(defun latex-word-count ()
  (interactive)
  (shell-command (concat "texcount "
                         "-unicode "
			 "-inc "
                         (buffer-file-name))))

(add-hook 'LaTeX-mode-hook 
	  '(lambda () 
	     (local-set-key (kbd "\C-cw") 'latex-word-count)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                RECENT FILES list
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 (require 'recentf)
    (recentf-mode 1)
    (setq recentf-max-menu-items 25)
    (global-set-key "\C-x\ \C-r" 'recentf-open-files)


;; (add-to-list 'load-path "~/.emacs.d/site-lisp/color-theme/") ;; no funciona en Mountain Lion

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       TABBAR
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (require 'tabbar);;aquamacs-tabbar)
;; ; turn on the tabbar
;; (tabbar-mode t)
;; ; define all tabs to be one of 3 possible groups: “Emacs Buffer”, “Dired”,
;; ;“User Buffer”.

;; (defun tabbar-buffer-groups ()
;;   "Return the list of group names the current buffer belongs to.
;; This function is a custom function for tabbar-mode's tabbar-buffer-groups.
;; This function group all buffers into 3 groups:
;; Those Dired, those user buffer, and those emacs buffer.
;; Emacs buffer are those starting with “*”."
;;   (list
;;    (cond
;;     ((string-equal "*" (substring (buffer-name) 0 1))
;;      "Emacs Buffer"
;;      )
;;     ((eq major-mode 'dired-mode)
;;      "Dired"
;;      )
;;     (t
;;      "User Buffer"
;;      )
;;     ))) 

;; (setq tabbar-buffer-groups-function 'tabbar-buffer-groups)

;; (global-set-key [M-s-left] 'tabbar-backward)
;; (global-set-key [M-s-right] 'tabbar-forward)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                            MISC
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;
;; y para editarlo, ;; reload .emacs file
;;
(defun reload-dotemacs-file ()
  "reload your .emacs file"
  (interactive)
  (load-file "~/.emacs.d/init.el")
)


;; Save minibuffer history
(savehist-mode 1)

;;
;;                          GPG
;;

;; GPG EasyPG
(require 'epa-file)
;; (epa-file-enable)

;; GPG EasyPG in org-mode
(require 'org-crypt)
(org-crypt-use-before-save-magic)
(setq org-tags-exclude-from-inheritance (quote ("crypt")))
;; GPG key to use for encryption
;; Either the Key ID or set to nil to use symmetric encryption.
(setq org-crypt-key nil)


;;
;;                     Default frame size
;;


;; default frame size
(add-to-list 'default-frame-alist '(height . 48))
(add-to-list 'default-frame-alist '(width . 190))
;; you could also do it wit set-frame-height similarly to set frame
;; position


;;
;;                     What is this for? ;gc
;;


;; (if window-system
;;     (set-frame-position (selected-frame) 0 0))


;;
;;                     Default split frame 
;;


(split-window-right) ;; se puede definir dimensión relativa de los dos
		     ;; con argumento numérico como en el siguiente
		     ;; ejemplo (split-window-below 25). El ejemplo,
		     ;; por supuesto, se refiere a la divisi'on del
		     ;; frame horizontalmente
;; ;;
;; ;;  ver url's con Safari o el default browser del OS
;; ;;

(setq browse-url-browser-function 'eww-browse-url)

;;
;; fija la variable de la campana de alerta a un modo visible para no
;; molestar a los vecinos, como Clara, cuando duerme. De hecho a m'i
;; tambi'en me molesta.
;;
;; quiet, please! No dinging!
(setq visible-bell nil)
(setq ring-bell-function '(lambda ()
			    (load-theme 'tsdh-dark)
			    ))
;; (setq ring-bell-function '(lambda () (message "*beep*")))

;; gnus-harvest
;; (eval-after-load "gnus"
;;     '(progn (require 'gnus-harvest)
;;             (gnus-harvest-install 'message-x)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                            THEMES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; No funciona en Mountain Lion

(load-theme 'tsdh-dark)
;; (require 'color-theme)
;; (eval-after-load "color-theme"
;;   '(progn
;;      (color-theme-initialize)
;; ;;     (color-theme-aliceblue)
;; ))

;; (setq calendar-location-name "Tijuana, MX") 
;; (setq calendar-latitude 32.31)
;; (setq calendar-longitude -117.02)
;; ;; (setq calendar-location-name "Mexico, MX") 
;; ;; (setq calendar-latitude 19.5)
;; ;; (setq calendar-longitude -99.1)

;; ;; specify day and night color themes

;; (require 'theme-changer)
;; (change-theme 'color-theme-wheat 'color-theme-gnome2)
;; (add-to-list 'load-path "~/.emacs.d/site-lisp/theme-changer")


;; (put 'narrow-to-region 'disabled nil)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                    Autosaves and backups
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; from emacs wiki and 

(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '((".*" . "~/.emacs.d/backups/"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t       ; use versioned backups
) ;; el problema con esto es que me va a hacer backups multiples de todo

;; this can be done through customizing group: Backup


;; This comes from http://snarfed.org/gnu_emacs_backup_files
;; Put autosave files (ie #foo#) and backup files (ie foo~) in ~/.emacs.d/.


;; ver luego esta pagina
;; http://www.chemie.fu-berlin.de/chemnet/use/info/elisp/elisp_24.html



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       Eldoc - para Elisp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; A very simple but effective thing, eldoc-mode is a MinorMode which
;; shows you, in the echo area, the argument list of the function call
;; you are currently writing. Very handy. By NoahFriedman. Part of
;; Emacs.


(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                              Misc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; ;; server start para usar emacsclient cuando Emacs est'a funcionando no s'e de que sirve
;; (server-start)

;; ;; Hide Emacs bars forever (EmacsWiki)
;; ;; If you want to hide menu-bar, tool-bar, and scroll-bar forever, then use this code:

;; (menu-bar-mode -1)
;; (tool-bar-mode -1)
;; (scroll-bar-mode -1)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                    Ambientes entre comillas
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(add-hook 'text-mode-hook '(lambda () (local-set-key (kbd "C-M-2") (lambda () (interactive) (insert "``''") (backward-char 2)))))

(global-set-key (kbd "C-M-{") (lambda () (interactive) (insert "{}") (backward-char 1)))
(global-set-key (kbd "C-M-[") (lambda () (interactive) (insert "[ ] ") (backward-char 2)))
(global-set-key (kbd "C-M-]") (lambda () (interactive) (insert "[[][]]") (backward-char 4)))
(global-set-key (kbd "C-M-$") (lambda () (interactive) (insert "$$") (backward-char 1)))
(global-set-key (kbd "C-M-<") (lambda () (interactive) (insert "<>") (backward-char 1)))
(global-set-key (kbd "C-M-?") (lambda () (interactive) (insert "¿?") (backward-char 1)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                    TaskJuggler mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (require 'taskjuggler-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                         Abbrevs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; from http://www.emacswiki.org/emacs/AbbrevMode.  *Calling Abbrevs*
;; is as simple as doing ‘C-xaig’ (add inverse global) .  *Defining
;; Abbrevs* Type the word you want to use as expansion, and then type
;; ‘C-x a g’ and the abbreviation for it.  *Saving Abbrevs* Use ‘M-x
;; write-abbrev-file’ and just hit RET when asked for a filename.

(setq abbrev-file-name             ;; tell emacs where to read abbrev
      "~/.emacs.d/abbrev_defs")    ;; definitions from...

(setq save-abbrevs t)              ;; save abbrevs when files are saved
;; you will be asked before the abbreviations are saved

(setq-default abbrev-mode t)       ;; always on


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Macro para pasar columnas estados bancarios a columnas tbl orgmode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(fset 'columna-estado-cuenta
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([124 19 47 19 134217830 67108896 6 6 127 124 5 67108896 6 127 124 5 67108896 6 127 124 5 67108896 6 127 124 67108896 6 6 127 5 124 124 6] 0 "%d")) arg)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-hl-line-mode t)
(display-time-mode 1)
(require 'eww)
