defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
      :monday | :tuesday | :wednesday
    | :thursday | :friday | :saturday | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date
  def meetup(year, month, weekday, :first) do
    _date(_int_weekday(weekday), {year, month, 1})
  end
  def meetup(year, month, weekday, :second) do
    _date(_int_weekday(weekday), {year, month, 8})
  end
  def meetup(year, month, weekday, :third) do
    _date(_int_weekday(weekday), {year, month, 15})
  end
  def meetup(year, month, weekday, :fourth) do
    _date(_int_weekday(weekday), {year, month, 22})
  end
  def meetup(year, month, weekday, :last) do
    first_day_last_week = :calendar.last_day_of_the_month(year, month) - 6
    _date(_int_weekday(weekday), {year, month, first_day_last_week})
  end
  def meetup(year, month, weekday, :teenth) do
    _date(_int_weekday(weekday), {year, month, 13})
  end

  defp _date(num_day, date={year, month, day}) do
    if :calendar.day_of_the_week(date) == num_day do
      date
    else
      _date(num_day, {year, month, day + 1})
    end
  end

  defp _int_weekday(:monday), do: 1
  defp _int_weekday(:tuesday), do: 2
  defp _int_weekday(:wednesday), do: 3
  defp _int_weekday(:thursday), do: 4
  defp _int_weekday(:friday), do: 5
  defp _int_weekday(:saturday), do: 6
  defp _int_weekday(:sunday), do: 7

end
