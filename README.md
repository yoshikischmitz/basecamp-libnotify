basecamp-libnotify
==================

A ruby script to show new Basecamp activity through libnotify. Shows the profile image of the initiator of the notification as well as the title and summary of their activity.

In the config file, add on the first line your username, the seocnd line your password, on the third line your project's feedl url, and the fourth line your project's accesses.json url.

It's a very bare-bones script, and as you can tell the config schema can be improved. I plan to add a quick start-up command line interface to initialize the config file and let you chose what projects to receive notifications from, as well as a safer authentication scheme. There are some other issues like over-writing the profile-image file each time, but in it's current form it's definitely usable for the basic function of keeping up to date on your Basecamp.
