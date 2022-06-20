$(document).on('turbolinks:load', function () {
  if ($('.user-exam').length > 0) {
    function timeConvert(num) {
      var minutes = num % 60;
      return minutes + ':' + '00';
    }
    var timer2 = timeConvert($('#duration').val());
    var interval = setInterval(function () {
      var timer = timer2.split(':');
      var minutes = parseInt(timer[0], 10);
      var seconds = parseInt(timer[1], 10);
      --seconds;
      minutes = seconds < 0 ? --minutes : minutes;
      seconds = seconds < 0 ? 59 : seconds;
      seconds = seconds < 10 ? '0' + seconds : seconds;
      $('.countdown').html(minutes + ':' + seconds);
      timer2 = minutes + ':' + seconds;
      if (window.location.pathname == '/en/exams') clearInterval(interval);
      if (seconds <= 0 && minutes <= 0) clearInterval(interval);
      if (timer2 == '0:00') {
        $('.submit-exam').click();
      }
    }, 1000);
  }
});
