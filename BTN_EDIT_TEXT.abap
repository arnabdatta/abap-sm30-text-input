*&---------------------------------------------------------------------*
*&      Module  BTN_EDIT_TEXT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE btn_edit_text INPUT.
  TYPES BEGIN OF lty_tab.
  INCLUDE STRUCTURE zsm30_demo. " Incident Sub types
  INCLUDE STRUCTURE vimtbflags. " Flag structure for view maint. tool: Flags for tables
  TYPES END OF lty_tab.

  DATA: lt_tab TYPE STANDARD TABLE OF lty_tab,
        ls_tab TYPE lty_tab.

  DATA: lv_line         TYPE i,                    " Line of type Integers
        lt_text         TYPE catsxt_longtext_itab, " Text editor text line
        ls_line_struc   TYPE lty_tab,
        lv_old_text     TYPE text1000,             " Explanation
        lv_changed_text TYPE text1000.             " Explanation

  FIELD-SYMBOLS: <fs_line_struc>   TYPE lty_tab, " Incident Sub types
                 <fs_explaination> TYPE any.

  CASE function.
    WHEN 'EDIT_TXT'.

      GET CURSOR LINE lv_line.

      LOOP AT extract .
        IF sy-tabix EQ lv_line.
          ASSIGN extract TO <fs_line_struc> CASTING.
          EXIT.
        ENDIF. " IF sy-tabix EQ lv_line
      ENDLOOP. " LOOP AT extract

      ls_line_struc = <fs_line_struc>.

      lv_old_text = <fs_line_struc>-text.

      CLEAR lt_text.
      CALL FUNCTION 'RKD_WORD_WRAP'
        EXPORTING
          textline            = <fs_line_struc>-text
          outputlen           = 72
        TABLES
          out_lines           = lt_text
        EXCEPTIONS
          outputlen_too_large = 1
          OTHERS              = 2.
      IF sy-subrc <> 0.
* Implement suitable error handling here
      ENDIF. " IF sy-subrc <> 0


      CALL FUNCTION 'CATSXT_SIMPLE_TEXT_EDITOR'
        EXPORTING
          im_title = 'Explanation Text'
        CHANGING
          ch_text  = lt_text.

      CLEAR lv_changed_text.
      LOOP AT lt_text INTO DATA(ls_text).
        CONCATENATE lv_changed_text ls_text INTO lv_changed_text.
      ENDLOOP. " LOOP AT lt_text INTO DATA(ls_text)

      CONDENSE lv_changed_text.

      IF lv_old_text NE lv_changed_text.
        <fs_line_struc>-text = lv_changed_text.
        <fs_line_struc>-vim_action = aendern.

        MODIFY extract INDEX lv_line.
        <status>-upd_flag = 'X'.
        total[] = extract[].
      ENDIF. " IF lv_old_text NE lv_changed_text

  ENDCASE.
ENDMODULE.
