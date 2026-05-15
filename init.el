(setq auto-save-default nil
      auto-save-list-file-prefix nil
      make-backup-files nil
      inhibit-startup-screen t)

(xterm-mouse-mode 1)
(global-set-key (kbd "<wheel-up>") 'scroll-down-line)
(global-set-key (kbd "<wheel-down>") 'scroll-up-line)

(tab-bar-mode 1)

(cua-mode 1)
(global-set-key (kbd "C-s") 'save-buffer)
(global-set-key (kbd "C-o") 'find-file-other-tab)
(global-set-key (kbd "C-q") #'save-buffers-kill-terminal)



(defun my/close-buffers-of-current-tab ()
  "Kill all buffers displayed in the current tab."
  (interactive)
  (let* ((buffers (mapcar #'window-buffer (window-list))))
    (mapc #'kill-buffer buffers)))


(defun my/tab-bar-close-current-tab-kill-buffers (&optional p-tab-index)
  "Close the current tab and kill all buffers displayed in it."
  (when p-tab-index
    (tab-bar-select-tab p-tab-index))
  (my/close-buffers-of-current-tab)
)

(advice-add 'tab-bar-close-tab :before
            #'my/tab-bar-close-current-tab-kill-buffers)



(defun my/wsl-sync-kill-ring-to-clipboard (&rest _)
  (let ((text (current-kill 0)))
    (with-temp-buffer
      (insert text)
      (call-process-region (point-min) (point-max) "clip.exe"))))

(advice-add 'kill-new :after #'my/wsl-sync-kill-ring-to-clipboard)




(put 'dired-find-alternate-file 'disabled nil)

(with-eval-after-load 'dired
  (define-key dired-mode-map [mouse-1] #'dired-find-alternate-file)
  (define-key dired-mode-map [mouse-2] #'dired-find-alternate-file))

