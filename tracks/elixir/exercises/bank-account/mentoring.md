### Reasonable solutions

```elixir
defmodule BankAccount do
  use Agent
  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank() do
    {:ok, pid} = Agent.start(fn() -> 0 end)
    pid
 end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(account) do
    Agent.stop(account)
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account) do
    case Process.alive? account do
      true -> Agent.get(account, fn state -> state end)
      _ -> {:error, :account_closed}
    end
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount) do
    case Process.alive? account do
      true -> Agent.update(account, fn(state) -> state + amount end)
      _ -> {:error, :account_closed}
   end
  end
end
```

```elixir
defmodule BankAccount do
  use GenServer

  defstruct amount: nil, status: nil
  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank() do
    {:ok, pid} = GenServer.start_link(__MODULE__, [])
    pid
  end

  def init(_) do
    {:ok, %BankAccount{amount: 0, status: :open}}
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(account) do
    GenServer.call(account, :close_bank)
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account) do
    GenServer.call(account, :balance)
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount) do
    GenServer.call(account, {:update, amount})
  end

  def handle_call(:balance, _from, %BankAccount{status: :closed} = state), do: {:reply, {:error, :account_closed}, state}
  def handle_call(:balance, _from, state), do: {:reply, state.amount, state}

  def handle_call({:update, _amount}, _from, %BankAccount{status: :closed} = state), do: {:reply, {:error, :account_closed}, state}
  def handle_call({:update, amount}, _from, state), do: {:reply, :ok, %BankAccount{state | amount: state.amount + amount}}

  def handle_call(:close_bank, _from, state), do: {:reply, :ok, %BankAccount{state | status: :closed}}
end
```

```elixir
defmodule BankAccount do
  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  def account(balance \\ 0, status \\ :active) do
    case status do
      :active ->
        receive do
          {sender, :balance} ->
            send(sender, {self(), balance})
            account(balance, status)

          {sender, {:update, amount}} ->
            send(sender, {self(), :ok})
            account(balance + amount, status)

          {sender, :close} ->
            send(sender, {self(), :closed})
            account(balance, :closed)
        end

      :closed ->
        receive do
          {sender, _query} ->
            send(sender, {self(), :error, :account_closed})
            account(balance, status)

          _ ->
            account(balance, status)
        end
    end
  end

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank() do
    spawn(fn -> account() end)
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(account) do
    send(account, {self(), :close})

    receive do
      {^account, :closed} -> nil
    end
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account) do
    send(account, {self(), :balance})

    receive do
      {^account, balance} -> balance
      {^account, :error, :account_closed} -> {:error, :account_closed}
    end
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount) do
    send(account, {self(), {:update, amount}})

    receive do
      {^account, :ok} -> :ok
      {^account, :error, :account_closed} -> {:error, :account_closed}
    end
  end
end
```
### Common suggestions

#### See other solutions

There are three possible solutions.
Get the student to look at the other 2 types.
