#!/bin/bash
echo "This is only designed for R80.40"
fw ver | grep 'R80.40' -q
if [ $? == 0 ]; then
  echo "Running script"

cp /etc/security/pam_env.conf /etc/security/pam_env.conf_ORIGINAL
echo "BASH_LOGGER     DEFAULT=\"ON\"" >> /etc/security/pam_env.conf
echo "EDITED /etc/security/pam_env.conf"
diff /etc/security/pam_env.conf /etc/security/pam_env.conf_ORIGINAL


cp /etc/cli.sh /etc/cli.sh_ORIGINAL
sed -i '/^# Now launch the shell.*/i export BASH_LOGGER=\"ON\"' /etc/cli.sh
echo "EDITED /etc/cli.sh"
diff /etc/cli.sh /etc/cli.sh_ORIGINAL

cp /etc/profile /etc/profile_ORIGINAL
sed -i 's/LOGNAME=$USER/#LOGNAME=$USER/' /etc/profile
echo "EDITED /etc/profile"
diff /etc/profile /etc/profile_ORIGINAL

cp /etc/sudoers /etc/sudoers_ORIGINAL
cp /etc/sudoers /tmp/sudoers.bak
sed -i 's/Defaults    env_keep += \"LC_TIME LC_ALL LANGUAGE LINGUAS _XKB_CHARSET XAUTHORITY\"/Defaults    env_keep += \"LC_TIME LC_ALL LANGUAGE LINGUAS _XKB_CHARSET XAUTHORITY BASH_LOGGER LOGNAME\"/' /tmp/sudoers.bak
visudo -cf /tmp/sudoers.bak
if [ $? -eq 0 ]; then
  # Replace the sudoers file with the new only if syntax is correct.
  cp /tmp/sudoers.bak /etc/sudoers
else
  echo "Could not modify /etc/sudoers file. Please do this manually."
fi
echo "EDITED /etc/sudoers"
diff /etc/sudoers /etc/sudoers_ORIGINAL

cp /etc/bashrc /etc/bashrc_ORIGINAL
sed -i 's/export PS1=\x27\[Expert@$HOSTNAME:`cat \/proc\/self\/nsid`\]# \x27/export PS1=\x27\[Expert@$HOSTNAME:`echo -ne \"\"; cat \/proc\/self\/nsid`\]# \x27/' /etc/bashrc
echo "EDITED /etc/bashrc"
diff /etc/bashrc /etc/bashrc_ORIGINAL
echo "Successfully added bash logging to syslog"
fi

