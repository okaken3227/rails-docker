# ベースイメージとして公式のRubyイメージを使用
FROM ruby:3.2.2

# 必要なパッケージをインストール
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# 作業ディレクトリを設定
WORKDIR /myapp

# GemfileとGemfile.lockをコピー
COPY Gemfile Gemfile.lock ./

# Bundlerをインストール
RUN gem install bundler -v 2.4.10
RUN bundle install

# アプリケーションのソースコードをコピー
COPY . .

# 追加の設定（必要に応じて）
ENV RAILS_ENV=development
ENV RAILS_LOG_TO_STDOUT=true

# ポートを公開
EXPOSE 3000

# サーバーを起動
CMD ["bin/rails", "server", "-b", "0.0.0.0"]