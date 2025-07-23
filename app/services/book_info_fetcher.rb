# frozen_string_literal: true

class BookInfoFetcher
  def self.fetch(isbn)
    require "net/http"
    require "json"
    require "uri"

    cover_url = nil

    # Step 1: OpenBDで取得
    openbd_url = URI.parse("https://api.openbd.jp/v1/get?isbn=#{isbn}")
    response = Net::HTTP.get(openbd_url)
    data = JSON.parse(response).first

    if data
      title = data.dig("summary", "title")
      author = data.dig("summary", "author")
      cover_url = data.dig("summary", "cover")
    end

    # Step 2: OpenBDで表紙URLが取れなかった場合 → NDLサーチのURLを試す
    if cover_url.blank?
      ndl_url = "https://ndlsearch.ndl.go.jp/thumbnail/#{isbn}.jpg"

      # HTTPで存在確認
      ndl_uri = URI.parse(ndl_url)
      res = Net::HTTP.get_response(ndl_uri)

      cover_url = ndl_url if res.is_a?(Net::HTTPSuccess)
    end

    # Step 3: それでも無ければダミー画像
    cover_url = "https://dummyimage.com/180x265/cccccc/000000&text=No+Image" if cover_url.blank?

    {
      title: title || "タイトル不明",
      author: author || "著者不明",
      cover: cover_url
    }
  end
end
