BUILDERS ?= "virtualbox-iso"

all: update build

update: update_iso update_template

# Fetches the latest iso urls
update_iso: iso_urls_update.rb
	./iso_urls_update.rb

# TODO: ARM
update_template: nixos-x86_64.json

nixos-x86_64.json: gen_template.rb iso_urls.json
	./gen_template.rb x86_64 > $@

build: build-x86_64

build-x86_64: nixos-x86_64.json
	packer build --only=${BUILDERS} $<

.PHONY: all update update_iso update_template build-i686 build-x86_64
