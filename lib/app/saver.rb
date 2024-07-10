# mon_projet/lib/app/saver.rb
require 'json'
require 'csv'
require 'google_drive'
require 'dotenv/load'

class Saver
  def initialize(filepath)
    @filepath = filepath
  end

  def save_as_JSON(data)
    File.open(@filepath, 'w') do |file|
      file.write(JSON.pretty_generate(data))
    end
  end

  def save_as_csv(data)
    CSV.open(@filepath, 'wb') do |csv|
      csv << ["Ville", "Email"]
      data.each do |item|
        csv << [item[:ville], item[:email]]
      end
    end
  end

  def save_as_spreadsheet(data)
    session = GoogleDrive::Session.from_config("config.json")
    spreadsheet = session.spreadsheet_by_key("your_spreadsheet_key")
    worksheet = spreadsheet.worksheets[0]

    worksheet[1, 1] = "Ville"
    worksheet[1, 2] = "Email"
    data.each_with_index do |item, index|
      worksheet[index + 2, 1] = item[:ville]
      worksheet[index + 2, 2] = item[:email]
    end
    worksheet.save
  end
end
