$(document).ready(init)

var audio;
var list;
var tracks;
var current;

function init(){

  current = 0;
  audio = $('#audio');
  list = $('#playlist');
  tracks = list.find('li span a');
  len = tracks.length - 1;
  audio[0].volume = .50;
  audio[0].play();
  list.find('a').click(function(e){
    e.preventDefault();
    link = $(this);
    current = link.parent().index();
    run(link, audio[0]);
  });
  audio[0].addEventListener('ended', function(e){
    current++;
    if(current == len){
      current = 0;
      link = list.find('a')[0];
    }else{
      link = list.find('a')[current];
    }
    run($(link),audio[0]);
  });
}

function run(link, player){
  player.src = link.attr('href');
  par = link.parent();
  par.addClass('active').siblings().removeClass('active');
  audio[0].load();
  audio[0].play();
}
