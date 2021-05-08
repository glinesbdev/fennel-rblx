(local fennel (require :fennel))
(table.insert (or package.loaders package.searchers) fennel.searcher)

(local lfs (require :lfs))
(local init (require :src.init))

(local help "
Usage: fennel_rblx [COMMAND] [FLAGS]

Manages the development workflow when working on Roblox using the Fennel programming language.

COMMANDS
  init PATH   : Create a new Fennel-Rblx project in the given [PATH]
  start       : Watches the files and copies them to the ./out dir

FLAGS
  --version   : Shows the current build version of Fennel-Rblx
  -h, --help  : Shows this help text")

(for [i (length arg) 1 -1]
  (match (. arg i)
    :init (let [path (table.remove arg (+ i 1))]
            (init.project path))
    :start (os.execute (.. :moongarden " --watch"))
    :--version (do
                 (print (.. "Fennel-Rblx " :0.0.1))
                 (os.exit 0))
    :--help (do
              (print help)
              (os.exit 0))
    :-h (do
          (print help)
          (os.exit 0))))

