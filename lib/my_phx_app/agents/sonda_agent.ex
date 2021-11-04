defmodule MyPhxApp.Agents.SondaAgent do

  use Agent

  def start_link(sonda) do
    Agent.start_link(fn -> sonda end, name: __MODULE__)
  end

  def stop() do
    Agent.stop(__MODULE__)
  end

  def get() do
    Agent.get(__MODULE__, fn(state) ->
     state
    end)
  end

  def set(sonda) do
    Agent.update(__MODULE__, fn(state) ->
       state = sonda
    end)
    get()
  end

end
