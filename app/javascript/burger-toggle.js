const burgerIcon = document.querySelector('#burger')
const navbarMenu = document.querySelector('#nav-links')

function registerBurgerToggle() {
  burgerIcon.addEventListener('click', (event) => {
    navbarMenu.classList.toggle('is-active');
    burgerIcon.classList.toggle('is-active');
  });  
};

registerBurgerToggle();