defmodule SpaceAge do
  @type planet :: :mercury | :venus | :earth | :mars | :jupiter
                | :saturn | :neptune | :uranus

  @seconds_in_day 60*60*24
  @days_in_year 365

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.
  """
  @spec age_on(planet, pos_integer) :: float
  def age_on(planet, seconds) do
    seconds/_get_orbit_period(planet)
  end

  defp _get_orbit_period(:mercury), do: 87.97 * @seconds_in_day
  defp _get_orbit_period(:venus), do: 224.68 * @seconds_in_day
  defp _get_orbit_period(:earth), do: 365.26 * @seconds_in_day
  defp _get_orbit_period(:mars), do: 686.98 * @seconds_in_day
  defp _get_orbit_period(:jupiter), do: 11.862 * @days_in_year * @seconds_in_day
  defp _get_orbit_period(:saturn), do: 29.456 * @days_in_year * @seconds_in_day
  defp _get_orbit_period(:uranus), do: 84.07 * @days_in_year * @seconds_in_day
  defp _get_orbit_period(:neptune), do: 164.81 * @days_in_year * @seconds_in_day

end
