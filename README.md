![Logo](https://github.com/Dax89/harbour-sailorgram/raw/master/harbour-sailorgram/res/telegram.png)
#Sailorgram

An unofficial Telegram Client for SailfishOS written in Qml using Silica graphics library.

Implemented Features (in 0.8x)
-----
- Basic Notifications
- Profile Management
- Group and Members Management (Create/Add/Invite/Delete)
- File Transfer (event from SD Card)
- Image/Audio/Video/Document Media Support
- Secret Chats (bugfixes needed)
- Bubbles and Quotes during conversations
- Emoji

Dependencies
-----
[Qt WebP Plugin](http://doc.qt.io/qt-5/qtimageformats-index.html) is needed in order to display Stickers:
- Plugin Repository: https://code.qt.io/cgit/qt/qtimageformats.git/tree/src/plugins/imageformats/webp

# How to build:

* Install sailfish dev tools
* pull this repo
`git clone <repo url>`
* pull the submodules
`git submodule update --init`
* Open the project in sailfish dev tools (qtcreator)
* Setup some project runtime
* Build
* Deploy to vm or to real jolla