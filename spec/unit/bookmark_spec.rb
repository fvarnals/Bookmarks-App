require './app/models/bookmark.rb'
require 'database_helpers'

describe Bookmark do

  describe "#list" do
    it "displays the list of saved bookmarks" do
      #connection = PG.connect(dbname: 'bookmark_manager_test')
      bookmark = Bookmark.create(url: 'http://www.makersacademy.com', title: "Makers Academy")
      Bookmark.create(url: 'http://www.destroyallsoftware.com', title: "Destroy Software")
      Bookmark.create(url: 'http://www.google.com', title: "Google")
      bookmarks = Bookmark.list
      expect(bookmarks.length).to eq 3
      expect(bookmarks.first).to be_a Bookmark
      expect(bookmarks.first.id).to eq bookmark.id
      expect(bookmarks.first.title).to eq 'Makers Academy'
      expect(bookmarks.first.url).to eq 'http://www.makersacademy.com'
    end
  end

  describe "#create" do
    context "when a user adds a bookmark" do
      it "saves it to the database" do
        bookmark = Bookmark.create(url: 'www.stackoverflow.com', title: 'Coding Forum')
        persisted_data = persisted_data(id: bookmark.id)

        expect(bookmark).to be_a Bookmark
        expect(bookmark.id).to eq persisted_data['id']
        expect(bookmark.url).to eq 'www.stackoverflow.com'
        expect(bookmark.title).to eq 'Coding Forum'
      end
    end
  describe "#delete" do
      it "removes a bookmark from the database" do
        bookmark = Bookmark.create(url: 'www.stackoverflow.com', title: 'Coding Forum')

        Bookmark.delete(id: bookmark.id)

        expect(Bookmark.list.length).to eq 0
      end
    end
  end
end
