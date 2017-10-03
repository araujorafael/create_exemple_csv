defmodule GenerateCsv do
  @moduledoc """
        Documentation for GenerateCsv.
  """

  @doc """
  Create especified number of csv lines

  ## Parameters
      count: Number of entries that willbe generated

  ## Examples

      iex> GenerateCsv.create(1)
      ["51734,euvl 878,tptzd2", "14928,ougt 237,jmwc83"]


  """

  @spec create(integer()) :: [...]
  def create(count) do
      # set random seed
      :rand.seed(:exs1024, :erlang.timestamp())

      # showd create a array with each line of CSV format {id, class name, room number}
      create([], count)
  end

  defp create(list, 0) do
    list
  end

  defp create(list, count) do
    create([new_line() | list], count - 1)
  end


  @doc """
  Generate random string

  ## Parameters
      size: Random string number of chars
      type: Set default char pool will be used

  ## Examples

      iex> GenerateCsv.rand_str(5, :alphanumerical)
      "h8v0v"

      iex> GenerateCsv.rand_str(5, :char)
      "ckhmk"

  """
  @spec create(integer(), atom()) :: String.t()
  def rand_str(size, type) do
    basic_alphabet = "abcdefghijklmnopqrstuvwxyz"

    alphabet = case type do
      :alphanumerical -> Enum.join(["0123456789", basic_alphabet], "")
      :char -> basic_alphabet
    end

    rand_str("", "", alphabet, size)
  end

  defp rand_str(_new_char, str, _alphabet, 0) do
    str
  end

  defp rand_str(new_char, str, alphabet, size) do
    # Set the new string
    str = "#{str}#{new_char}"

    # Set the next random position
    rand_pos = alphabet
    |> String.length
    |> :rand.uniform

    # Recursive call with new letter that shold be added to string
    alphabet
    |> String.at(rand_pos)
    |> rand_str(str, alphabet, size - 1)
  end

  @doc """
  Generate random string

  ## Examples

      iex> GenerateCsv.new_line()
      "31494,yezk 81,vppym"

  """
  @spec new_line() :: String.t()
  def new_line() do
    # Generate id
    id = :rand.uniform(100000)

    # Generate randon room number
    room_number = rand_str(6, :alphanumerical)

    # Set pool of class names
    class_name_pool = ["english 008", "portuguese 009", "math 001", "spanish 003"]

    # Set the size of names pool
    size = class_name_pool
    |> Enum.count
    |> Kernel.-(1)

    # Select class name
    class_name = class_name_pool
    |> Enum.at(:rand.uniform(size))

    # Join everything in one line
    Enum.join([id, class_name, room_number], ",")
  end
end
