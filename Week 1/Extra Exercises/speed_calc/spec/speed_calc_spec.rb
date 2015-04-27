require 'rspec'
require 'speed_calc'

describe 'speed_calc' do
  it 'returns speed required to travel a given number of miles in the given number of hours' do
    expect(speed_calc 65, 1).to(eq '65 MPH' )
    expect(speed_calc 20, 3).to(eq '7 MPH')
    expect(speed_calc 42, 24).to(eq '2 MPH')
    expect(speed_calc 40, 0.33).to(eq '121 MPH')
    expect(speed_calc 58, 0.83).to(eq '70 MPH')
  end
end
