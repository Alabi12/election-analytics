class VoteChannel < ApplicationCable::Channel
  def subscribed
    # You can stream from a specific channel related to the constituency or election
    stream_from "vote_#{params[:election_id]}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
