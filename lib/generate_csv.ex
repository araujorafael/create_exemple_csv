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

      # showd create a array with each line of CSV format {id, course name, room number}
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

    rand_str(size, "", alphabet)
  end

  defp rand_str(0, str, _alphabet) do
    str
  end

  defp rand_str(size, str, alphabet) do
    rand_pos = :rand.uniform( String.length(alphabet) )
    new_char = String.at(alphabet, rand_pos)
    rand_str(size - 1, "#{str}#{new_char}", alphabet)
  end

  @doc """
  Generate random string

  ## Examples

      iex> GenerateCsv.new_line()
      "31494,yezk 81,vppym"

  """
  @spec new_line() :: String.t()
  def new_line() do
    # id
    id = :rand.uniform(100000)
    # rand_room_number
    room_number = rand_str(6, :alphanumerical)
    # course name
    course_name = "#{rand_str(4, :char)} #{:rand.uniform(1000)}"

    Enum.join([id, course_name, room_number], ",")
  end
end
