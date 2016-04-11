(require 'elnode)
(require 'doctor)

(defvar doctor-http-response)
(defun echo-answer (ans)
  (setq doctor-http-response ans))
(advice-add 'doctor-txtype :before 'echo-answer)

(defun talk-to-doctor (sentence)
  (progn
    (make-doctor-variables)
    (setq doctor-sent sentence)
    (setq doctor--bak doctor-sent)
    (doctor-doc)
    (format "%s" doctor-http-response)))

(defun doctor-handler (httpcon)
  (elnode-http-start httpcon
                     200
                     ;; 何がいいんでしょうねぇ…
                     '("Content-type" . "text/x-s-expression"))
  (elnode-http-return httpcon
                      (talk-to-doctor
                       ;; TODO GETパラメータを使う
                       (read "(foo)"))))

(elnode-start
 'doctor-handler
 :port (string-to-number (or (getenv "PORT") "8080"))
 :host "0.0.0.0")

(while t (accept-process-output nil 1))
