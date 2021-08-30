# send_newsletter reuses functions

In order to avoid code redundancy, make sure that `send_newsletter/3` calls the previously defined `open_log/1`, `close_log/1`, `read_emails/1` and `log_sent_email/2`.
