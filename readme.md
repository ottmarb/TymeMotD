# MotD Generator for displaying custom system information

### Idea

This tool displays useful system information after logging into a Linux system (or Windows with TymeMotD.ps1), such as version, CPU information,
memory, disk information, number of updates, and many more useful things.


### Status

Production ready. Making sysadmins happy since 2014.

### Help

In case you find a bug or have a feature request, please make an issue on GitHub.

### Install Dependencies

##### Using yum

    sudo yum install bc sysstat jq moreutils

##### Using apt-get

    sudo apt-get install bc sysstat jq moreutils

### Usage Help

    Usage:
     TymeMotD [-v] -t <Theme Name>
     TymeMotD [-v] -C ['String']
     TymeMotD [-vhVs]

    Options:
       -h  | --help               			Shows this help and exits
       -v  | --verbose            			Verbose mode (shows messages)
       -V  | --version            			Shows version information and exits
       -t  | --theme <Theme Name> 			Shows Motd info on screen, based on the chosen theme
       -TF | --TemplateFile <Path to template> 	Shows theme based on json templates
       -C  | --colortest          			Prints color test to screen
       -M  | --colormap           			Prints color test to screen, with color numbers in it
       -S  | --save               			Saves data to /var/tmp/TymeMotD.json
      -HV  | --hideversion        			Hides version number
     -sru  | --skiprepoupdate     			Skip the repository package update (apt only)

    256-color themes:
     original
     modern
     gray
     orange
     invader

    16-color themes:
     red
     blue
     clean

    HTML theme:
     html

    Examples:
     TymeMotD -t original
     TymeMotD -t html > /tmp/motd.html
     TymeMotD -TF TymeMotD-theme-Elastic.json
     TymeMotD --theme Modern
     TymeMotD --colortest
     TymeMotD -M
     sudo TymeMotD --saveupdates

    Note:
     Some functionalities may require superuser privileges. Eg. check for updates.
     If you have problems, try something like:
     sudo TymeMotD -S

### System Install

You need to have `make` installed on the system, if you want to use the Makefile.

##### To install to /usr/local/bin/TymeMotD

```bash
sudo make install
```

With this you can probably run TymeMotD from anywhere in your system. If not, you need to add `/usr/local/bin` to your `$PATH` variable. To adjust the installation path, change the var `IDIR=/usr/local/bin` in the Makefile to the path you want.

##### To install bash auto completion support

```bash
sudo make bash_completion
```

With this you can use TAB to autocomplete parameters and options with TymeMotD.
Does not require the sudo make install above (system install), but requires the `bash-completion` package to be installed and working. Then you should logout-login or source the bash completion file, eg. `$ . /etc/bash_completion.d/TymeMotD`  

If you don't have root access, just install everything on your user's folder and source the file from your user's .profile file

### Crontab to get system information

Root privilege is required for this operation. Only `/etc/crontab` and the files in `/etc/cron.d/` have a username field.

The recommended way to generate /var/tmp/TymeMotD.json is by creating a separate cron file for TymeMotD like this:

```bash
sudo vim /etc/cron.d/TymeMotD
# TymeMotD system updates check (randomly execute between 0:00:00 and 5:59:59)
0 0 * * * root perl -e 'sleep int(rand(21600))' && /usr/local/bin/TymeMotD -S &>/dev/null
```

But you can also put it in root's crontab (without the user field):

```bash
sudo crontab -e
# TymeMotD system updates check (randomly execute between 0:00:00 and 5:59:59)
0 0 * * * perl -e 'sleep int(rand(21600))' && /usr/local/bin/TymeMotD -S &>/dev/null
```

### Apt configuration to update updates count

On systems with apt (Debian, Ubuntu, ...) add the following configuration lines to refresh the updates count after an apt action (install, remove, ...) was performed.

Create the apt configuration file `/etc/apt/apt.conf.d/15TymeMotD` containing:

```bash
DPkg::Post-Invoke {
  "if [ -x /usr/local/bin/TymeMotD ]; then echo -n 'Updating TymeMotD available updates count ... '; /usr/local/bin/TymeMotD -sru -S; echo ''; fi";
};
```

### Adding TymeMotD to run on login

Choosing where to run your script is kind of situational. Some files will only run on remote logins, other local logins, or even both. You should find out what suits best your needs on each case.

##### To add TymeMotD to a single user

Edit the user's `~/.profile` file, `~/.bash_profile` file, or the `~/.bashrc` file

```bash
nano ~/.profile
```

Add the TymeMotD call at the end of the file (choose your theme)

```bash
/usr/local/bin/TymeMotD -t red
```

##### To add TymeMotD to all users

You may call TymeMotD from a few different locations for running globally.  
Eg.`/etc/bash.bashrc`, `/etc/profile`.  

You may also create a initialization script `init.sh` which will call the `TymeMotD` script in `/etc/profile.d` when logging in. You can put whatever you like in this init.sh script. Everything in it will be executed at the moment someone logs in your system. Example:

```bash
#!/bin/bash

/usr/local/bin/TymeMotD --Theme Dev
```



### Copyright

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public
License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later
version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the
implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
details at <http://www.gnu.org/licenses/>.
