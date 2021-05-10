(local fennel (require :fennel))
(table.insert (or package.loaders package.searchers) fennel.searcher)

(local lfs (require :lfs))
(local init (require :src.init))

(local help "
Usage: fennel_rblx [COMMAND] [FLAGS]

Manages the development workflow when working on Roblox using the Fennel programming language.

COMMANDS
  init PATH   : Create a new Rojo project in the given [PATH] and builds the [PATH].rbxlx Roblox file.
  start       : Watches the files in ./src and copies them to the ./out dir.
                Starts Rojo to transfer Lua code in ./out to your Roblox game.

FLAGS
  --version   : Shows the current build version of Fennel Rblx.
  -h, --help  : Shows this help text.")

(for [i (length arg) 1 -1]
  (match (. arg i)
    :init (let [path (table.remove arg (+ i 1))]
            (init.project path)
            (lfs.chdir path)
            (os.execute :moongarden)
            (os.execute (string.format "rojo build -o %s.rbxlx" path)))
    :start (let [moongarden (.. :moongarden " --watch")
                 rojo (.. :rojo " serve")]
             (os.execute (.. rojo " & " moongarden)))
    :--version (do
                 (print (.. "Fennel-Rblx " :0.0.1))
                 (os.exit 0))
    :--help (do
              (print help)
              (os.exit 0))
    :-h (do
          (print help)
          (os.exit 0))))

