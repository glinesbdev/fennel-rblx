# Fennel Rblx

Using the power of [Moon Garden][5] and incorporating the fun of [Roblox][1], develop your Roblox games in the awesome Lisp style [Fennel][2] programming language.

⚠️ This tool requires that [Rojo][4] is installed. ⚠️

## Installation

The easiest way to use Fennel Rblx is using LuaRocks:

```shell
luarocks install fennel_rblx
```

## Usage

```shell
Usage: fennel_rblx [COMMAND] [FLAGS]

Manages the development workflow when working on Roblox using the Fennel programming language.

COMMANDS
  init PATH   : Create a new Rojo project in the given [PATH] and builds the [PATH].rbxlx Roblox file.
  start       : Watches the files in ./src and copies them to the ./out dir.
                Starts Rojo to transfer Lua code in ./out to your Roblox game.

FLAGS
  --version   : Shows the current build version of Fennel Rblx.
  -h, --help  : Shows this help text.
```

## Contributing

1. Fork the repo.
2. Make your changes.
3. Submit a PR!
4. ...profit!

## Having Issues?

[Let me know!][3]

## License

Copyright © 2021-2021 Bradyn Glines

Released under the [MIT license](LICENSE).

[1]: https://roblox.com
[2]: https://fennel-lang.org
[3]: https://github.com/glinesbdev/fennel-rblx/issues/new/choose
[4]: https://rojo.space
[5]: https://github.com/glinesbdev/moongarden
