# Elm Tutorial Notes

1. Went to [elm-lang](elm-lang.org) hopepage, skimmed the initial
   instructions, went for the _Install_ option so I could develop
   in my preferred editor (Atom).
1. Not obvious where to go next after that,
   went to the [Docs](http://elm-lang.org/docs) link at the top. Was expecting to find
   an 'Intro to Elm' guide. In lieu of that, picked the next
   most obvious thing which was walking through the
   _Quick Start_ links.
1. Skimmed the [For JS users](http://elm-lang.org/docs/from-javascript) documentation. OK, I can follow
   what is going on in the _Elm_ column. I have a feeling that
   important details are being glossed over quickly but that's fine.
1. Next link is [Make an HTML app](https://github.com/evancz/start-app)
   tutorial which bounces me off to a GitHub project page.
   Near the top is a block of code without much explanation
   and some instructions on how to run it in the online editor but
   nothing about how to run it locally.
1. Ran `elm make --help` and saw that it expected an input file
1. Tried adding the example code to `hello.elm` and ran
   `elm make hello.elm`. This produced an error about an unknown
   `HTML` import. I look in the directory where I ran `elm make`
   and see an `elm-package.json` file. That sounds similar to
   `package.json` so I presume I need to add dependencies to that file.
1. Went back to the documentation, skimmed the links and tried
   the [Community packages](package.elm-lang.org) link.
   That page has an example for installing [elm-html](https://github.com/evancz/elm-html)
   under _Reliable Versioning_. This sounds like the package I want,
   so I follow the example and install it via `elm-package install evancz/elm-html`, guessing that
   I don't need to specify an exact version. This turns out to be
   correct, `elm-package` tells me that it will add what is
   (presumably) the latest version of the dependency and I confirm.
1. The initial install fails with a `FailedConnectionException` error.
   I guess that this could be related to the hotel WiFi connection that I'm using.
   I retry and the second attempt succeeds.
1. I retry `elm make hello.elm`, this time it tells me that I'm missing
   the `StartApp.Simple` module.
1. I search the [list of community packages](http://package.elm-lang.org/packages)
   and find `evancz/start-app` which I install via `elm-package`
1. I try `elm make hello.elm` again and this successfully compiles and produces
   `elm.js`.
1. I note, depressingly, that the gzipped, minified version of `elm.js` weighs in
   at 45KB.
1. I'm not immediately sure what to do with `elm.js` - I skim through it
   briefly to see if it has what looks like an init function that I need to invoke but don't see it immediately at the top or bottom of the file.
1. Going back to the docs, I skim down the list and at the bottom a section
   labeled _Interop_ and follow the [HTML Embedding](http://elm-lang.org/guide/interop)
   link. This provides me with instructions to use `Elm.embed()` or `Elm.fullscreen()`
   which I add to a trivial `index.html` page after a `<script src="elm.js">` tag.
1. It works. Hurrah!
