((function(){var a;$(function(){return $("#submit").click(a)}),a=function(){var a;return a={longitude:$("#longitude").val(),latitude:$("#latitude").val()},$.post("/tweets/closest_tweets",a,function(a){return $("#tweet_container").html(a)})}})).call(this);