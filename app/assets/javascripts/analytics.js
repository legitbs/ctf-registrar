var _gaq = _gaq || [];
_gaq.push(['_setAccount', 'UA-60'+'5807-18']);

jQuery(function($){
  _gaq.push(['_setCustomVar', 1, 'Username', $('meta[name=legitbsusername]').attr('value'), 2]);
  _gaq.push(['_trackPageview']);
  var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
  ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
  var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
})
