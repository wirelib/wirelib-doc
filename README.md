# Wire Documentation
Wire documentation site.
Live: https://wirelib.github.io

This site is built with [Hugo](https://gohugo.io).

## Build
Clone the repo locally: `git clone --recursive-submodules https://github.com/wirelib/wirelib.github.io`
To test it, run `hugo server` and visit http://localhost:1313.
To build it, run `hugo -d docs`. Files will be in the `docs` folder.
**IMPORTANT:** it is important to use the `-d docs` flag as GitHub Pages only recognize this folder as a source directory. Hugo by default builds on the `public` folder.
