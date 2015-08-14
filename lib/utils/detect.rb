# encoding: utf-8
#
# Copyright 2015, Vulcano Security GmbH
#
# Tiny test file to return OS info of the tested node

require 'json'

# hijack os-detection from serverspec
puts JSON.dump({
  os_family:   os[:family],
  os_release:  os[:release],
  os_arch:     os[:arch]
})
exit 0