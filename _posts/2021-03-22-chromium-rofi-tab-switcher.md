---
layout: post
title: Chromium Rofi Tab Switcher
date: 2021-03-22 17:19 -0400
---


What
====

Have you ever wished you could treat tabs as windows in your fancy window switcher? I sure have!

That's why I made ![GitHub logo](/images/github_25x25.png) [chromium-rofi-mode](https://github.com/biggerfisch/chromium-rofi-mode)

It's a simple script that, along with rofi, allows you to switch to a tab just like a window, in the exact same UI.


Why
===

As I'm certain many other developers do, I keep a lot of tabs open. Some are for active work, some are for reference,
some are dreams for the future, and some are just plain forgotten. I also run Linux primarily for work when I can, and
usually the [i3 window manager](https://i3wm.org/).

This combination means two things:
1. Tabs can become difficult to find in multiple windows and workspaces.
2. Keyboard shortcuts are especially important. 

[rofi](https://github.com/davatorium/rofi) is well designed to fit in this environment and help us navigate the chaos.
But, its out-of-the-box functionality is limited to switching windows. Therefore, writing the script finishes covering
this gap in my workflow.


How
===
Chromium-based browsers expose their tab information (and more) through a debugging API that is disabled by default.
When enabled and interfaced with, we get a JSON list of the tabs and pages open which we can display to the user. Using rofi's scripting protocol, we also embed the tab ID into each line for use when activating the tab.

Activating the tab works with the same interface as reading all the tabs - we simply use the debugging tools to activate
our wanted tab. If we didn't have the ID, we'd need to search through the listing again to match the title/url/etc.

Finally, after activation of the tab, we want to switch to the window. Since the tab we want should now be focused, we
simply need to find the window with the name of our tab and tada! All done.
