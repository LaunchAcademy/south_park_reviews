$(function() {
  $('.vote-button').on('click', function (event) {
    event.preventDefault(); // Prevent link from following its href

    var $voteButton = $(event.currentTarget);
    var url = $voteButton.attr('href');

    $.ajax({
      type: 'POST',
      url: url,
      data: $.param({ vote_value: 1 }),
      dataType: 'json',
      success: AjaxSucceeded,
      error: AjaxFailed
    });

    function AjaxSucceeded(result) {
        var voteScore = result["vote_score"];
        var episodeID = result["id"];
        ++voteScore;
        $('#'+episodeID).html(voteScore);
        $('#'+episodeID).html(voteScore);
        // debugger;
    }

    function AjaxFailed(result) {
        alert("hello1");
        alert(result.status + ' ' + result.statusText);
    }
  });
});
