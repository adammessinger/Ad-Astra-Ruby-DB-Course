require 'rspec'
require 'jedi_name'

describe 'jedi_name' do
  it 'returns a Jedi Name based on parts of first name, first pet name, and birth city' do
    expect(jedi_name 'Adam', 'Farley', 'Arkansas City').to(eq 'Yelmad Adfar of planet Ytic')
    expect(jedi_name 'Lauren', 'Scout', 'Palm Bay').to(eq 'Tuocner Laurscout of planet Yab')
    expect(jedi_name 'Levi', 'Bryce', 'Wichita').to(eq 'Eciv Levbryc of planet Atihciw')
    expect(jedi_name 'Allyson', 'Theodore', 'Pensacola').to(eq 'Ernos Altheod of planet Alocasnep')
    expect(jedi_name 'Al', 'Ted', 'Prue').to(eq 'Detla Alted of planet Eurp')
    expect(jedi_name 'Brandy', 'Mookie', 'Saskatchewan ').to(eq 'Eikyd Branmook of planet Nawehctaksas')
  end
end
