import "jquery-bar-rating";
import $ from 'jquery'; // <-- if you're NOT using a Le Wagon template (cf jQuery section)

const initStarRating = () => {
  $('#review_rating').barrating({
    theme: 'css-stars'
  });
  const reviewStars = document.querySelectorAll('.review-rating')
  if(reviewStars){
    reviewStars.forEach((review) => {
      let value = review.dataset.rating
      let id = review.dataset.id
      $(`#review-${id}`).barrating({
        theme: 'css-stars',
        readonly: true,
        initialRating: value,
        allowEmpty: null
      });
    })
  }
};

export { initStarRating };
