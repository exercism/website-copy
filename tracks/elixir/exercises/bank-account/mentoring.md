# Mentoring

## Reasonable solutions

Using [`Agent`](https://hexdocs.pm/elixir/Agent.html):

```elixir
defmodule BankAccount do
  use Agent

  @opaque account :: pid

  @spec open_bank() :: account
  def open_bank() do
    {:ok, account} = Agent.start_link(fn -> 0 end)
    account
  end

  @spec close_bank(account) :: none
  def close_bank(account), do: Agent.stop(account)

  @spec balance(account) :: integer
  def balance(account) do
    if Process.alive?(account) do
      Agent.get(account, & &1)
    else
      {:error, :account_closed}
    end
  end

  @spec update(account, integer) :: any
  def update(account, amount) do
    if Process.alive?(account) do
      Agent.update(account, &(&1 + amount))
    else
      {:error, :account_closed}
    end
  end
end
```

Using [`GenServer`](https://hexdocs.pm/elixir/GenServer.html):

```elixir
defmodule BankAccount do
  use GenServer

  @opaque account :: pid
  
  @spec open_bank() :: account
  def open_bank() do
    {:ok, account} = GenServer.start_link(__MODULE__, 0)
    account
  end

  @spec close_bank(account) :: none
  def close_bank(account), do: GenServer.stop(account)

  @spec balance(account) :: integer | {:error, :account_closed}
  def balance(account) do
    if Process.alive?(account) do
      GenServer.call(account, :balance)
    else
      {:error, :account_closed}
    end
  end

  @spec update(account, integer) :: :ok | {:error, :account_closed}
  def update(account, amount) do
    if Process.alive?(account) do
      GenServer.cast(account, {:update, amount})
    else
      {:error, :account_closed}
    end
  end

  @impl true
  def init(balance), do: {:ok, balance}

  @impl true
  def handle_call(:balance, _from, balance), do: {:reply, balance, balance}

  @impl true
  def handle_cast({:update, amount}, balance), do: {:noreply, balance + amount}
end
```

Using [`spawn/1`](https://hexdocs.pm/elixir/Kernel.html#spawn/1),
[`send/2`](https://hexdocs.pm/elixir/Kernel.html#send/2) and
[`receive/1`](https://hexdocs.pm/elixir/Kernel.SpecialForms.html#receive/1):

```elixir
defmodule BankAccount do
  @opaque account :: pid

  defp listen(from, balance) do
    new_balance =
      receive do
        :balance ->
          send(from, balance)
          balance

        {:update, amount} ->
          balance + amount
      end

    listen(from, new_balance)
  end

  @spec open_bank() :: account
  def open_bank() do
    reply_to = self()
    spawn(fn -> listen(reply_to, 0) end)
  end

  @spec close_bank(account) :: true
  def close_bank(account), do: Process.exit(account, :kill)

  @spec balance(account) :: integer
  def balance(account) do
    if Process.alive?(account) do
      send(account, :balance)

      receive do
        balance -> balance
      end
    else
      {:error, :account_closed}
    end
  end

  @spec update(account, integer) :: any
  def update(account, amount) do
    if Process.alive?(account) do
      send(account, {:update, amount})
    else
      {:error, :account_closed}
    end
  end
end
```

## Common questions

### `@opaque` vs `@type`/`@typep`

This problem initially provides students with an `@opaque account :: pid`.

The reason for it to be `@opaque` boils down to the principle of encapsulation:

- clients using the `BankAccount` module don't need to know its implementation details to work with it
- you can easily change the underlying implementation (`Agent`, `GenServer`, etc.) without modifying the public API
- because it's `@opaque`, clients can't rely on the actual type of `account`, be it a `pid` or anything else

### Common suggestions

An acceptable solution should:

- use a server holding state (`Agent`, `GenServer`)
- keep the state minimal (preferably only `balance :: integer`)
- differentiate between synchronous and asynchronous operations

#### Using a stateful server

If a student tries to solve the problem by encoding the state into the handle
with a data structure like `Map` (for example, `@type account :: %{open: boolean, balance: integer}`),
they will run into problems with `BankAccount.update/2`, as it does **not** return a new handle with updated balance.
This should guide them towards thinking of `account` as a handle to an external state holder, not the actual state.

If they have trouble finding the proper module to use, the `Agent` module should primarily be mentioned
(mostly for the easier and cleaner API), and, optionally, `GenServer` (with regard to its Erlang roots).

#### `call` vs `cast`

Operations like `balance/1` **must** be synchronous (`call`),
as the client expects to receive the result immediately.

Operations like `close_bank/1` **may** be asynchronous -
we neither care about the origin of the `close_bank/1` call nor need to reply with anything.

`update/2` is a great topic for discussion.
A student might think that synchronicity is needed here to avoid data races.
If so, it can be pointed out that the server receives the *function* and computes the new state *by itself*,
rather than the clients computes the new state and passes it to the server.

For example, the only difference between `Agent.cast/2` and `Agent.update/3` is
that they're asynchronous and synchronous, respectively - they both always return `:ok`.
In our case (changing an integer value), there is no dependency on the order of execution.

#### `Process.alive?/1`

If a solution uses a state like `{:open | :closed, balance}` to check if the account is closed,
a combination of [`Process.alive?/1`](https://hexdocs.pm/elixir/Process.html#alive?/1)
and the `stop` function of their server ([`Agent.stop/3`](https://hexdocs.pm/elixir/Agent.html#stop/3), [`GenServer.stop/3`](https://hexdocs.pm/elixir/GenServer.html#stop/3)) can be suggested.

Some of the advantages:

- The server doesn't need to continue running, doing nothing - hence optimization
- Slimmer state allows for cleaner code
