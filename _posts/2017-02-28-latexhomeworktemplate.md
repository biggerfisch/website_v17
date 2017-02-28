---
layout: post
title: LaTeXHomeworkTemplate
---

For a class I have this semester (Winter 2017), we need to turn in printed out python code and its output. 
As this is a physics class primarily, the focus is not on good code, but instead on the methods and techniques 
used in computational physics (and related areas). Using printouts then meant that students wouldn't have to fight 
an autograder and understand the complexities of that type of system.
 
Unfortunately however, it can be surprisingly annoying to make these printouts too. I started out using Jupyter for
this class, but quickly got tired of it putting images on the next page (in the middle of other code), taking five 
minutes to make a PDF, and the other general issues it had. Some students just copied and pasted into Word, but 
that didn't sound very reproducible or fun to me. So I went with LaTeX!  
 
I've used LaTeX before, back when I was more of a CS student instead of Physics, but needed a refresher. So I 
started from a template I found and modified it to suit my needs. I then made a Makefile to automate the rest of 
the "build" and off we went! 
 
It's now in a state where I can easily write my code in clearly separate files, add the info to the `.tex` file
and then just run `make` to finish the job. I still currently need to add in the calls to include the output, 
images, and raw code by hand, but eventually, I'd like to have this scan a directory for relevant files and be 
fully automated (well, except for the actual code writing portion). At that point, it would be a very nice system
to turn most any set of code into a printable format.
 
You can find this project on GitHub: [LaTeXHomeworkTemplate](https://github.com/biggerfisch/LaTeXHomeworkTemplate)
