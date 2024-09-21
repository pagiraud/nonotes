# Speaker Notes Extension For Quarto

This extension helps dealing with 'notes' containers used in Beamer or RevealJS presentations when used in another format that won’t recognize it (ex : PDF, HTML). The default behavior of this filter is to remove the content of 'notes' containers (works with all format) but it can be used to display them in a framed box (for now, PDF only).

## Installing

```bash
quarto add pagiraud/speakernotes
```

This will install the extension under the `_extensions` subdirectory.
If you're using version control, you will want to check in this directory.

## Using

Simply add the filter `speakernotes` to your YAML header.

### Options
Options can be configured in the YAML header. Here are all the options available with their default values:

```yaml
speakernotes:
  displayNotes: false
  notesTitle: "Notes"
  borderColor: "red"
  backgroundColor: "white"
```

## Example

Here is the source code for a minimal example: [example.qmd](example.qmd).

