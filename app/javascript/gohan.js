// フェードインの処理
function fadeinEvent() {
  const fadeinClass= Array.prototype.slice.call(document.getElementsByClassName("fadein")); 
  fadeinClass.forEach(function( element ) {
      const boundingClientRect = element.getBoundingClientRect();
      const scroll = document.documentElement.scrollTop || document.body.scrollTop;
      const windowHeight = window.innerHeight;
      if (scroll > scroll + boundingClientRect.top - windowHeight + 150){
          element.style.opacity = "1";
          element.style.transform = "translateY(0)";
      }
  });
}
window.onload = function(){
  fadeinEvent();
  window.addEventListener('scroll', fadeinEvent, false);
}