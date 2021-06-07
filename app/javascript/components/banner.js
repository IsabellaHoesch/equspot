import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  new Typed('#banner-typed-text', {
    strings: ["Find your favourite places", "Organize them", "Enjoy outdoor activities"],
    typeSpeed: 50,
    loop: true
  });
}

export { loadDynamicBannerText };