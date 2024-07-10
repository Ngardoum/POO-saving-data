require_relative 'lib/app/scrapper'
require_relative 'lib/app/saver'

def main
  url = 'https://www.annuaire-mairie.fr/ville-argenteuil.html'
  scrapper = Scrapper.new(url)
  mairie_data = scrapper.scrap_mairie_ville

  emails = [mairie_data]

  json_saver = Saver.new('db/emails.json')
  json_saver.save_as_JSON(emails)

  csv_saver = Saver.new('db/emails.csv')
  csv_saver.save_as_csv(emails)

  spreadsheet_saver = Saver.new(nil)
  spreadsheet_saver.save_as_spreadsheet(emails)
end

main if __FILE__ == $0
