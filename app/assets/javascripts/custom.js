$(function() {
  $('.vote-button').on('click', function (event) {
    event.preventDefault(); // Prevent link from following its href

    var $voteButton = $(event.currentTarget);
    var url = $voteButton.attr('href');
    // console.log(url);
    // var voteValue = url.split('/').slice(-1)[0];
    console.log(url);
    // alert(url);

    $.ajax({
      alert(url),
      type: 'PUT',
      url: url,
      debugger;
      data: $.param({vote_value: 1 })
    });
  });
});
