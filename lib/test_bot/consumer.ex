defmodule TestBot.Consumer do
  alias Nosedrum.Invoker.Split, as: CommandInvoker
  alias Nosedrum.Storage.ETS, as: CommandStorage
  use Nostrum.Consumer

  @compile_prefix Application.compile_env(:nosedrum, :prefix, ".")

  @commands %{
    "ed" => TestBot.Cogs.Ed
  }

  def start_link do
    Consumer.start_link(__MODULE__)
  end

  def handle_event({:READY, _data, _ws_state}) do
    env()

    Enum.each(@commands, fn {name, cog} -> CommandStorage.add_command([name], cog) end)
  end

  def handle_event({:MESSAGE_CREATE, msg, _ws_state}) do
    CommandInvoker.handle_message(msg, CommandStorage)
  end

  def handle_event(_data), do: :ok

  def env do
    :nosedrum
    |> Application.get_env(:prefix)
    |> IO.inspect(label: "runtime_env")

    IO.inspect(@compile_prefix, label: "compile_env")
  end
end
