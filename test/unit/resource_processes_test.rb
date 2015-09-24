# encoding: utf-8

require 'helper'
require 'vulcano/resource'

describe 'Vulcano::Resources::Processes' do
  let(:resource) { load_resource('processes', '/bin/bash') }

  it 'verify processes resource' do
    _(resource.list).must_equal [{
      user: 'root',
      pid: '1',
      cpu: '0.0',
      mem: '0.0',
      vsz: '18084',
      rss: '3228',
      tty: '?',
      stat: 'Ss',
      start: '14:15',
      time: '0:00',
      command: '/bin/bash'
    }]

    _(resource.list.length).must_equal 1
  end
end