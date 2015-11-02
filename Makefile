all: elm.js

clean:
	rm *.js
	rm -rf elm-stuff

elm.js: hello.elm
	elm make hello.elm

