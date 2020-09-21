# Hie!

This is my personal "config" folder. It contains a bunch of vim and other (AHK etc.) scripts that I use.

## Anna (latex notes) Setup
My main Anna setup is on Windows. Anna will work just fine on Linux systems with little to no adjustments. You may have to change the vim scripts' DOS line endings to unix first. [Convert DOS line endings to Linux line endings in Vim - Stack Overflow]

[Convert DOS line endings to Linux line endings in Vim - Stack Overflow]: https://stackoverflow.com/questions/82726/convert-dos-line-endings-to-linux-line-endings-in-vim

Notes and the like are stored in an AnnaYY folder somewhere on local storage (YY = year, e.g. Anna20).
Be warned: Anna plugin code is a bit messy and it has a few bugs.

1. Copy all the anna plugin files to your vimfiles OR .vim directory:
    The required files are:
      - vimfiles/plugin/anna.vim,
      - vimfiles/plugin/new_anna.vim,
      - vimfiles/after/syntax/annasyn.vim.
2. Copy the 'anna-global' folder to, say, your Documents folder.
3. Open 'Documents/anna-global/init.vim' in vim and run :source %.
4. Follow the prompts to create your Anna20 base at Documents/Anna20.
5. Move and merge the 'Documents/anna-global' folder with 'Documents/Anna20/anna-global'
6. Add the lines below to your .vimrc .  Good to have the path trailing slash... I think. Change the `g:anna_dir` line to match your Anna20 location.

	```
	let g:anna_dir = 'C:\Users\tadexmm\Documents\Anna20\'
	syntax on
	filetype plugin on
	set encoding=utf-8
	```

7. Done. Now open a new g/vim window, type `'l`, cycle through the courses with `tab`, select and type away. 

----

@tadexmm
