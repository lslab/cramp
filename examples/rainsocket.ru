require "rubygems"
require "bundler"
Bundler.setup(:default, :example)

require 'cramp'

Cramp::Websocket.backend = :rainbows

class WelcomeController < Cramp::Websocket
  periodic_timer :send_hello_world, :every => 2
  on_data :received_data

  def received_data(data)
    if data =~ /fuck/
      render "You cant say fuck in here"
      finish
    else
      render "Got your #{data}"
    end
  end

  def send_hello_world
    render "Hello from the Server!"
  end
end

# rainbows -E deployment -c rainbows.conf rainsocket.ru
run WelcomeController
