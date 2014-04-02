basecamp-libnotify
==================

A ruby script to show new Basecamp activity through libnotify.

In the config file, add on the first line your username, the seocnd line your password, on the third line your project's feedl url, and the fourth line your project's accesses.json url.

It's a very bare-bones script, and as you can tell the config schema can be improved. I plan to add a quick start-up command line interface to initialize the config file and let you chose what projects to receive notifications from, as well as a safer authentication scheme. 
