# Meme Me
![Alt Text](https://github.com/Ramesh-P/meme-me/blob/master/Meme%20Me/Assets.xcassets/AppIcon.appiconset/Icon-60%403x.png)
## Overview
Meme Me is a meme generating app that enables a user to add a caption to a picture taken from their phone camera or selected from their photo album. After generating the meme, the user can share it with friends through Facebook, Twitter, message or email. Meme Me also temporarily stores sent memes which the user can browse in a table or a grid. User will also be able to edit the sent memes and share it with friends again. The complete project specification for Meme Me can be found [here](https://docs.google.com/document/d/1G2onkzN_weWmiYErhQJw1lB9-zxM-2TQ0N5bNMAaI7I/pub?embedded=true)
## Specification
Meme Me is built and tested for the following software versions:
* Xcode 8.1
* iOS 10.0 (Minimum)
* Swift 3.0.1
## Preview
![meme-me](https://cloud.githubusercontent.com/assets/25907551/24083975/d2399796-0cb7-11e7-8451-d2b70c64946d.gif)
## Features
Meme Me incorporates all the features stipulated by Udacity and extra credit and additional features as listed below.
### Extra Credit Features
Meme Me includes the following extra credit features:
* For maximum impact, meme text uses Impact font by default
* User can also choose between five different fonts for meme caption
* App allows the user to delete memes from both table and grid views
* User can edit an existing meme and share it with friends again
* App employs an exceptional graphic design and pleasurable user interface
### Additional Features
Meme Me is brilliantly designed and packed with the following additional features:
#### Add Meme View
* User can choose between five different colors for meme caption
* For any meme image size, the caption always fits within the image and never overflows
  * Meme caption readjusts itself to fit when the image orientation changes
* Only successfully shared memes are saved into the sent memes list
#### Edit Meme View
* Memes are presented for editing with the previously saved font and color choices
* When a meme is edited, the original meme is updated with new changes. No duplicates are created
#### Display Meme View
* User can add memes to favorites list
* User can share memes to more friends on a later time, without having to edit them first
  * When memes are re-shared without editing, sent memes list is not updated and no duplicates are created
#### Sent Memes (Table & Collection) Views
* Table view row and collection view cell sizes are proportionally adjusted to match the device orientation
* User can move and rearrange the memes on both table and grid views
* Deletes and moves are synchronized between table and grid views
## Authors
* [Ramesh Parthasarathy](mailto:msg.rameshp@gmail.com)
## License
Meme Me is licensed under [MIT License](https://github.com/Ramesh-P/meme-me/blob/master/LICENSE)
## Credits
Meme Me uses icons from:
<pre>http://www.flaticon.com</pre>
<pre>https://www.iconfinder.com</pre>
Attributions can be found on `Credits.rtf` and/or elsewhere within the code files
