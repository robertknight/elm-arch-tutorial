all: elm.js

clean:
	rm *.js
	rm -rf elm-stuff

elm.js: $(wildcard *.elm)
	elm make Main.elm

