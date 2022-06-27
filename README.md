# Security.Umbrella

# Run the App
Enter the following command:
    iex -S mix phx.server

Go to `http://localhost:4000/` to test it is up and running.


# Usage
    iex(1)> :code_lock.start_link(["1", "2"])
    {:error, {:already_started, #PID<0.447.0>}}
    iex(2)> :code_lock.button("1")
    :ok