# abap-sm30-text-input
Display and save text more than 255 characters from SAP GUI SM30 Transaction
Hi folks,

I know SM30 is very old and not relevant anymore. But from SAP functional person perspective, it is very useful and important tool. Sometime scenario comes that we need to store more than 255-characters text in table and want to maintain it from SM30 as it is very easy and quick to develop. But SAP only allows 255 characters to save and display in table maintenance.

While solving this I thought that I will add a button to SM30 and clicking on that button will display a text edit box in which user can enter the text up to 1000 characters or more.

Lets create a table SM30_DEMO

![sm30_table](https://github.com/arnabdatta/abap-sm30-text-input/assets/1858399/dd33d473-9d7e-4ac3-bee8-f71a0788c9e1)

Once you generate the table maintenance, you will get a warning message like this.

![sm_gen](https://github.com/arnabdatta/abap-sm30-text-input/assets/1858399/4f40696e-9221-431b-8763-bbb27fec4b23)

Now let’s begin the solution.

Double click on the screen number to open the screen painter. Then click on “Layout” button on the toolbar.

In screen painter take the button and draw it at the end of the table.me it “Edit Text”

Save and activate it, go back to flow logic and go to “Element List” tab.

Click on attributes icon at the top to open and give the icon and function code as shown.

![att](https://github.com/arnabdatta/abap-sm30-text-input/assets/1858399/293d5ee1-39b3-4296-90d4-eb87d16c63db) 

In the flow logic add one module in the end and double click to create it.

PROCESS BEFORE OUTPUT.
 MODULE LISTE_INITIALISIEREN.
 LOOP AT EXTRACT WITH CONTROL
  TCTRL_ZSM30_DEMO CURSOR NEXTLINE.
   MODULE LISTE_SHOW_LISTE.
 ENDLOOP.
*
PROCESS AFTER INPUT.
 MODULE LISTE_EXIT_COMMAND AT EXIT-COMMAND.
 MODULE LISTE_BEFORE_LOOP.
 LOOP AT EXTRACT.
   MODULE LISTE_INIT_WORKAREA.
   CHAIN.
    FIELD ZSM30_DEMO-VALUE .
    FIELD ZSM30_DEMO-TEXT .
    MODULE SET_UPDATE_FLAG ON CHAIN-REQUEST.
   ENDCHAIN.
   FIELD VIM_MARKED MODULE LISTE_MARK_CHECKBOX.
   CHAIN.
    FIELD ZSM30_DEMO-VALUE .
    MODULE LISTE_UPDATE_LISTE.
   ENDCHAIN.
 ENDLOOP.
 MODULE LISTE_AFTER_LOOP.
 MODULE BTN_EDIT_TEXT.   " <====== Add here
Write the below code in the module.

Check attached code for module source.



Now you have fully functional Sm30 with a popup taking more than 255 characters. The last touch , you can also make the text field read only so that user will only use the popup to enter the long text.

Demo:

![sm30_demo](https://github.com/arnabdatta/abap-sm30-text-input/assets/1858399/d24120a7-37ae-42af-9781-3e4e75f4d62d)
 

Hope this helps! Let me know in your comments any improvement I can do to this.

 
To know more about SM30 events and variables please check the SAP Help site.

Extended Table Maintenance Events | SAP Help Portal

Happy coding!! 🙂
