import Rails from "@rails/ujs"
import GMaps from 'gmaps/gmaps.js';
import { Controller } from "stimulus";

var mapElement = document.getElementById('map');
var map;

export default class extends Controller {
  static targets = ['form', 'select'];

  connect = () => {
    this.initGoogleMaps();
  }

  initGoogleMaps() {
    const mapElement = document.getElementById('map');
    if (mapElement) {
      map = new GMaps({ el: '#map', lat: 0, lng: 0 });
      const markers = JSON.parse(mapElement.dataset.markers);
      map.addMarkers(markers);
      if (markers.length === 0) {
        map.setZoom(2);
      } else if (markers.length === 1) {
        map.setCenter(markers[0].lat, markers[0].lng);
        map.setZoom(16);
      } else {
        map.setCenter(markers[0].lat, markers[0].lng);
        map.setZoom(16);
      }
    }
  }

  filter(e) {
    const select = this.selectTarget.value
    Rails.fire(this.formTarget, 'submit')
  }

  result(e) {
    const data = e.detail[0].body.querySelector('#map').dataset.markers
    if (data.length > 0 ) {
      const markers = JSON.parse(data);
      map.removeMarkers();
      map.addMarkers(markers)
    }
  }

  error(e) {
    console.log('error::', e);
  }
}
