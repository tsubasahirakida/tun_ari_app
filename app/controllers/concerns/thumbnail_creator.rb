class ThumbnailCreator
  require 'mini_magick'

  GRAVITY = 'center'.freeze
  FONT_SIZE = 30
  TEXT_POSITION = '160,0'.freeze
  FONT = './app/assets/fonts/ロゴたいぷゴシック.otf'.freeze
  INDENTION_COUNT = 15
  ROW_LIMIT = 10

  class << self
    def build(body, character_id)
      body = prepare_text(body)
      image = MiniMagick::Image.open("./app/assets/images/#{character_id}.png")
      image.combine_options do |config|
        config.font FONT
        config.fill 'black'
        config.gravity GRAVITY
        config.pointsize FONT_SIZE
        config.draw "text #{TEXT_POSITION} '#{body}'"
      end
    end

    private

    def prepare_text(text)
      text.to_s.scan(/.{1,#{INDENTION_COUNT}}/)[0...ROW_LIMIT].join("\n")
    end
  end
end
