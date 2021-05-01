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
// フェードイン処理ここまで

// アコーディオンの処理
document.addEventListener('DOMContentLoaded', () => {
  const accordionTrigger = document.querySelectorAll('.js-accordion-trigger');

  for (let i = 0; i < accordionTrigger.length; i++) {
      if(accordionTrigger[i].classList.contains('is-opened')) {
          accordionTrigger[i].nextElementSibling.style.height = accordionTrigger[i].nextElementSibling.scrollHeight + 'px';
      }

      accordionTrigger[i].addEventListener('click', (e) => {
          let currentElement = e.currentTarget;
          let accordionTarget = currentElement.nextElementSibling;
          if (accordionTarget.style.height) {
              currentElement.classList.remove('is-opened');
              accordionTarget.style.height = null;
          } else {
              currentElement.classList.add('is-opened');
              accordionTarget.style.height = accordionTarget.scrollHeight + 'px';
          }
      });
  }
});
// アコーディオン処理ここまで