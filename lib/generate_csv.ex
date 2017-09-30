defmodule GenerateCsv do
  @moduledoc """
        Documentation for GenerateCsv.
  """

  @doc """
  Hello world.

  ## Examples

      iex> GenerateCsv.hello
      :world

  """

  def create(count) do
      # set random seed
      :random.seed(:erlang.now())

      # showd create a array with each line of CSV format {id, course name, room number}
      create([], count)
  end

  defp create(list, 0) do
    list
  end

  defp create(list, count) do
    create([new_line() | list], count - 1)
  end

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
