# mon_projet/spec/scrapper_spec.rb
require 'spec_helper'

RSpec.describe Scrapper do
  let(:url) { 'https://www.annuaire-mairie.fr/ville-argenteuil.html' }
  let(:scrapper) { Scrapper.new(url) }

  describe '#scrap_mairie_ville' do
    it 'scrapes the city name and email' do
      result = scrapper.scrap_mairie_ville
      expect(result).to be_a(Hash)
      expect(result[:ville]).not_to be_empty
      expect(result[:email]).to match(/\A[^@\s]+@[^@\s]+\z/)
    end
  end
end
