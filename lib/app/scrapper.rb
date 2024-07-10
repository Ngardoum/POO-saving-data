# mon_projet/lib/app/scrapper.rb
require 'nokogiri'
require 'open-uri'

class Scrapper
  def initialize(url)
    @url = url
  end

  def scrap_mairie_ville
    html = URI.open(@url)
    doc = Nokogiri::HTML(html)

    mairie_ville = doc.xpath('//*[@id="mairie"]').text.strip
    mairie_email = doc.xpath('//*[@id="mairie_content"]/div[2]/p[8]/a').text.strip

    { ville: mairie_ville, email: mairie_email }
  end
end

