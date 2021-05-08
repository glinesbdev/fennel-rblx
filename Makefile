LUA ?= lua
FENNEL ?= ./bin/fennel
DESTDIR ?=
PREFIX ?= /usr/local
BIN_DIR ?= $(PREFIX)/bin

build: fennel_rblx

fennel_rblx: src/core.fnl
	@echo "#!/usr/bin/env $(LUA)" > $@
	@$(FENNEL) --compile --no-metadata --require-as-include $< >> $@
	@chmod 755 $@

uploadrock: rockspecs/fennel_rblx-$(VERSION)-1.rockspec
	luarocks --local build $<
	$(HOME)/.luarocks/bin/fennel_rblx --version | grep $(VERSION)
	luarocks --local remove fennel_rblx
	luarocks upload --sign --api-key $(shell pass luarocks-api-key) $<
	luarocks --local install fennel_rblx
	$(HOME)/.luarocks/bin/fennel_rblx --version | grep $(VERSION)
	luarocks --local remove fennel_rblx

clean:
	@rm fennel_rblx

.PHONY: build fennel_rblx uploadrock clean
