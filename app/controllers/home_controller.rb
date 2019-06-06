require 'nokogiri'
require 'open-uri'

# Home page, view the data or refresh and parse the JB Website
class HomeController < ApplicationController
  include HomeHelper
  before_action :last_update

  # Index/Homepage action
  def index
    @games = Game.all
  end

  # Get the last database refresh
  def last_update
    @refresh = Refresh.last
  end

  # Refresh the database and parse the JB Website
  def refresh
    unless allow_refresh?
      flash[:notice] = 'The page was refreshed recently, try again later.'
      redirect_back(fallback_location: root_path)
      return
    end
    parse_page
    Refresh.create
    redirect_to root_path
  end

  private

  # Parse the JB Hi fi website for Nintendo Switch games
  def parse_page
    base_url = 'https://www.jbhifi.com.au/games-consoles/games/nintendo-switch/'
    selector = '//div[@id="productsContainer"]//div[@data-productid]'
    doc = Nokogiri::HTML(open(base_url))
    last = last_page(doc)
    # For each page
    (1..last).each do |i|
      url = base_url + '?p=' + i.to_s
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
      link = doc.at_xpath('//a[@class="link"]')['href']
      price = doc.at_xpath('//span[@class="amount regular"]').text.delete('^[0-9.]')
      save_game(id, name, link, price.to_f)
    end
  end

  # Save game + price or price to DB
  def save_game(id, name, link, price)
    return if id.nil? || name.nil? || price.nil?

    @game = Game.find_by(id: id)
    if @game.nil?
      # Game does not exist, create a new game and price
      new_game(id, name, link, price)
    else
      new_price(@game, price)
    end
  end

  # Game does not exists, create a new game and price
  def new_game(id, name, link, price)
    @new = Game.new(id: id, name: name, link: link)
    @new.save
    @new.prices.create(amount: price)
  end

  # Add a new price
  def new_price(game, price)
    game.prices.last.amount
    game.prices.create(amount: price) unless @game.prices.last.amount == price
  end

end