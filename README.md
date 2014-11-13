# AoikWinWhich-Ceylon
[AoikWinWhich](https://github.com/AoiKuiyuyou/AoikWinWhich) written in Ceylon.

Ceylon: 1.1.0

## Contents
- [How to install](#how-to-install)
- [How to use](#how-to-use)

## How to install
Clone the repo to local.

## How to use
Download Ceylon's zip archive from [here](http://ceylon-lang.org/download/)

Unzip it somewhere. Make command **ceylon** available on console.

Go to the local repo dir of AoikWinWhich-Ceylon.

The program entry file is [src/aoikwinwhich/AoikWinWhich.ceylon](/src/aoikwinwhich/AoikWinWhich.ceylon).

Use ceylon to compile.
```
ceylon compile --rep libs --src src aoikwinwhich
```
- ```--rep``` means specify repo dir. Repo dir for Ceylon is like classpath dir for Java.  
  It's specified in order for dependency libs to be found.
- ```--src``` means specify source dir of our program.
- Result files will be put to **modules** dir.

Use ceylon to run.
```
ceylon run --offline --rep modules --rep libs --run aoikwinwhich::main aoikwinwhich
```
- ```--offline``` means do no connect to remote repos.
- ```--run aoikwinwhich::main``` means the program entry point is package **aoikwinwhich**'s **main** method.
- The last ```aoikwinwhich``` means module **aoikwinwhich**.

See [here](https://github.com/AoiKuiyuyou/AoikWinWhich#how-to-use) for more usage and [AoikWinWhich](https://github.com/AoiKuiyuyou/AoikWinWhich) for more info.
