import consumer from "./consumer"

consumer.subscriptions.create({ channel: "VoteChannel", election_id: electionId }, {
  received(data) {
    // Update the vote count on the page in real-time
    const voteElement = document.querySelector(`#candidate_${data.candidate_id}_votes`);
    if (voteElement) {
      voteElement.innerText = data.vote_count;
    }
  }
});
