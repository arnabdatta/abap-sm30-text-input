# SAP abap-sm30-text-input

**Author: Arnab Datta**

Update: July, 2023

# Display and save text more than 255 characters from SAP GUI SM30 Transaction
Hi folks,

I know SM30 is very old and not relevant anymore. But from SAP functional person perspective, it is very useful and important tool. Sometime scenario comes that we need to store more than 255-characters text in table and want to maintain it from SM30 as it is very easy and quick to develop. But SAP only allows 255 characters to save and display in table maintenance.

While solving this I thought that I will add a button to SM30 and clicking on that button will display a text edit box in which user can enter the text up to 1000 characters or more.

## Lets create a table SM30_DEMO

![sm30_table](https://github.com/arnabdatta/abap-sm30-text-input/assets/1858399/dd33d473-9d7e-4ac3-bee8-f71a0788c9e1)

Once you generate the table maintenance, you will get a warning message like this.

![sm_gen](https://github.com/arnabdatta/abap-sm30-text-input/assets/1858399/4f40696e-9221-431b-8763-bbb27fec4b23)

## ABAP Solution

Double click on the screen number to open the screen painter. Then click on “Layout” button on the toolbar.

In screen painter take the button and draw it at the end of the table.me it “Edit Text”

Save and activate it, go back to flow logic and go to “Element List” tab.

Click on attributes icon at the top to open and give the icon and function code as shown.

![att](https://github.com/arnabdatta/abap-sm30-text-input/assets/1858399/293d5ee1-39b3-4296-90d4-eb87d16c63db) 

In the flow logic add one module in the end and double click to create it.

[Check MODULE.abap in code](MODULE.abap)

[Check BTN_EDIT_TEXT.abap for module source](BTN_EDIT_TEXT.abap)

Now you have fully functional Sm30 with a popup taking more than 255 characters. The last touch , you can also make the text field read only so that user will only use the popup to enter the long text.

## Demo:

![sm30_demo](https://github.com/arnabdatta/abap-sm30-text-input/assets/1858399/d24120a7-37ae-42af-9781-3e4e75f4d62d)
 

Hope this helps! Let me know in your comments any improvement I can do to this.


Happy coding!! 🙂
