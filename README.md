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


Who else has those problems?
----------------------------
* [SX Meta: reCAPTCHA too difficult for humans](http://meta.stackexchange.com/questions/75965/)
  * [I am not a robot!](http://meta.stackexchange.com/questions/143455/)
  * [even with >500 reputation](http://meta.stackexchange.com/questions/81012/)
* [TOR Bridge Team](https://www.mail-archive.com/tor-bugs@lists.torproject.org/msg50058.html)
* [People on Google Groups](https://groups.google.com/forum/?_escaped_fragment_=topic/recaptcha/tZsgGPZ6l00)
* [dotTech's archaeologists](http://dottech.org/109832/the-impossible-recaptcha-comic/) ;-)
* [League of Legends forums users](http://forums.na.leagueoflegends.com/board/showthread.php?t=4144967)
* [People on BuzzFeed](http://www.buzzfeed.com/charliewarzel/meet-crapcha-the-impossible-captcha)
* [Audio version testers](http://www.90percentofeverything.com/2012/09/05/another-reason-not-to-use-recaptcha/)


License
-------
[MIT](LICENSE.MIT.md)


  [ck-hz]: https://raw.githubusercontent.com/mk-pmb/misc/master/gfm-util/img/checkmark-has.gif# "☑"
  [ck-up]: https://raw.githubusercontent.com/mk-pmb/misc/master/gfm-util/img/checkmark-up.gif# "⟎"
  [ck-pt]: https://raw.githubusercontent.com/mk-pmb/misc/master/gfm-util/img/checkmark-partial.gif# "◪"
  [ck-no]: https://raw.githubusercontent.com/mk-pmb/misc/master/gfm-util/img/checkmark-minus.gif# "☐"
