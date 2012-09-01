# A fresh look at batch-resizing images: use command line

If you deal with images, sooner or later you will want to automate the repeating process of saving different sizes from one source image. If you own Adobe Photoshop and do not save too many output sizes, Photoshop **actions** are probably  quite enough for your needs. However, keeping a Photoshop action up to date is very painful. Change a source folder, and you're screwed.

On my wallpapers website, [www.vladstudio.com](http://www.vladstudio.com), I generate more than 300 JPG files for each wallpaper! I want my art to reach as many devices as possible, which means I need to publish my wallpapers in as many sizes as I can support. On the other hand, I do not want to spend the rest of my life resizing my artworks - I'd rather draw new ones!

Long ago, I used Photoshop actions to save multiple sizes from a source file, but it quickly became a nightmare to maintain. Photoshop provides more powerful tool - **scripting language** (it's not the same as "actions", though the concept is similar). When writing a script, you use a programming language to tell Photoshop what to do (compare it with actions, where Photoshop records what you do with mouse and keyboard). However it's not easy to learn at all. Also, I wanted to completely remove Photoshop from process. 

The solution I found is [ImageMagick](http://www.imagemagick.org/) - a command-line image manipulation program, available for [Windows, Mac and Linux](http://www.imagemagick.org/script/binary-releases.php). Unless you are server administrator, you probably never thought of resizing images using command line. However, after switching to command line, I never looked back at Photoshop for batch resizing. 

Using command line is:

* Easy to expand - adding new sizes takes only one line of code; 
* Easy to maintain - changing folders is as easy as changing one variable;
* Portable - I can save images on server, not only on my main computer.

If you neved worked with command line before, it all might look scary at first. However, with a bit of patience, you will find that it's actually very powerful tool. 

Below is the bash script I wrote, simplified for more universal usage. It takes the following parameters (from you or from default values):

* set of output sizes;
* source file
* destination path (path must include % symbol, which will be replaced by output size, f.e. "800x600")
* optional signature image.

Then it resizes source image into every output size, applying a signature. For better understanding, please look throught the comments in source code.

The script requires:

* [imagemagick](http://www.imagemagick.org/script/binary-releases.php) - to install, follow instructions for your OS. 
* python - I'm sure your PC already has it installed!

Tested in Ubuntu and Mac OS X. How to use: 

* save **resize.sh** to any folder on your computer.
* (optionally) edit the file and set default values for variables.
* open Terminal, navigate to this folder, and execute the following command: `bash resize.sh`
* follow instructions, sit back and enjoy!



