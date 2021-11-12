defmodule MyPhxApp.Agents.HistoryAgent do

  use Agent

  def start_link(history) do
    Agent.start_link(fn -> history end, name: __MODULE__)
  end

  def stop() do
    Agent.stop(__MODULE__)
  end

  def get() do
    Agent.get(__MODULE__, fn(state) ->
     state
    end)
  end

  def set(history) do
    Agent.update(__MODULE__, fn(state) ->
       state = history
    end)
    get()
  end

end
