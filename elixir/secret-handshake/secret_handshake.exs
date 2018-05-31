defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    code_list = Integer.digits(code, 2)
    code_length = length(code_list)

    # setting up the different lists of one elements that can be added to eachother
    handshake_list = []
    first_shake = ["wink"]
    second_shake = ["double blink"]
    third_shake = ["close your eyes"]
    fourth_shake = ["jump"]

    # variables for setting each part of the hand shake to be true of false
    wink = false
    double_blink = false
    close_eyes = false
    jump = false
    reverse = false

    # if a certain binary is present, set to true
    wink = if Enum.at(code_list, code_length - 1) == 1, do: true
    double_blink = if Enum.at(code_list, code_length - 2) == 1, do: true
    close_eyes = if Enum.at(code_list, code_length - 3) == 1, do: true
    jump = if Enum.at(code_list, code_length - 4) == 1, do: true
    reverse = if Enum.at(code_list, code_length - 5) == 1, do: true

    # if statements which build up the list
    if length(code_list) >= 1 && wink,
      do: handshake_list = handshake_list ++ first_shake

    if length(code_list) >= 2 && double_blink,
      do: handshake_list = handshake_list ++ second_shake

    if length(code_list) >= 3 && close_eyes,
      do: handshake_list = handshake_list ++ third_shake

    if length(code_list) >= 4 && jump,
      do: handshake_list = handshake_list ++ fourth_shake

    if length(code_list) >= 5 && reverse,
      do: handshake_list = Enum.reverse(handshake_list)

    # final if statement that determines if the handshake list is returned

    if length(code_list) == 0 do
    else
      handshake_list
    end
  end
end

# Geordie
