require('rspec')
require('luck_check')

describe('luck_check') do
  it('returns true if the sum of both halves are equal') do
    expect(luck_check('003111')).to(eq(true))
    expect(luck_check('813372')).to(eq(true))
    expect(luck_check('56328116')).to(eq(true))
  end

  it('returns false if the sum of both halves are not equal') do
    expect(luck_check('004111')).to(eq(false))
    expect(luck_check('813328')).to(eq(false))
    expect(luck_check('56328117')).to(eq(false))
  end

  it('ignores the middle character for strings of odd length') do
    expect(luck_check('17935')).to(eq(true))
    expect(luck_check('17939')).to(eq(false))
  end
end
