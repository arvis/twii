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

    since_processed=nil

    @tweets =[]

    if params[:search]
      search_data=params[:search]
      @search_data=search_data

      if params[:tweet_type]=="new"
        tweets_local =client.search(search_data, :result_type => "recent", :since_id => session[:since_id]).take(nr_of_tweets.to_i)
      elsif params[:tweet_type]=="old"
        tweets_local =client.search(search_data, :result_type => "recent", :max_id => session[:max_id]).take(nr_of_tweets.to_i)
      else
        tweets_local =client.search(search_data, :result_type => "recent").take(nr_of_tweets.to_i)
      end

      p params[:tweet_type]

      tweets_local.each do |tweet|
        if !tweet.media.empty?
          @tweets.push(tweet.media[0].media_uri)


          if params[:tweet_type]=="new"

            unless since_processed
              session[:since_id]=tweet.id
              since_processed=true
            end

          elsif params[:tweet_type]=="old"
            session[:max_id]=tweet.id
          elsif params[:tweet_type]=="first"
            unless since_processed
              session[:since_id]=tweet.id
              since_processed=true
            end
          end

        end 
      end
    else
      @search_data=""
    end

    #puts(@tweets[3].media[0].media_uri)


  end

  def latest

    client = Twitter::REST::Client.new do |config|
      config.consumer_key    = "Noz3qAnLXNChSJf6WNQzq1JGw"
      config.consumer_secret = "Rn0VLVXAlgmWl1ov4XwomKhuAKcPbgTKs2s6MYIR28m8xVMo7O"
    end

    since_processed=nil


    @tweets =[]
    search_data=params[:search]

    tweets_local =client.search(search_data, :result_type => "recent").take(20)

    <<-DOC
    if session[:since_id]
      tweets_local =client.search(search_data, :result_type => "recent", :since_id => session[:since_id]).take(20)
    else
      tweets_local =client.search(search_data, :result_type => "recent").take(nr_of_tweets.to_i)
    end
    DOC

    tweets_local.each do |tweet|
      if !tweet.media.empty?
        @tweets.push(tweet.media[0].media_uri)

        unless since_processed
          session[:since_id]=tweet.id
          since_processed=true
        end
      end

    end

    render json: @tweets
  end

  def earlier
  end

end
