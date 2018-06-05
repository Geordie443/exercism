defmodule SpaceAge do
  # defining a new planet type
  @type planet ::
          :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune

  # associating each planet atom with a time conversion
  @conversion %{
    mercury: 0.2408467,
    venus: 0.61519726,
    earth: 1,
    mars: 1.8808158,
    jupiter: 11.862615,
    saturn: 29.447498,
    uranus: 84.016846,
    neptune: 164.79132
  }

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.
  """
  @spec age_on(planet, pos_integer) :: float
  def age_on(planet, seconds) do
    # the number of seconds in a year
    seconds_in_earth_year = 31_557_600
    # the number of years based on seconds input
    years = seconds / seconds_in_earth_year
    # the earth years devided by the conversion factor of the planet being compared
    age = years / @conversion[planet]
    # returns the age on the planet being converted to
    age
  end
end

# Geordie 
