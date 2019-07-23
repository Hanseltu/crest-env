# README #

This repository is the mirror of [crest](https://github.com/jburnim/crest) worked well in ubuntu 18.04.


### To Start ###

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
YICES-DIR=xxx
```

* 4 Build the crest

```
cd crest-master/src
make
```

### Notice ###

* Almost errors I met can be solved in [crest issues](https://github.com/jburnim/crest)

### More Information ###

* http://www.burn.im/crest
