## Ruby itself

I manage the version of Ruby I'm currently using with [`rbenv`](https://github.com/rbenv/rbenv).

> Homebrew
> On macOS or Linux, we recommend installing rbenv with Homebrew.

```console
$ brew install rbenv ruby-build
```

This will end with you adding a line to your shell config file. Check rbenv docs or run `rbenv init` for the correct configuration for your shell.

```sh
eval "$(rbenv init - zsh)"
```

Now you can `cd` into a project directory with a `.ruby-version` file and install the correct version of Ruby.

```console
~/ $ cd my-app
~/my-app/ $ rbenv install
```

## Gems

If I'm running a project in Docker, I let the Dockerfile handle its business, but I also like to be able to run a local Rails or irb console session.

This means when I pull an updated verson of a project with Gemfile changes, I make sure to run bundle install locally and in the image.

```console
$ bundle install; docker run my-app bundle install
```

## Editor

I'm using VS Code for work with the [Ruby LSP](https://marketplace.visualstudio.com/items?itemName=Shopify.ruby-lsp) plugin installed.

And this is my User-level config:
```json
{
  "rubyLsp.enabledFeatures": {
    "codeActions": true,
    "diagnostics": true,
    "documentHighlights": true,
    "documentLink": true,
    "documentSymbols": true,
    "foldingRanges": true,
    "formatting": true,
    "hover": true,
    "inlayHint": true,
    "onTypeFormatting": true,
    "selectionRanges": true,
    "semanticHighlighting": true,
    "completion": true,
    "codeLens": true,
    "definition": true
  },
  "rubyLsp.rubyVersionManager": "rbenv",
  "rubyLsp.formatter": "rubocop",
  "[ruby]": {
    "editor.defaultFormatter": "Shopify.ruby-lsp"
  },
  "rubyLsp.pullDiagnosticsOn": "save"
}
```

The plugin communicates nicely with `rubocop` to handle fast, automatic linting and most importantly, **automatic code formatting**.

`Format Document` (`rubocop -a $current_file`) is a dangerous command in any project with known rubocop violations in areas of the code you aren't involved in, so I use it carefully when visiting other people's code.

Files which are already clean or even better, projects which can be started from scratch, I auto-format all the things, all the time, which helps me meet my goal of **NEVER SPENDING 1 EXTRA SECOND THINKING ABOUT CODE FORMATTING**.