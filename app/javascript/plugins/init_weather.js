

const weatherApi = () => {
  const weather = document.querySelector("#weather");

  if (weather) {
    fetch(`https://api.openweathermap.org/data/2.5/weather?lat=${weather.dataset.latitude}&lon=${weather.dataset.longitude}&appid=${weather.dataset.apikey}`) // insert place.latitude, place.longitude and WEATHER_API_KEY
    .then(response => response.json())
    .then((data) => {
      console.log(data);
      const weatherInfo = `Weather in ${data.name}: ${data.weather[0].description}, ${Math.round(data.main.temp - 273.15)} degrees`;
      weather.insertAdjacentHTML("beforeend", weatherInfo);
    });
  };
}

export { weatherApi };