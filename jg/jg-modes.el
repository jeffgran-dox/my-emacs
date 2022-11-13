(require 'unicode-fonts)
(unicode-fonts-setup)

(require 'tramp)
(setq tramp-default-method "ssh") ; default is "scp"

(add-to-list 'auto-mode-alist '("\\.el" . emacs-lisp-mode))
(add-to-list 'auto-mode-alist '("Cask" . emacs-lisp-mode))
(add-hook 'emacs-lisp-mode-hook #'(lambda ()
                                    (paredit-mode t)
                                    ))

(cua-mode -1)
;; save my place in each file
(save-place-mode t)


(customize-set-variable 'persp-show-modestring 'header)
(projectile-mode +1)
(setq projectile-project-search-path '("~/dev/" "~/dox/" "~/dox/gems"))
(require 'perspective)
(setq persp-suppress-no-prefix-key-warning t)
(persp-mode)
(require 'persp-projectile)
(setq projectile-switch-project-action 'projectile-run-shell)
(add-hook 'kill-emacs-hook #'persp-state-save)
(setq persp-modestring-short nil)

(require 'avy)

(require 'undo-tree)
;; i stole this from the undo-tree code to override it because its "heuristic"
;; to determine whether to *actually* enable global undo-tree-mode is wrong,
;; and there is no variable/mechanism to stop this behavior.
;; (define-globalized-minor-mode global-undo-tree-mode
;;   undo-tree-mode turn-on-undo-tree-mode)
(define-globalized-minor-mode jg-global-undo-tree-mode
  undo-tree-mode undo-tree-mode)
(jg-global-undo-tree-mode)
(setq undo-tree-auto-save-history nil)

(require 'ag)
(setq ag-group-matches nil)
(setq ag-highlight-search t)
(customize-set-variable 'ag-arguments '("-W" "200"
                                        "--line-number"
                                        "--smart-case"
                                        "--nogroup"
                                        "--column"
                                        "--stats"
                                        "--ignore" "node_modules"
                                        "--ignore" "*.js.map"
                                        "--ignore" "*.min.js"
                                        "--hidden"
                                        "--"
                                        ))



(multiple-cursors-mode)
(delete-selection-mode)



(require 'jg-paredit)

(require 'smartparens-config)
(smartparens-global-mode t)
(show-smartparens-global-mode t)
(setq sp-highlight-pair-overlay nil)

(require 'jg-quicknav)

(require 'jg-switch-buffer)

(require 'view)

(global-subword-mode 1)


(require 'doom-modeline)
(setq doom-modeline-height 16)
;;(setq doom-modeline-persp-name nil)
(doom-modeline-mode +1)
(setq global-mode-string (delete '(:eval (persp-mode-line)) global-mode-string))

(require 'magit)
(with-eval-after-load 'magit
  (require 'forge))
(setq auth-sources '("~/.authinfo"))


(column-number-mode 1)
(size-indication-mode 1)


;; stolen from ruby-mode to make expand-region work with enhanced ruby mode
(defvar ruby-block-end-re "\\<end\\>")
(defvar ruby-block-beg-keywords
  '("class" "module" "def" "if" "unless" "case" "while" "until" "for" "begin" "do")
  "Keywords at the beginning of blocks.")
(defvar ruby-block-beg-re
  (regexp-opt ruby-block-beg-keywords)
  "Regexp to match the beginning of blocks.")
(require 'expand-region)
;; (require 'ruby-mode)
;; (setq ruby-insert-encoding-magic-comment nil)
;; (setq ruby-use-smie nil)
;; (setq ruby-deep-indent-paren nil)
;; (setq ruby-deep-indent-paren-style 'space)
;; (setq ruby-align-to-stmt-keywords nil)
;; (setq ruby-indent-level 2)


(require 'enh-ruby-mode)
(add-hook 'enh-ruby-mode-hook 'erm-define-faces)


(setq enh-ruby-program "~/.rbenv/shims/ruby") ; so that still works if ruby points to ruby1.8 or jruby
(setq ruby-insert-encoding-magic-comment nil) ; for ruby-mode
(setq enh-ruby-add-encoding-comment-on-save nil) ; for enh-ruby-mode


(require 'lsp-mode)
(setq lsp-keymap-prefix "H-l")
(define-key lsp-mode-map (kbd "H-l") lsp-command-map)
(setq lsp-headerline-breadcrumb-enable nil)


;; (require 'lsp-sourcekit)
;; ;;(setenv "SOURCEKIT_TOOLCHAIN_PATH" "/Library/Developer/Toolchains/swift-DEVELOPMENT-SNAPSHOT-2018-11-01-a.xctoolchain")
;; (setq lsp-sourcekit-executable (expand-file-name "/Users/jgran/dev/sourcekit-lsp/.build/debug/sourcekit-lsp"))

;; (use-package swift-mode
;;   :hook (swift-mode . (lambda () (lsp))))


;; Markdown support
;; (autoload 'markdown-mode "markdown-mode.el"
;;   "Major mode for editing Markdown files" t)
;; (add-to-list 'auto-mode-alist '("\\.text$" . markdown-mode))
;; (add-to-list 'auto-mode-alist '("\\.txt$" . markdown-mode))
;; (add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
;; (add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))
(require 'markdown-mode)
(require 'poly-markdown)

;; use web mode for html snippets inside markdown mode.
;; example:
;; ## Markdown header
;; <>
;; <div> some html code </div>
;; </>
;; (define-innermode poly-markdown-web-mode-innermode poly-markdown-root-innermode
;;   :mode 'web-mode
;;   ;; :head-matcher (cons "^<>$" 1)
;;   ;; :tail-matcher (cons "^</>$" 1)
;;   :head-matcher "^###"
;;   :tail-matcher "^---"
;;   )
(define-innermode poly-markdown-web-innermode
  :mode 'web-mode
  :head-matcher "^<!-- html -->$"
  :tail-matcher "^<!-- /html -->$"
  :head-mode 'host
  :tail-mode 'host)

(define-polymode poly-markdown-mode
  :hostmode 'poly-markdown-hostmode
  :innermodes '(poly-markdown-fenced-code-innermode
                ;; poly-markdown-inline-code-innermode
                poly-markdown-web-innermode
                poly-markdown-displayed-math-innermode
                poly-markdown-inline-math-innermode
                poly-markdown-yaml-metadata-innermode))


;; php mode
(require 'php-mode)


;; js mode
(setq js-indent-level 2)
(setq js2-basic-offset 2)
(setq sgml-basic-offset 2)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))

(add-to-list 'auto-mode-alist '("\\.conkerorrc$" . web-mode))
(add-to-list 'interpreter-mode-alist '("node" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx?" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\.erb$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\.eex$" . web-mode))


;; set to jsx mode by default in web-mode
(add-hook 'web-mode-hook
          (lambda ()
            (if (equal web-mode-content-type "javascript")
                (web-mode-set-content-type "jsx")
              (message "now set to: %s" web-mode-content-type))))

;; another thing to try...
;; (setq web-mode-content-types-alist
;;   '(("jsx" . "\\.js[x]?\\'")))

;; (web-mode-set-content-type "jsx") ; to force jsx mode

(add-hook 'web-mode-hook
          #'(lambda() (flycheck-mode)))


;; adjust indents for web-mode to 2 spaces
(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)
(setq web-mode-code-indent-offset 2)
(setq web-mode-attr-indent-offset 2)
(setq web-mode-enable-auto-indentation nil)

(eval-after-load 'web-mode #'(lambda ()
                               (define-key web-mode-map (kbd "M-;") 'demi-brolin)))

;;(add-to-list 'auto-mode-alist '("\\.tsx?$" . typescript-mode))
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))
(add-hook 'typescript-mode-hook #'setup-tide-mode)


(require 'flycheck)

(setq-default flycheck-temp-prefix ".flycheck")

;; add web-mode to the list of valid modes that these flycheck checkers can run in
(flycheck-add-mode 'javascript-eslint 'web-mode)
(flycheck-add-mode 'javascript-eslint 'typescript-mode)


;; coffeescript mode
(add-to-list 'load-path "~/.emacs.d/coffee-mode")
(require 'coffee-mode)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(defun coffee-custom ()
  "coffee-mode-hook"
  (set (make-local-variable 'tab-width) 2)
  (set (make-local-variable 'coffee-cleanup-whitespace) nil)
  )
(add-hook 'coffee-mode-hook
          #'(lambda() (coffee-custom)))

(customize-set-variable 'coffee-tab-width 2)

;;(add-to-list 'auto-mode-alist '("\\.scss$" . css-mode))
;;(autoload 'css-mode "css-mode" "CSS editing mode" t)
(require 'scss-mode)
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))



;;(require 'shell-script-mode)
(add-to-list 'auto-mode-alist '("\\.aliases$" . sh-mode))

;; terraform
(add-hook 'terraform-mode-hook #'terraform-format-on-save-mode)
(company-terraform-init)





(defun my-go-mode-hook ()
  (add-hook 'before-save-hook 'gofmt-before-save) ; gofmt before every save
  (setq gofmt-command "goimports")                ; gofmt uses invokes goimports
  ;; (if (not (string-match "go" compile-command))   ; set compile command default
  ;;     (set (make-local-variable 'compile-command)
  ;;          "go build -v && go test -v && go vet"))

  ;;(flycheck-mode)

  ;; Key bindings specific to go-mode
  ;; (local-set-key (kbd "M-.") 'godef-jump)         ; Go to definition
  ;; (local-set-key (kbd "M-*") 'pop-tag-mark)       ; Return from whence you came
  ;; (local-set-key (kbd "M-p") 'compile)            ; Invoke compiler
  ;; (local-set-key (kbd "M-P") 'recompile)          ; Redo most recent compile cmd
  ;; (local-set-key (kbd "M-]") 'next-error)         ; Go to next error (or msg)
  ;; (local-set-key (kbd "M-[") 'previous-error)     ; Go to previous error or msg

  )                         ; Enable auto-complete mode
(add-hook 'go-mode-hook 'my-go-mode-hook)
(add-hook 'go-mode-hook 'lsp-deferred)




(require 'which-key)
(which-key-mode)



;; make comments automatically go to multiple lines for long ones
(auto-fill-mode t)
(setq comment-auto-fill-only-comments t)



(add-hook 'ruby-mode-hook #'(lambda() (flycheck-mode))) ; for rubocop/ruby-mode
(add-hook 'enh-ruby-mode-hook #'(lambda() (flycheck-mode))) ; for rubocop/enh-ruby-mode
(add-hook 'enh-ruby-mode-hook 'lsp-deferred)
(add-hook 'enh-ruby-mode-hook 'yard-mode)
(add-hook 'enh-ruby-mode-hook 'eldoc-mode)
(setq flycheck-rubocoprc ".ruby-style.yml")

(add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.json_builder$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rb$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake\\'" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.builder\\'" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.json_builder\\'" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.jbuilder\\'" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile\\'" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec\\'" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru\\'" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile\\'" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Guardfile\\'" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile\\'" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Thorfile\\'" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Vagrantfile\\'" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Fastfile" . enh-ruby-mode))


(require 'xterm-color)
(setq comint-output-filter-functions
      (remove 'ansi-color-process-output comint-output-filter-functions))

(add-hook 'shell-mode-hook
          (lambda ()
            ;; Disable font-locking in this buffer to improve performance
            (font-lock-mode -1)
            ;; Prevent font-locking from being re-enabled in this buffer
            (make-local-variable 'font-lock-function)
            (setq font-lock-function (lambda (_) nil))
            (add-hook 'comint-preoutput-filter-functions 'xterm-color-filter nil t)))


(set-face-attribute 'comint-highlight-prompt nil
                    :inherit nil) ; don't override the prompt colors


;; use c++ for torquescript
(add-to-list 'auto-mode-alist '("\\.cs$" . c++-mode))
(setq c-basic-offset 4)

(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
              (ggtags-mode 1))))


;; Uniquify
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)



;; set exterior coding system so copy/paste of utf-8 stuff will work.
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(setenv "LANG" "en_US.UTF-8")


(require 'back-button)
(back-button-mode 1)



(setq-default save-interprogram-paste-before-kill t)
(setq-default indent-tabs-mode nil)

(require 'grep-buffers)

(require 'linum)
(global-linum-mode 1)

;; successor to smex. better M-x
(amx-mode)

;; minibuffer completions vertical display
(selectrum-mode)
(selectrum-prescient-mode) ; not just prefix matching in minibuffer completions
(hotfuzz-selectrum-mode)   ; fuzzy matching in completion
(setq prescient-filter-method '(literal fuzzy regexp initialism))
(setq prescient-use-char-folding t)
(setq completion-ignore-case t)

;;(setq selectrum-display-action '(display-buffer-in-tab)) ;; there are different options
(setq selectrum-display-action nil) ;; default


(require 'ws-butler)
(ws-butler-global-mode)

;; kill the buffer upon completion of the process.
(defun kill-buffer-on-exit-shell ()
  (let* ((buff (current-buffer))
         (proc (get-buffer-process buff)))
    (lexical-let ((buff buff))
      (set-process-sentinel proc (lambda (process event)
                                   (if (string= event "finished\n")
                                       (progn
                                         (kill-buffer buff))))))))

;; term-mode
;;(add-hook 'term-exec-hook 'kill-buffer-on-exit-shell)

;; shell mode
(add-hook 'shell-mode-hook 'kill-buffer-on-exit-shell)
(add-hook 'comint-output-filter-functions 'comint-truncate-buffer)


;; (defadvice display-message-or-buffer (before ansi-color activate)
;;   "Process ANSI color codes in shell output."
;;   (let ((buf (ad-get-arg 0)))
;;     (and (bufferp buf)
;;          (string= (buffer-name buf) "*Shell Command Output*")
;;          (with-current-buffer buf
;;            (ansi-color-apply-on-region (point-min) (point-max))))))



(require 'dired-subtree)
(setq diredp-hide-details-initially-flag nil)
(dired-filter-mode)


(recentf-mode 1)
(setq recentf-max-saved-items 100)


;;(require 'smooth-scroll)
;;(smooth-scroll-mode nil)
;;(setq smooth-scroll/vscroll-step-size 4)
(setq scroll-preserve-screen-position "yes")


;; even sweeter auto-complete!?
(global-company-mode)
(global-set-key (kbd "TAB") 'company-complete)
(setq company-idle-delay nil)
(setq company-dabbrev-downcase nil)
(setq company-tooltip-align-annotations t)



(yas-global-mode 1)
(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
(define-key yas-minor-mode-map (kbd "C-y") 'yas-expand)
(define-key yas-minor-mode-map (kbd "C-M-e") 'yas-expand)



(setq explicit-bash-args '("-c" "export EMACS=; stty echo; bash"))
(setq comint-process-echoes t)
;; ASIDE: if you call ssh from shell directly, add "-t" to explicit-ssh-args to enable terminal.

;; bash autocomplete working perfectly!
(with-eval-after-load 'shell
  (native-complete-setup-bash))
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-native-complete))

(setq tramp-shell-prompt-pattern ".*[#$%>)] *")



(setq tags-revert-without-query t)
(global-set-key (kbd "C-c C-t") 'ctags-create-or-update-tags-table)
(setq tags-case-fold-search nil)
;;notes
;; try (tags-search)
;; try (find-tag)


;; scad mode
(autoload 'scad-mode "scad-mode" "Major mode for editing SCAD code." t)
(add-to-list 'auto-mode-alist '("\\.scad$" . scad-mode))
(add-to-list 'auto-mode-alist '("\\.escad$" . scad-mode))



;;; org mode
(setq org-todo-keywords
      '((sequence "TODO" "WORKING" "DONE")))


(require 'keyfreq)
(keyfreq-mode 1)
(keyfreq-autosave-mode 1)
