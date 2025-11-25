# lorem-ipsum-english

Insert English filler text from classic poetry and literature into Emacs.

This package works like the standard `lorem-ipsum` package but uses beautiful English sentences from public domain poetry and literature instead of Latin text.

## Installation

### From source

Clone this repository and add to your load path:

```elisp
(add-to-list 'load-path "/path/to/lorem-ipsum-english")
(require 'lorem-ipsum-english)
```

### MELPA (coming soon)

```elisp
(use-package lorem-ipsum-english
  :ensure t)
```

## Usage

Three main commands are provided:

- `M-x lorem-ipsum-english-insert-sentences` - Insert sentences
- `M-x lorem-ipsum-english-insert-paragraphs` - Insert paragraphs (3-6 sentences each)
- `M-x lorem-ipsum-english-insert-list` - Insert list items

Use numeric prefix arguments to specify quantity:

```
C-u 5 M-x lorem-ipsum-english-insert-sentences RET
```

### Default Keybindings

Enable default keybindings with:

```elisp
(lorem-ipsum-english-use-default-bindings)
```

This binds:
- `C-c l s` - Insert sentences
- `C-c l p` - Insert paragraphs
- `C-c l l` - Insert list

## Customization

Customize separators and list formatting:

```elisp
(setq lorem-ipsum-english-sentence-separator " ")
(setq lorem-ipsum-english-paragraph-separator "\n\n")
(setq lorem-ipsum-english-list-beginning "* ")
(setq lorem-ipsum-english-list-ending "\n")
```

In HTML/SGML modes, list formatting automatically adapts to `<li>` tags.

## Text Corpus

The package includes excerpts from classic works by:
- William Shakespeare
- William Wordsworth
- John Keats
- Charles Dickens
- Robert Frost
- Edgar Allan Poe
- Emily Dickinson
- And more

All text is from public domain sources.

## License

MIT License - see LICENSE file for details.

## Support

If you find this project helpful, consider supporting it!

[Donate via PayPal](https://www.paypal.com/paypalme/revrari)
# english-lorem-ipsum
