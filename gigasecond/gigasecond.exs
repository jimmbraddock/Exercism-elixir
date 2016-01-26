defmodule Gigasecond do

    @gigasecond 1000000000

	@doc """
	Calculate a date one billion seconds after an input date.
	"""
	@spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) :: :calendar.datetime

	def from(date) do
        @gigasecond + :calendar.datetime_to_gregorian_seconds(date)
        |> :calendar.gregorian_seconds_to_datetime()
	end
end
