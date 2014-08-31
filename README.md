CardCreator
===========

A Processing script to automate playing card creation

![Alt text](example_media/example.png)

The Problem
===========

Making changes to a lot of cards can be time-consuming if you are manually editing and saving each card separately. This program attempts to make this easier by using a customizable template file, so you can regenerate all cards instantly whenever you change the layout, add/remove design elements, or edit your art files and game text.

Setup
=====

To see an example:

1. Download and install [Processing](http://www.processing.org/)
2. Clone or download the CardCreator zip
3. Open _CardCreator.pde_ in the Processing IDE
4. Hit Play
5. Four example card files should appear in your CardCreator directory

How it Works
============

_CardCreator.pde_ builds each card file by layering text and image elements according to two files, a template and a content sheet.

![Alt text](example_media/how_it_works.png)

_Template.csv_ lists all elements (images and text) to include in every card, including the x/y positions, width, and height of each element type in pixels.

![Alt text](example_media/template_example.png "template.csv")

_Content.csv_ lists each card in its own row. These rows contain the text & images unique to each card, which will be placed on the card based on their corresponding elements, whose layout was defined in _Template.csv_. 

![Alt text](example_media/content_example.png "content.csv")

- For images, _content.csv_ lists the image filename. For text elements, it lists the card text to display.

When _CardCreator.pde_ runs, it builds each card by looking up its row in _contents.csv_. There, it finds the text or image to use for each element defined in the template, and refers to _template.csv_ to place it. The first elements listed in template.csv are placed first, so they will be covered by any elements listed further down.

How to Use It
=============

_Apart from just changing all the art and card text in contents.csv, you'll probably also want to modify the template itself. Here's how._

Say I want to add a a new Pilot icon to certain cards to show that those characters can fly spaceships.

1. First, I create the pilot icon and save this in the data folder. For this example, I'm calling it "_pilot.png_"

 ![Alt text](example_media/pilot.png "pilot.png")

2. Now I need to say where this icon goes, so I open _template.csv_. I create a new row, type an element name (I'm calling it 'ImgSkill') and define some x and y coordinates, along with the width(w) and height(h) to display the image at in pixels.
  ![Alt text](example_media/template_add_example.png "template_add_example.png")
  - Important: For image elements, the element value must start with 'Img'. For text elements, it must start with 'Text'.
  - Also Important: Currently, you must define an x, y, w, and h value for each element. For text, you also need to choose a size and font. hSquish, the percentage to squish the text by horizontally, is optional.
3. Now I want to define what characters get to be pilots so I open _content.csv_. I create a new column and type the same Element name I created in _templates.csv_: 'ImgSkill'. For each card I want to make a pilot, I paste the filename of the pilot image. By leaving the others blank, they won't get the pilot icon.
  ![Alt text](example_media/content_add_example.png "content_add_example.png")
4. I save _template.csv_ and _content.csv_.
  - Make sure to save these as .csv's if editing in Excel. Ignore the warning to save as xlsx.
5. Now I open _CardCreator.pde_ and hit the play button again. My updated cards should appear in the CardCreator folder. Since I said that Spy gets the pilot.png icon for her ImgSkill, she now has that icon. Tailor doesn't.

  ![Alt text](example_media/cards_pilot_example.png "cards_pilot_example.png")
