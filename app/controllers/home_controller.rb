require 'nokogiri'
require 'open-uri'

class HomeController < ApplicationController

  def index
    @games = Game.all
  end

  def refresh
    parse_page
    redirect_to root_url
  end

  private

  def parse_page
    base_url = 'https://www.jbhifi.com.au/games-consoles/games/nintendo-switch/'
    param = '?p='
    selector = '//div[@id="productsContainer"]//div[@data-productid]'
    doc = Nokogiri::HTML(open(base_url))
    last = last_page(doc)
    # For each page
    (1..last).each do |i|
      url = base_url + param + i.to_s
      doc = Nokogiri::HTML(open(url))
      games = doc.xpath(selector)
      parse_games(games)
    end
  end

  # Get the number of pages to parse
  def last_page(doc)
    last_page_link = doc.at_css('a[@class="nextLnk"]')['href']
    CGI.parse(URI.parse(last_page_link).query)['p'][0].to_i
  end

  # Parse the games and save to model
  def parse_games(games)
    games.each do |game|
      doc = Nokogiri::HTML(game.to_s)
      id = doc.at_xpath('//div[@data-productid]')['data-productid']
      name = doc.at_xpath('//h4[@title]').text
      price = doc.at_xpath('//span[@class="amount regular"]').text.delete('^[0-9.]')
      save_game(id, name, price)
    end
  end

  # Save game/price to DB
  def save_game(id, name, price)
    return if id.nil? || name.nil? || price.nil?

    @game = Game.find_by(id: id)
    if @game.nil?
      # Game does not exist, create a new game and price
      @new = Game.new(id: id, name: name)
      @new.save
      @new.prices.create(amount: price)
    else
      # Add a new price
      @game.prices.last.amount
      @game.prices.create(amount: price) unless @game.prices.last.amount == price
    end
  end

end