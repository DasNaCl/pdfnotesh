pdfnote.sh
==========

This project was made to generate notes for a lecturer's presentation on the very same slides.


## Usage

 1. Generate a basic tex file using `generate_pages.sh`. It expects the lecture's presentation
    as first argument and outputs a *.tex file in `build/.`.
 2. Make your notes
 3. Run `pdfnote.sh` to merge presentation and notes. It expects the presentation as first argument
    and the notes as second argument.
 4. Profit or back to step 2 in case you want to refine your notes

## Dependencies
 The packages `coreutils` and `imagemagick` are needed. Both are probably installed already.

## Future plans
 Suggest something! I might code up a GUI in case any interest is there.
 Something web-based combined with http://asciimath.org/ is probably best.
 I'm open to any suggestions or issues and will try to fix them as soon as possible.
