(local lfs (require :lfs))
(local json (require :json))

(local init {})
(local project-config
       (json.encode {:name :roblox-fennel-game
                     :tree {:$className :DataModel
                            :Chat {:$className :Chat
                                   :$ignoreUnknownInstances true
                                   :$path :out/chat}
                            :ReplicatedStorage {:$className :ReplicatedStorage
                                                :$ignoreUnknownInstances true
                                                :$path :out/ReplicatedStorage}
                            :ServerScriptService {:$className :ServerScriptService
                                                  :$ignoreUnknownInstances true}
                            :StarterGui {:$className :StarterGui
                                         :$ignoreUnknownInstances true
                                         :$path :out/StarterGui}
                            :StarterPlayer {:$className :StarterPlayer
                                            :$ignoreUnknownInstances true
                                            :StarterPlayerScripts {:$className :StarterPlayerScripts
                                                                   :$ignoreUnknownInstances true
                                                                   :$path :out/StarterPlayer/StarterPlayerScripts}}
                            :Workspace {:$className :Workspace
                                        :$ignoreUnknownInstances true
                                        :$path :out/Workspace
                                        :$properties {:FilteringEnabled true}}}}))

(fn write-config [path]
  (let [f (assert (io.open (.. path :/default.project.json) :w))]
    (f:write project-config)
    (f:close)))

;; lfs.mkdir can't make nested paths?!
(fn init.project [path]
  (let [src-dirs [:/Chat :/StarterGui :/Workspace]]
    (lfs.mkdir path)
    (lfs.mkdir (.. path :/src))
    (lfs.mkdir (.. path :/src :/StarterPlayer))
    (lfs.mkdir (.. path :/src :/StarterPlayer :/StarterPlayerScripts))
    (each [_ dir (ipairs src-dirs)]
      (lfs.mkdir (.. path :/src dir)))
    (let [f (assert (io.open (.. path :/src :/Chat :/Chat.client.fnl) :w))
          f1 (assert (io.open (.. path :/src :/StarterGui
                                  :/StarterGui.client.fnl)
                              :w))
          f2 (assert (io.open (.. path :/src :/Workspace :/Workspace.client.fnl)
                              :w))
          f3 (assert (io.open (.. path :/src :/StarterPlayer
                                  :/StarterPlayerScripts
                                  :/StarterPlayer.client.fnl)
                              :w))
          msg "(print 'hello world!')"]
      (f:write msg)
      (f:close)
      (f1:write msg)
      (f1:close)
      (f2:write msg)
      (f2:close)
      (f3:write msg)
      (f3:close)))
  (write-config path))

init

