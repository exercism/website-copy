# send newsletter does not call write

Make sure that `send_newsletter/3` does not call `File.write/2` directly, but rather uses `log_sent_email/2` to write to the log file.
