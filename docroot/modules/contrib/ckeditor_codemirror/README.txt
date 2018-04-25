INTRODUCTION
------------

CKEditor CodeMirror module adds syntax highlighting for "Source View" in
CKEditor WYSIWYG editor using CodeMirror Plugin
https://w8tcha.github.io/CKEditor-CodeMirror-Plugin.


DRUPAL 8
-------------------------------

DEPENDENCIES
------------
- CKEditor-CodeMirror-Plugin library
  https://github.com/w8tcha/CKEditor-CodeMirror-Plugin

INSTALLATION
------------
1. Download and install CKEditor CodeMirror module.
2. Download and uncompress the latest CKEditor-CodeMirror-Plugin release and
   rename the folder to "ckeditor_codemirror" such that the resulting path to
   the "plugin.js" file should be:
   "libraries/ckeditor_codemirror/codemirror/plugin.js".

CONFIGURATION
-------------
1. Go to "Administration » Configuration » Content authoring » Text formats
   and editors" (admin/config/content/formats) page.
2. Click "Configure" for any test format using CKEditor as the text editor.
3. Under "CKEditor plugin settings", click "CodeMirror" and check "Enable
   CodeMirror source view syntax highlighting". Make sure that the current
   toolbar has the "Source" button. Adjust other settings as desired.
4. Scroll down and click "Save configuration".
5. Go to node create/edit page, choose the text format with CodeMirror plugin.
   Press the "Source" button.
