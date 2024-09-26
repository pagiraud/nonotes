# Speaker Notes Extension For Pandoc and Quarto

This Pandoc filter / Quarto extension helps dealing with 'notes' containers used in presentations (Beamer, RevealJS or PowerPoint) when used in another format that won’t recognize it (ex : PDF, HTML). The default behavior of this filter is to remove the content of 'notes' containers (works with all format) but it can be used to display them in a framed box (for now, PDF only).

## Rational

Writing a presentation in Markdown for Pandoc or Quarto is very convenient. It is, for instance, very easy to add some speaker notes by adding a div with `notes` as a class name in a slide:

```markdown
## Some slide title

Some slide content

::: notes
Some notes for the speaker
:::
```
Nevertheless, a problem occurs when using this code and exporting in other formats: the `notes` class is ignored and the notes are displayed like any other content, with no way for the reader to identify them[^1]. This can be painful if you want to produce a handout for your audience (ie students) and think just giving the PDF version of the slide doesn’t fit your needs. This filter is meant to address this problem with all exporting formats (mainly PDF, HTML, DOCX and ODT).

## Installing

### With Quarto

```bash
quarto add pagiraud/speakernotes
```

This will install the extension under the `_extensions` subdirectory.
If you're using version control, you will want to check in this directory.

### With Pandoc

Simply copy the `speakernotes.lua` file where you need it (see [Pandoc manual](https://pandoc.org/MANUAL.html#option--filter)).

## Using

### With Quarto

Indicate in the YAML header that you want to use this filter:

``` yaml
filters:
  - speakernotes
```
### With Pandoc

Pass the filter to Pandoc with the `lua-filter` or `-L` command line option.

``` cli
pandoc --lua-filter fullframegraphics.lua
```

### Common usage
Options can be configured in the YAML header. Here are all the options available with their default values:

```yaml
speakernotes:
  displayNotes: false
  notesTitle: "Notes"
  borderColor: "red"
  backgroundColor: "white"
  customStyle: ""
```
As this shows, by default the notes are not displayed at all, so setting other options won’t have any effect. This is **the only option available for all export formats**. Actually, any other value than `true` will be considered as false.

The `notesTitle` option works with PDF, HTML, ODT and DOCX formats. It is the name that will be displayed at the beginning of every Notes div. If you don’t want any title do be shown, declare an empty string (`notesTitle = ""`).

Other options are only relevant (for now) with HTML and PDF. This means that if you want this extension / filter to be of any interest with ODT and DOCX outputs, you must create 'Notes' and 'Notes Title' styles in your [reference document](https://pandoc.org/MANUAL.html#option--reference-doc).

Options `borderColor` and `backgroundColor` give the user a little control over the way speaker notes are rendered. Any color recognized by HTML or LaTeX (depending of which packages are loaded by your template) should work.

If not empty, the `customStyle` option supersedes `borderColor`, `backgroundColor`and `notesTitle`.

For PDF outputs, it can be anything you can put as options when declaring a new mdenv with the [mdframed package](https://www.ctan.org/pkg/mdframed), which this filter uses under the hood.

For instance, that is a valid customStyle declaration for PDF outputs:

```yaml
    speakernotes:
      displayNotes: true
      customStyle: |
        roundcorner=5pt,
        subtitlebelowline=true,
        subtitleaboveline=true,
        subtitlebackgroundcolor=yellow!70!white,
        backgroundcolor=blue!20!white,
        frametitle={Speaker Notes},
        frametitlerule=true,
        frametitlebackgroundcolor=yellow!70!white,
```

For HTML, it can be any CSS style declaration. You must include the `<style></style>` tags.

So, to sum up:

|                 | PDF                | HTML               | ODT                | DOCX               | Other formats      |
|-----------------|--------------------|--------------------|--------------------|--------------------|--------------------|
| displayNotes    | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| notesTitle      | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |                    |
| borderColor     | :white_check_mark: | :white_check_mark: |                    |                    |                    |
| backgroundColor | :white_check_mark: | :white_check_mark: |                    |                    |                    |
| customStyle     | :white_check_mark: | :white_check_mark: |                    |                    |                    |

## Example

Here is the source code for a minimal example: [example.qmd](example.qmd).

[^1]: In HTML outputs, the class is kept, so the user can add a CSS style to identify or hide the speaker notes. But this requires some code.
