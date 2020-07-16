require_relative '../lib/article_processor.rb'

describe ArticlesProcessor do
  context 'url_change' do
    it 'change the url' do
      article = ArticlesProcessor.new('heart')
      article.url_change
      expect(article.page).to eq 2
      expect(article.from).to eq 16
    end
    it 'change the url second iteration' do
      article = ArticlesProcessor.new('heart')
      article.url_change
      article.url_change
      expect(article.page).to eq 3
      expect(article.from).to eq 31
    end
  end

  context 'articles_hash' do
    it 'return an array' do
      article = ArticlesProcessor.new('heart')
      article.articles_hash(article.parsed_page)
      expect(article.article_information[0]).to be_a(Hash)
    end
    it 'return the link' do
      article = ArticlesProcessor.new('heart')
      article.articles_hash(article.parsed_page)
      expected = 'http://www.scielo.br/scielo.php?script=sci_arttext&pid=S0034-71672020000500154&lang=en'
      expect(article.article_information[0][:link=]).to eq expected
    end
  end

  context 'articles_info' do
    it 'return 45 arrays' do
      article = ArticlesProcessor.new('heart')
      article.articles_info
      expect(article.article_information.length.to_i).to eq 45
    end
    it 'return the title of 34th article' do
      article = ArticlesProcessor.new('heart')
      article.articles_info
      short = 'Detoxification effects of long-chain versus a mixture of medium-'
      expected = "#{short} and long-chain triglyceride-based fat emulsion on propafenone poisoning"
      expect(article.article_information[33][:title=]).to eq expected
    end
  end
end
