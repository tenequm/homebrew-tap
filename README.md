# Tenequm Tap

## How do I install these formulae?

`brew install tenequm/tap/<formula>`

Or `brew tap tenequm/tap` and then `brew install <formula>`.

Or, in a `brew bundle` `Brewfile`:

```ruby
tap "tenequm/tap"
brew "<formula>"
cask "<cask>"
```

## Available packages

### Casks

- **[blackbox](https://github.com/tenequm/blackbox)** - macOS menu bar app that auto-records call audio. Requires macOS 26.1+.

  ```bash
  brew install --cask tenequm/tap/blackbox
  ```

### Formulae

- **[pond](https://github.com/tenequm/pond)** - local session storage and retrieval for agentic clients.

  ```bash
  brew install tenequm/tap/pond
  ```

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).
