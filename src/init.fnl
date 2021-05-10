(local json (require :json))

(local init {})
(local separator (package.config:sub 1 1))

(fn remove-lua-files [path]
  (os.remove (.. path separator :client separator :init.client.lua))
  (os.remove (.. path separator :server separator :init.server.lua))
  (os.remove (.. path separator :shared separator :Hello.lua)))

(fn write-fennel-files [path]
  (let [files {:client (.. path separator :client separator :init.client.fnl)
               :server (.. path separator :server separator :init.server.fnl)
               :Hello (.. path separator :shared separator :Hello.fnl)}]
    (each [name file (pairs files)]
      (let [f (io.open file :w)]
        (if (= name :Hello)
            (do
              (f:write (string.format "(fn hello []\n\t(print :Hello!)\n)"))
              (f:close))
            (f:write (string.format "(print \"hello world from the %s!\")" name))
            (f:close))))))

(fn init.project [path]
  (os.execute (string.format "%s %s %s" :rojo :init path))
  (let [fread (io.open (.. path separator :default.project.json) :r)
        text (fread:read :*all)
        updated (string.gsub text :src :out)
        fwrite (do
                 (fread:close)
                 (io.open (.. path separator :default.project.json) :w))]
    (fwrite:write updated)
    (fwrite:close))
  (remove-lua-files (.. path separator :src))
  (write-fennel-files (.. path separator :src)))

init

