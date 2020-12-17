# scopetopmove.vim #

This plugin is move cursor to top line of function scope at editing C/C++ files.<br>
Default [[ or ]] command to check ":help [[" or ":help ]]".<br>
ex) :help ]]
```sh
]] [count] sections forward or to the next '{' in the first column.
```

If you using C/C++ and coding rule usage is as follows e.g.<br>
```sh
void Function()
{
}
```
usable default command.<br>
but case of different rule e.g.<br>
```sh
void Function() {
}
```
unusable defalt command.<br>

## Caution ##
This plugin is override in default command  [[ and ]] of vim.

## Installation ##
Any ".vim" files copy to autoload directory and plugin directory of installed vim directory.

## Usage ##
```sh
Input [[ or ]] at the time of command mode.
```
