import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  if (document.querySelector("#banner-typed-text")) {
    new Typed('#banner-typed-text', {
      strings: ["Connect with other players and", "meet at your favourite places!"],
      typeSpeed: 50,
      loop: false
    });
  };
}

export { loadDynamicBannerText };