class TwController < ApplicationController
  def index


    client = Twitter::REST::Client.new do |config|
      config.consumer_key    = "Noz3qAnLXNChSJf6WNQzq1JGw"
      config.consumer_secret = "Rn0VLVXAlgmWl1ov4XwomKhuAKcPbgTKs2s6MYIR28m8xVMo7O"
    end

    nr_of_tweets=20
    @nr_of_tweets=nr_of_tweets

    if params[:nr_of_tweets]
      @nr_of_tweets=params[:nr_of_tweets]
      nr_of_tweets=params[:nr_of_tweets]
    end


    if params[:search]
      search_data=params[:search]
      @search_data=search_data
      @tweets =client.search(search_data, :result_type => "recent").take(nr_of_tweets.to_i)
    else
      @search_data=""
      @tweets =[]
    end

  end
end
