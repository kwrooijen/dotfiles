(defun load-haskell-workgroups ()
  (interactive)
  (setq b (current-buffer))
  (message "%s" b)
  (wg-load "~/.emacs.d/workgroups/Haskell")
  (switch-to-buffer b))

(defun load-dynamic-workgroups ()
  (interactive)
  (setq b (current-buffer))
  (message "%s" b)
  (wg-load "~/.emacs.d/workgroups/Haskell")
  (wg-switch-to-index-1)
  (switch-to-buffer b))

(defun ido-find-file-pane-3 ()
  "Open file in panel 3"
  (interactive)
  (select-window-3)
  (ido-find-file))

(defun delete-trailing-whitespace-and-save ()
  "Deletes trailing whitespace and saves"
  (interactive)
  (delete-trailing-whitespace)
  (save-buffer))

(defun zsh (buffer-name)
  "Start a terminal and rename buffer."
  (interactive "sbuffer name: ")
  (shell)
  (rename-buffer (format "%s%s" "$" buffer-name) t))

(defun zsht (buffer-name)
  "Start a terminal and rename buffer."
  (interactive "sbuffer name: ")
  (term "/bin/zsh")
  (rename-buffer (format "%s%s" "$" buffer-name) t))

(defun get-current-buffer-major-mode ()
  (interactive)
  (message "%s" major-mode))

(defun hoogle-search (query)
  "Search with hoogle commandline"
  (interactive "sHoogle query: ")
  (if (get-buffer "*Hoogle*")
      (kill-buffer "*Hoogle*"))
  ; get the version of hoogle so I don't have to manually adjust it for each update
  (shell-command (format "version=`hoogle --version | head -n 1 | awk '{print $2}' | cut -c 2- | rev | cut -c 2- | rev`;
                          data=\"/databases\";
                          two=$version$data;
                          hoogle \"%s\" --data=$HOME/.lazyVault/sandboxes/hoogle/cabal/share/hoogle-$two" query))
  (switch-to-buffer "*Shell Command Output*")
  (rename-buffer "*Hoogle*")
  (haskell-mode)
  (linum-mode 0)
  (previous-buffer)
)

(defun erlang-get-error ()
  (interactive)
  (shell-command (format "~/.emacs.d/plugins/erlangscript %s" buffer-file-name))
)


(defun elixir-keys-hook ()
  (local-set-key (kbd "C-c C-l") (lambda()
                                   (interactive)
                                   (elixir-mode-compile-file)
                                   (elixir-mode-iex)))
)

(defun run-haskell-test ()
  (interactive)
  (async-shell-command "~/.emacs.d/scripts/cabal-test")
)

(defun underscores-to-camel-case (str)
  "Converts STR, which is a word using underscores, to camel case."
  (interactive "S")
  (apply 'concat (mapcar 'capitalize (split-string str "_"))))



; cmus functions

(defun cmus-pause ()
  (interactive)
  (shell-command (format "cmus-remote --pause"))
)

(defun cmus-volume-down ()
  (interactive)
  (shell-command (format "cmus-remote --volume -10%"))
)

(defun cmus-volume-up ()
  (interactive)
  (shell-command (format "cmus-remote --volume +10%"))
)

(defun cmus-next ()
  (interactive)
  (shell-command (format "cmus-remote --next"))
)
(defun cmus-previous ()
  (interactive)
  (shell-command (format "cmus-remote --prev"))
)

(defun ca-with-comment (str)
  (format "%s%s%s" comment-start str comment-end))

(provide 'my-functions)
