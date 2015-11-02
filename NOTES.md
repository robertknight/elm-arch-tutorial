# Elm Tutorial Notes

1. Went to [elm-lang](elm-lang.org) hopepage, skimmed the initial
   instructions, went for the _Install_ option so I could develop
   in my preferred editor
1. Not obvious where to go next after that,
   went to the _Docs_ link at the top. Was expecting to find
   an 'Intro to Elm' guide. In lieu of that, picked the next
   most obvious thing which was walking through the
   _Quick Start_ links.
1. Skimmed the _For JS users_ documentation. OK, I can follow
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
   `HTML` import.
1. Went back to the documentation, skimmed the links and tried
   the [Community packages](package.elm-lang.org) link.
   The home page has an example for installing _elm-html_
   under _Reliable Versioning_. This sounds like the package I want,
   so I install it via `elm-package install evancz/elm-html`, guessing that
   I don't need to specify an exact version.
1. The initial install fails with a `FailedConnectionException` error.
   I guess that this could be related to the hotel WiFi connection that I'm using.
   I retry and the second attempt succeeds.
1. I retry `elm make hello.elm`, this time it tells me that I'm missing
   the `StartApp.Simple` module.
1. I search the [list of community packages](http://package.elm-lang.org/packages)
   and find `evancz/start-app` which I install via `elm-package`
1. I try `elm make hello.elm` again and this successfully compiles and produces
   `elm.js`.
1. I note depressingly that gzipped, minified version of `elm.js` weighs in
   at 45KB.
1. I'm not immediately sure what to do with `elm.js` - I skim through it
   briefly to see if it has what looks like an init function. That doesn't look
   to be the case.
1. Going back to the docs, I skim down the list and at the bottom a section
   labeled _Interop_ and follow the [HTML Embedding](http://elm-lang.org/guide/interop)
   link. This provides me with instructions to use `Elm.embed()` or `Elm.fullscreen()`
   which I add to a trivial `index.html` page after a `<script src="elm.js">` tag.
1. It works. Hurrah!
