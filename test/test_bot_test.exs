defmodule TestBotTest do
  use ExUnit.Case
  doctest TestBot

  test "greets the world" do
    assert TestBot.hello() == :world
  end
end
