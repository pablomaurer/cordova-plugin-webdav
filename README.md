# cordova-plugin-webdav
Sync files with webdav server

I wanted to implement a sync method using webdav, but:

1. I dont like to parse xml
2. propfind does not return lastmodified on webdav instead lastmodified of file. (after each upload an additional request to change lastmodified, to prevent it gets downloaded again on the next synchronization.)
3. Since this plugin is for mobile sync data usage matters. webdav requests are huge, so I bet using the plugin [cordova-plugin-file-sync](https://github.com/mnewmedia/cordova-plugin-file-sync) is a lot faster.

I May continue developement, if i got nothing else todo. Else feel free to continue and send PR =)