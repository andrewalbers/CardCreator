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
5. Four .tif files should appear in your CardCreator directory, as each sample card is generated.

How it Works
============

The template.csv file lists the elements (images or text) you wish to include in all cards, with the x and y position, width, and height of each in pixels.

![Alt text](template_example.png)

The content.csv file lists the specific content to use for ImgA, TextA, and so on. For images, this should be the filename of the image to use for the element in the header. For text, this should be the actual text you want to display.

![Alt text](content_example.png)

When CardCreator.pde runs, it builds each card by reading its content.csv row. Here it finds the text or image to use for each element, and then refers to template.csv to determine where/how to place it. (Note: The first elements listed in template.csv are placed first, so they will be covered by any elements listed further down.)
