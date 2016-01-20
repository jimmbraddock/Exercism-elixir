defmodule Phone do

  @valid_number_ex ~r/^(?<country_code>\d{3})(?<exchange_code>\d{3})(?<line_code>\d{4})$/

  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("123-456-7890")
  "1234567890"

  iex> Phone.number("+1 (303) 555-1212")
  "3035551212"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t) :: String.t
  def number(raw) do
    raw |> clean |> trim_country_code |> valid_number
  end

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("123-456-7890")
  "123"

  iex> Phone.area_code("+1 (303) 555-1212")
  "303"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t) :: String.t
  def area_code(raw) do
    raw |> clean |> trim_country_code |> String.slice(0..2)
  end

  defp clean(num) do
    String.replace(num, ~r/[\(\)-\.\s]/, "")
  end

  defp trim_country_code(number) do
    if has_country_code?(number) do
      Regex.named_captures(~r/^1(?<country_code>\d{10}+)$/, number)["country_code"]
    else
      number
    end
  end

  defp valid_number(num) do
    if String.length(num) != 10 do
      "0000000000"
    else
      num
    end
  end

  defp has_country_code?(number) do
    String.length(number) == 11 &&
    String.starts_with?(number, "1")
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("123-456-7890")
  "(123) 456-7890"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t) :: String.t
  def pretty(raw) do
    phone = number(raw)
    num = Regex.named_captures(@valid_number_ex, phone)
    "(#{num["country_code"]}) #{num["exchange_code"]}-#{num["line_code"]}"
  end
end
