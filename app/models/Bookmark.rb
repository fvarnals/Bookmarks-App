require 'pg'

class Bookmark

  attr_reader :id, :title, :url

  def initialize(id:, title:, url:)
    @id = id
    @title = title
    @url = url
  end

  def self.list
    result = connect_to_database.exec("SELECT * FROM bookmarks;")
    result.map do |bookmark|
      Bookmark.new(id: bookmark['id'], title: bookmark['title'], url: bookmark['url'])
    end
  end

  def self.create(url:, title:)
    result = connect_to_database.exec("INSERT INTO bookmarks (title, url) VALUES('#{title}', '#{url}') RETURNING id, url, title;").first
    Bookmark.new(id: result['id'], title: result['title'], url: result['url'])
  end

  def self.connect_to_database
    if ENV['ENVIRONMENT'] == 'test'
      connect_to_database = PG.connect(dbname: 'bookmark_manager_test')
    else
      connect_to_database = PG.connect(dbname: 'bookmark_manager')
    end
  end

end
