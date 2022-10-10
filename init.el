;; Esta versi'on de Emacs la obtuve de
;; http://vgoulet.act.ulaval.ca/en/emacs/mac/
;; donde podr'e bajar las versiones actualizadas en el futuro.

(unless (server-running-p)
  (server-start))

;; Configure before loading org-mode (package-initialize)
(package-initialize)
(setq debug-on-error t)

(org-babel-load-file (expand-file-name "~/.emacs.d/org-init.org"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auth-source-save-behavior nil)
 '(auto-save-file-name-transforms '((".*" "~/.emacs.d/autosaves/\\1" t)))
 '(bib-file "~//Library/texmf/bibtex/bib/vib-2.bib")
 '(blink-cursor-mode t)
 '(calendar-christian-all-holidays-flag t)
 '(calendar-islamic-all-holidays-flag t)
 '(calendar-view-holidays-initially-flag t)
 '(custom-enabled-themes '(adwaita))
 '(custom-safe-themes
   '("06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "7153b82e50b6f7452b4519097f880d968a6eaf6f6ef38cc45a144958e553fbc6" "a0feb1322de9e26a4d209d1cfa236deaf64662bb604fa513cca6a057ddf0ef64" default))
 '(ebib-citation-commands
   '((latex-mode
      (("bibentry" "\\bibentry{%K}")
       ("cite" "\\cite%<[%A]%>[%A]{%(%K%,)}")
       ("paren" "\\parencite%<[%A]%>[%A]{%(%K%,)}")
       ("foot" "\\footcite%<[%A]%>[%A]{%(%K%,)}")
       ("text" "\\textcite%<[%A]%>[%A]{%(%K%,)}")
       ("smart" "\\smartcite%<[%A]%>[%A]{%(%K%,)}")
       ("super" "\\supercite{%K}")
       ("auto" "\\autocite%<[%A]%>[%A]{%(%K%,)}")
       ("cites" "\\cites%<(%A)%>(%A)%(%<[%A]%>[%A]{%K}%)")
       ("parens" "\\parencites%<(%A)%>(%A)%(%<[%A]%>[%A]{%K}%)")
       ("foots" "\\footcites%<(%A)%>(%A)%(%<[%A]%>[%A]{%K}%)")
       ("texts" "\\textcites%<(%A)%>(%A)%(%<[%A]%>[%A]{%K}%)")
       ("smarts" "\\smartcites%<(%A)%>(%A)%(%<[%A]%>[%A]{%K}%)")
       ("supers" "\\supercites%<(%A)%>(%A)%(%<[%A]%>[%A]{%K}%)")
       ("autos" "\\autoscites%<(%A)%>(%A)%(%<[%A]%>[%A]{%K}%)")
       ("author" "\\citeauthor%<[%A]%>[%A]{%(%K%,)}")
       ("title" "\\citetitle%<[%A]%>[%A]{%(%K%,)}")
       ("year" "\\citeyear%<[%A]%>[%A][%A]{%K}")
       ("date" "\\citedate%<[%A]%>[%A]{%(%K%,)}")
       ("full" "\\fullcite%<[%A]%>[%A]{%(%K%,)}")))
     (org-mode
      (("ebib" "[[ebib:%K][%D]]")))
     (markdown-mode
      (("text" "@%K%< [%A]%>")
       ("paren" "[%(%<%A %>@%K%<, %A%>%; )]")
       ("year" "[-@%K%< %A%>]")))))
 '(epg-gpg-program "/usr/local/bin/gpg2")
 '(holiday-islamic-holidays t)
 '(holiday-local-holidays t)
 '(ido-enable-flex-matching t)
 '(ido-mode 'both nil (ido))
 '(newsticker-url-list
   '(("LeMonde ProcheOrient" "https://www.lemonde.fr/proche-orient/rss_full.xml" nil 86400 nil)
     ("Monde La Une" "https://www.lemonde.fr/rss/une.xml" nil 86400 nil)
     ("Democracy Now" "https://www.democracynow.org/democracynow.rss" nil 86400 nil)
     ("NYT Top Stories" "https://rss.nytimes.com/services/xml/rss/nyt/HomePage.xml" nil 86400 nil)
     ("al-bawaba" "https://www.albawaba.com/rss/news" nil 86400 nil)
     ("MEI" "https://www.mei.edu/rss.xml" nil 86400 nil)
     ("Egyptian Street" "https://egyptianstreets.com/feed" nil 86400 nil)
     ("LSE ME" "https://blogs.lse.ac.uk/mec/feed/" nil 86400 nil)
     ("al-Monitor" "http://www.al-monitor.com/rss" nil nil nil)
     ("NYT ME" "https://rss.nytimes.com/services/xml/rss/nyt/MiddleEast.xml" nil 86400 nil)
     ("FP feed" "https://foreignpolicy.com/feed/" nil 86400 nil)
     ("BBC World" "http://feeds.bbci.co.uk/news/world/rss.xml" nil nil nil)
     ("Al Jazeera Eng" "http://www.aljazeera.com/xml/rss/all.xml" nil 86400 nil)
     ("Defence blog borrar?" "http://defence-blog.com/feed" nil 86400 nil)
     ("CNN" "http://rss.cnn.com/rss/edition_world.rss" nil 86400 nil)
     ("The Guardian" "https://www.theguardian.com/world/rss" nil 86400 nil)
     ("WashPost" "http://feeds.washingtonpost.com/rss/world" nil 86400 nil)
     ("RT" "https://www.rt.com/rss/news/" nil nil nil)
     ("The Guardian" "https://www.theguardian.com/world/rss" nil 86400 nil)
     ("La Jornada" "https://www.jornada.unam.mx/rss/edicion.xml" nil 86400 nil)
     ("Proceso" "https://www.proceso.com.mx/feed" nil 86400 nil)
     ("Sin embargo" "https://www.sinembargo.mx/feed" nil 86400 nil)
     ("Reforma" "https://www.reforma.com/rss/portada.xml" nil nil nil)
     ("The Intercept" "https://theintercept.com/feeds/" nil nil nil)
     ("The Independent" "http://www.independent.co.uk/news/world/rss" nil nil nil)
     ("ICG MOAN" "https://www.crisisgroup.org/rss/middle-east-north-africa" nil nil nil)
     ("La Jor Mundo" "https://www.jornada.com.mx/rss/mundo.xml" nil nil nil)
     ("La Jor Pol" "https://www.jornada.com.mx/rss/politica.xml" nil nil nil)))
 '(org-agenda-show-all-dates t)
 '(org-agenda-skip-deadline-if-done t)
 '(org-agenda-span 30)
 '(org-agenda-start-on-weekday nil)
 '(org-directory "~/org")
 '(org-file-apps
   '(("\\.pdf\\'" . emacs)
     (auto-mode . emacs)
     ("\\.mm\\'" . default)
     ("\\.x?html?\\'" . default)))
 '(org-reverse-note-order t)
 '(package-selected-packages
   '(spacemacs-theme coin-ticker ebib org-ref sudoku muban org-pdftools org-noter ereader use-package org-mime let-alist alect-themes helm babel))
 '(pdf-tools-handle-upgrades nil)
 '(pdf-view-resize-factor 1.1)
 '(pdf-view-use-scaling t)
 '(safe-local-variable-values
   '((eval set-input-method 'latin-1-prefix)
     (TeX-engine . pdflatex%xetex)))
 '(shr-max-image-proportion 0.7)
 '(warning-suppress-types '((files))))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;            Para package
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun package ()
  "Carga el paquete 'package'. Tambien se puede cargar con C-c Cp"
  (interactive)
  (load-file 'package)
  (unless package-archive-contents ;; Refrech packages descriptions
    (package-refresh-contents))
  (setq package-load-list '(all))  ;; List of packages to load
  )

(if (fboundp 'package-archives)
    (add-to-list 'package-archives
		 '("marmalade" . "http://marmalade-repo.org/packages/") t)
  )

(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
		    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
  (add-to-list 'package-archives (cons "melpa" url) t))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

