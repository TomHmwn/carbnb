import { Controller } from "@hotwired/stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }
  connect() {

    console.log("connected")
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      // style: "mapbox://styles/georgekettle/cleow2ltz000001qp1430ze85",
      style: 'mapbox://styles/mapbox/satellite-streets-v12',
    })
    this.map.addControl(
      new mapboxgl.NavigationControl());

    this.#addMarkersToMap()
    this.#fitMapToMarkers()

    // Add search controls
    this.map.addControl(new MapboxGeocoder({
      accessToken: mapboxgl.accessToken,
      mapboxgl: mapboxgl
    }))
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      console.log(marker)
      const popup = new mapboxgl.Popup().setHTML(marker.info_window_html) // Add
      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(this.map)
    })
  }
  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 150, maxZoom: 15, duration: 0 })
  }
}
