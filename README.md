# ckp-audit-bash
Add Bash/Expert CLI logging to /var/log/messages or syslog
#### Add Check Point Bash commands to syslog logs
#### Export syslog to specific server


In case you need  add logging of Bash shell (Expert mode) commands to /var/log/messages file.

How to Run:

Open Smart Dashboard. Open GATEWAYS & SERVERS > Choose Scripts from Top Menu > Script Repository > New > Add a name for the script > Click Load from File.
Choose the R8040_audit_logging.sh file. 
In order to run the script pick the gateways and click Scripts > Script Repository > Pick the imported script and Run it


In order to also add the messages to a centralized log server such as "Splunk" or "Syslog-ng" also run the add_syslog_server.sh <IP>

Reference:
https://supportcenter.checkpoint.com/supportcenter/portal?eventSubmit_doGoviewsolutiondetails=&solutionid=sk99134&partition=Advanced&product=All
