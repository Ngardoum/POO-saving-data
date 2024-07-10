# mon_projet/spec/saver_spec.rb
require 'spec_helper'

RSpec.describe Saver do
  let(:emails) { [{ ville: "Argenteuil", email: "mairie@argenteuil.fr" }] }

  describe '#save_as_JSON' do
    it 'saves the data to a JSON file' do
      saver = Saver.new('db/test_emails.json')
      saver.save_as_JSON(emails)

      content = File.read('db/test_emails.json')
      data = JSON.parse(content)
      expect(data).to eq(emails.map(&:stringify_keys))
    end
  end

  describe '#save_as_csv' do
    it 'saves the data to a CSV file' do
      saver = Saver.new('db/test_emails.csv')
      saver.save_as_csv(emails)

      content = CSV.read('db/test_emails.csv', headers: true)
      expect(content['Ville'][0]).to eq(emails[0][:ville])
      expect(content['Email'][0]).to eq(emails[0][:email])
    end
  end
end
