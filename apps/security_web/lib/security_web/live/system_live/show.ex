defmodule SecurityWeb.SystemLive.Show do
  use SecurityWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    #PubSub.subscribe(SecurityWeb.PubSub, "security")

    socket =
      socket
      |> assign(:state, "Locked")
      |> assign(:display, "")

    IO.inspect socket

    {:ok, socket}
  end

  # and the handle info to receive messages from the erlang backend!
  @impl true
  def handle_info(_message, _socket) do
  end

  @impl true
  def handle_event(
        "button",
        %{"digit" => digit},
        socket
      ) do
          IO.inspect digit
    :ok = :code_lock.button(digit)
    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    ~L"""
    <div class="grid grid-cols-2 gap-4 mt-60">
      <div class="p-4 rounded-lg shadow-lg text-green-600 col-span-2 border-black bg-black h-16">
        <p><%= @state %>&nbsp;&nbsp;<%= @display %></p>
      </div>
    <div class="grid grid-cols-3 gap-3 max-h-3 col-span-2">
        <button
          phx-click="button"
          phx-value-digit="{1}"
          class="bg-indigo-600 hover:bg-indigo-700 text-white font-bold py-2 px-4 rounded"
        >
          1
        </button>
        <button
          phx-click="button"
          phx-value-digit="{2}"
          class="bg-indigo-600 hover:bg-indigo-700 text-white font-bold py-2 px-4 rounded"
        >
          2
        </button>
        <button
          phx-click="button"
          phx-value-digit="{3}"
          class="bg-indigo-600 hover:bg-indigo-700 text-white font-bold py-2 px-4 rounded"
        >
          3
        </button>
        <button
          phx-click="button"
          phx-value-digit="{4}"
          class="bg-indigo-600 hover:bg-indigo-700 text-white font-bold py-2 px-4 rounded"
        >
          4
        </button>
        <button
          phx-click="button"
          phx-value-digit="{5}"
          class="bg-indigo-600 hover:bg-indigo-700 text-white font-bold py-2 px-4 rounded"
        >
          5
        </button>
        <button
          phx-click="button"
          phx-value-digit="{6}"
          class="bg-indigo-600 hover:bg-indigo-700 text-white font-bold py-2 px-4 rounded"
        >
          6
        </button>
        <button
          phx-click="button"
          phx-value-digit="{7}"
          class="bg-indigo-600 hover:bg-indigo-700 text-white font-bold py-2 px-4 rounded"
        >
          7
        </button>
        <button
          phx-click="button"
          phx-value-digit="{8}"
          class="bg-indigo-600 hover:bg-indigo-700 text-white font-bold py-2 px-4 rounded"
        >
          8
        </button>
        <button
          phx-click="button"
          phx-value-digit="{9}"
          class="bg-indigo-600 hover:bg-indigo-700 text-white font-bold py-2 px-4 rounded"
        >
          9
        </button>
        <button
          phx-click="button"
          phx-value-digit="{0}"
          class="bg-indigo-600 hover:bg-indigo-700 text-white font-bold py-2 px-4 rounded"
        >
          0
        </button>
        <button
          class="bg-indigo-600 hover:bg-indigo-700 text-white font-bold py-2 px-4 rounded col-span-2"
        >
          Clear
        </button></div>
        </div>
    """
  end
end