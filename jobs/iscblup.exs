use Kitto.Job.DSL

defmodule Iscblup do
   use Tesla
#   require Logger
#    plug Plug.Logger, log: :debug

     @gethttp "https://teibs.internetbanka.cz/caapi/proxy/hello"

     plug Tesla.Middleware.BaseUrl, @gethttp
     plug Tesla.Middleware.Headers, %{"User-Agent" => "blah"}
     plug Tesla.Middleware.JSON
     adapter :hackney, [ssl_options: []]
     #adapter Tesla.Adapter.Hackney

  def start_link do
    Agent.start_link(fn -> %{isUp: false, minutesUp: 0, minutesDown: 0 } end,  name: __MODULE__ )
    end


  def getKey(key) do
    Agent.get(__MODULE__, fn (map) -> Map.get(map, key) end )
  end

  def getStatus do
    Agent.get(__MODULE__, fn (map) -> map end )
  end

  def setDownTime do
   %{isUp: isUp, minutesUp: minutesUp, minutesDown: minutesDown} = getStatus()
   if isUp do
       Agent.update(__MODULE__, fn (map) -> %{map | :minutesUp => minutesUp + 1} end)
       else
       Agent.update(__MODULE__, fn (map) -> %{map | :minutesDown => minutesDown + 1} end)
   end
   end

  def isTeibsUp() do
    getResults=get("")
	IO.inspect(getResults)
    if getResults.status !== 200 do
        Agent.update(__MODULE__, fn (map) -> %{map | :isUp => false} end)
    else

    end
    false
  end

  def reset() do
        Agent.update(__MODULE__, fn (map) -> %{map | :isUp => true} end)
  end

end

Iscblup.start_link()

job :iscbluprunner, every: {5, :seconds} do
  Iscblup.isTeibsUp()
end

job :iscblup, every: {60, :seconds} do

    IO.inspect(Iscblup.getStatus())
    broadcast! Iscblup.getStatus()
    Iscblup.setDownTime()
    Iscblup.reset()

end

