-*- coding: utf-8, tab-width: 2 -*-

reCaptcha Gallery Maker
=======================

Still too few webmasters, forum owners etc.
know that there are different difficulty levels of reCaptchas,
especially if they are used to surfing the web with low privacy settings
and thus see only the easiest level,
for when Google not only already knows you're a human,
but most likely also knows *which* exact human.

Having never seen the harder levels, it's hard for them to believe
they should consider alternate ways, of course. In an attempt to
ease creation of comparison charts, I built rCGM.


Features
--------
* ![☑][ck-hz] collect reCaptcha images
* ![◪][ck-pt] masquerade as different browsers
  * currently switched via code comments, but seems to not influence difficulty anyway.
* ![☑][ck-hz] compile collected images into one single HTML file
* ![☐][ck-no] compile collected images into one single image file


License
-------
[MIT](LICENSE.MIT.md)


  [ck-hz]: https://raw.githubusercontent.com/mk-pmb/misc/master/gfm-util/img/checkmark-has.gif# "☑"
  [ck-up]: https://raw.githubusercontent.com/mk-pmb/misc/master/gfm-util/img/checkmark-up.gif# "⟎"
  [ck-pt]: https://raw.githubusercontent.com/mk-pmb/misc/master/gfm-util/img/checkmark-partial.gif# "◪"
  [ck-no]: https://raw.githubusercontent.com/mk-pmb/misc/master/gfm-util/img/checkmark-minus.gif# "☐"
