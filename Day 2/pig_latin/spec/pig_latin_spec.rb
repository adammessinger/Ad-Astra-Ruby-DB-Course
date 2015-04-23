require('rspec')
require('pig_latin')

describe('pig_latin') do
  it('adds "ay" to the end of words') do
    expect(pig_latin('adam')).to(eq('adamay'))
    expect(pig_latin('eve')).to(eq('eveay'))
    expect(pig_latin('ivy')).to(eq('ivyay'))
    expect(pig_latin('oscar')).to(eq('oscaray'))
    expect(pig_latin('ursa')).to(eq('ursaay'))
  end

  it('moves initial consonants to the end of the word') do
    expect(pig_latin('gina')).to(eq('inagay'))
  end
end
