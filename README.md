# NoNotes Extension For Quarto

This very simple extension/Lua filter removes the content of `notes` containers, which can be useful if you want to export your Beamer or RevealJS presentation to a format that won’t recognize it (ex : simple PDF or HTML). It’s actually just a wrapper around [a piece of code](https://github.com/jgm/pandoc/issues/8636#issuecomment-2341524975) provided by @tarleb.

## Installing

```bash
quarto add pagiraud/nonotes
```

This will install the extension under the `_extensions` subdirectory.
If you're using version control, you will want to check in this directory.

## Using

Simply add the filter `nonotes` to your YAML header.

## Example

Here is the source code for a minimal example: [example.qmd](example.qmd).

