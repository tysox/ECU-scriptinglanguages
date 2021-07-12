# My attempt at a ((very) slightly) more complex script

## Background:

I have several physical HDD used across two OS: Pop!_OS (Linux - primary) and Windows 10. All my personal data is on one physical drive, and I use an open-source, cross platform, program called VeraCrypt to encrypt this drive. The issue I was having was that, by default, VeraCrypt would mount the drive as read-only, and this prevented me from using system-level programs such as a P2P syncing program I use, or, more presently, <b>git</b>.

By doing a bit of web research, along with:
<pre>
veracrypt --help
mount --help
</pre>
I was able to determine that what I needed to do was to first decrypt the drive <i>without mounting it</i>. Then, mount it with read write access.

This could be achieved with two lines of code:

<pre>
veracrypt --filesystem=none /dev/sdb
</pre>
This first line decrypts the drive (after asking for and receiving the correct password, which still appears on screen as a prompt).
<pre>
sudo mount -o umask=000 /dev/mapper/veracrypt1 /home/user/veracrypt1
</pre>
This second line tell the system to mount the drive with the option (-o) of "umask=000" (i.e. full access) from the first path to the second path (note, I've replaced my username with "user").

This seemed easy enough! I made a bash script with my two lines of code:
* [veracrypt_mount.sh](https://github.com/tysox/ECU-scriptinglanguages/blob/main/portfolio/week1/veracrypt_mount.sh)

I then added my script to the list of startup applications and restarted the computer to test it out.

## Issue:
My script didn't work. Initially, at least...

The problem was in the second line:
<pre>
<b>sudo</b> mount -o umask=000 /dev/mapper/veracrypt1 /home/user/veracrypt1
</pre>
"sudo" require an admin password to be entered, and if I wanted this script to run automatically at boot, I wouldn't have a terminal open to enter the admin password.
(to clarify, the first line would open a GUI prompt to enter the password to decrypt the drive, but the second line of code, which required the system admin password, would then not execute properly.)

After a bit more research, I learnt that you could create exceptions for sudo commands that wouldn't require a password.
I created and edited a file in /etc/sudoers.d/ using the following commands:
<pre>
touch veracrypt1
sudo visudo -f veracrypt1
</pre>
and adding the line:
<pre>
user host = (root) NOPASSWD: /path/to/file
</pre>

To fast forward a bit, this <i>did</i> work, but only after I realised I needed to add "sudo" to the startup command.

<b>SUCCESS!!</b>

## Potential Security Issue
Now I had a working script that would execute fully and mount my drive where I wanted it, with the permissions I wanted. But there was one aspect I wasn't comfortable with: my custom script was located in my home directory. This mean that if someone were to gain access to my computer, they could just modify that script any nothing would stop them.

So the last step I did was to move the script to a location that required root access to edit: /usr/local/bin

Then I just modified the startup command, and /etc/sudoers.d/veracrypt1 to the new location, restarted to test, and everything worked perfectly!

I was now satisfied that I wasn't compromising any security with this script, but it saved my additional manual configuration during login, and allowed me full access to my data, including running system-level applications such as rslsync and, more importantly for this course, <b>git</b>.
