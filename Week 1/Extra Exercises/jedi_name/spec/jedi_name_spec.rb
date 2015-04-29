require 'rspec'
require 'jedi_name'

describe 'jedi_name' do
  it 'returns a Jedi Name based on parts of first name, first pet name, and birth city' do
    expect(jedi_name 'Jordan', 'Jenkins', 'Panama City').to(eq 'Sniknad Jorjen of planet Ytic')
    expect(jedi_name 'Lauren', 'Cherry', 'Tucson').to(eq 'Yrner Laurcher of planet Noscut')
    expect(jedi_name 'Levi', 'Bryce', 'Wichita').to(eq 'Eciv Levbryc of planet Atihciw')
    expect(jedi_name 'Allyson', 'Theodore', 'Pensacola').to(eq 'Ernos Altheod of planet Alocasnep')
    expect(jedi_name 'Al', 'Ted', 'Prue').to(eq 'Detla Alted of planet Eurp')
    expect(jedi_name 'Brandy', 'Mookie', 'Saskatchewan').to(eq 'Eikyd Branmook of planet Nawehctaksas')
  end

  it 'strips leading and trailing whitespace from inputs' do
    expect(jedi_name ' Jordan ', ' Jenkins ', ' Panama City ').to(eq 'Sniknad Jorjen of planet Ytic')
    expect(jedi_name "\n\nAl\r\n", "\t\vTed   ", "\f\ePrue\n  \n").to(eq 'Detla Alted of planet Eurp')
  end
end
