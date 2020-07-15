require_relative '../lib/article_processor.rb'

describe ArticlesProcessor do
  context 'url_change' do
    it 'change the url' do
      article = ArticlesProcessor.new('heart')
      article.url_change
      expect(article.page).to eq 2
    end
  end

  context 'articles_hash' do
    it 'return an array' do
      article = ArticlesProcessor.new('heart')
      article.articles_hash(article.parsed_page)
      expect(article.article_information[0]).to be_a(Hash)
    end
  end

  context 'articles_info' do
    it 'return 45 arrays' do
      article = ArticlesProcessor.new('heart')
      article.articles_info
      expect(article.article_information.length.to_i).to eq 45
    end
  end
end
