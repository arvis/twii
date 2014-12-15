$(function() {
  console.log("page loaded");


$( "#older_pics" ).click(function (e) {
    // custom handling here
  e.preventDefault();
});


$( "#newer_pics" ).click(function (e) {

  var search_data=$( "#search_data" ).val();

  console.log(search_data);

  $.get( "/tw/earlier",{ search: "adidas" }, function( data ) {

    for ( var i = data.length-1; i >-1 ; i-- ) {

        $("#tweet_data").prepend('<img src="' +data[i]["pic"]+'"/></br>' );
    }

    e.preventDefault();
    e.stopPropagation();
    return false;

  });

  e.preventDefault();
  e.stopPropagation();
  return false;
});





});

