require 'integration_helper'
require 'spec_helper'
require_relative '../../dominio/podcast'

describe Podcast do
  it 'deberia crear un podcast' do
    podcast = described_class.new('Caja Negra', 'Filo.news', 2020, 1)
    expect(podcast).to be_a(described_class)
  end
end
