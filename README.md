# README #

This repository is the mirror of [crest](https://github.com/jburnim/crest) work well in ubuntu 18.04.


### How do I get set up? ###

* 1 Add ocaml compiler in your environment.

```
cd ocaml-4.01.0
./configure
make world.opt
make install
```
* 2 Compile the crest-master/cil

```
cd cil
./configure
make
```

* 3 Change *YICES-DIR* in the  **Makefile** located at crest-master/src

```
#first line

```

* 4 Build the crest

```
cd crest-master/src
make

```

Then, if Lucky, the crest will work OK.

Otherwise, Following question I countered.

### ERROR I MEET ###

