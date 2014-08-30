CardCreator
===========

A Processing script to help automate playing card design

![Alt text](example.png)

Setup
=====

1. Download and install Processing [here](http://www.processing.org/)
2. Clone the CardCreator folder to your local machine
3. Open CardCreator.pde in the Processing IDE
4. Hit Play
5. Four example card files should appear in your CardCreator directory

How it Works
============

CardCreator builds each card file by layering text and image elements according to a template and a content file.

Template.csv lists all elements (images and text) you wish to include in each card, including the x/y position, width, and height of each element in pixels.

Template.csv
![Alt text](template_example.png "template.csv")

Content.csv says what text or image to use for each element defined in Template.csv. For images, it lists the filename of the image to place. For text elements, it lists the actual text to display.

Content.csv
![Alt text](content_example.png "content.csv")

When CardCreator.pde runs, it builds each card by looking up its row in contents.csv. There, it finds the text or image to use for each element defined in the template, and refers to template.csv to place it. The first elements listed in template.csv are placed first, so they will be covered by any elements listed further down.

How the Spy Card is built
![Alt text](how_it_works.png)
