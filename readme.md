Movie Manager
=========

_Week Six Assignment_

<img src="http://f.cl.ly/items/2y1U3J1a1v2c2d3l3C1K/Screen%20Shot%202014-08-29%20at%202.09.02%20PM.png" width="400px" align="right" /><img src="http://f.cl.ly/items/0K0x46350g3k393Y0m3g/Screen%20Shot%202014-08-29%20at%203.29.58%20PM.png" width="400px" align="right" />
<img src="http://cl.ly/XHfw/Screen%20Shot%202014-08-29%20at%202.10.33%20PM.png" width="400px" align="right" />

**How was your experience making this app?**

It went pretty smoothly and I think I was able to handle everything pretty well. The main trouble I had was knowing where to separate parsing and my requests and what work should be done in a view controller VS in the parsing portions.

The other issue I had was remembering to setup the table with File's Owner. That one had me wondering for a bit where I went wrong. I doubt it will happen again however.

Lastly, I think adding animations was super simple but I think I could do a bit better with more time to control the responsiveness of the UI in regards to how it updates and is presented when it's making requests for data.

<hr/>

**What resources did you find helpful?**

I used Marty's text exploration examples to help me with the JSON formatting, coloring and styling.

Another resource were the videos for this week. Those videos really helped me understand where the seperation of the requests are.

I used some code examples in my past projects as well to handle toolbars and tables.

For Pretty Print formatting the JSON text I found a great example on stackOverflow: http://stackoverflow.com/a/9020923/3920924

<hr/>

**One well-formed question or observation about the app, technologies used, or related topics.**

I made a few observations above but one question I have is if my method loading images is appropriate or if they should be set to a queue and how I might cancel that queue if another request is made.

Also, in my _JRDMainWindowController.m_ file my method _performSearchOnEntry_ I'm doing checking on _self.currentView_ to see which view is active and then calling the _workOnMovieSearchTerm_ method on the active view. I really felt like I shouldn't have had to do that check and just called the method on _self.currentView_ since it should have pointed directly to the view that was active. Is there something here I am missing or is this the right approach?
