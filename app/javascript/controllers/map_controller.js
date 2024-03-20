// app/javascript/controllers/map_controller.js
// import { Controller } from "@hotwired/stimulus"
// import mapboxgl from 'mapbox-gl' // Don't forget this!
// // import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';

// export default class extends Controller {
//   static values = {
//     apiKey: String,
//     markers: Array
//   }

//   connect() {
//     mapboxgl.accessToken = this.apiKeyValue;

//     this.map = new mapboxgl.Map({
//       container: this.element,
//       style: "mapbox://styles/mapbox/streets-v10"
//     })

//     this.#addMarkersToMap()
//     this.#fitMapToMarkers()
//   }

//   #addMarkersToMap() {
//     this.markersValue.forEach((marker) => {
//       const popup = new mapboxgl.Popup().setHTML(marker.info_window_html)

//       // Create a HTML element for your custom marker
//       const customMarker = document.createElement("div")
//       customMarker.innerHTML = marker.marker_html

//       // Pass the element as an argument to the new marker
//       new mapboxgl.Marker(customMarker)
//         .setLngLat([marker.lng, marker.lat])
//         .setPopup(popup)
//         .addTo(this.map)
//     })

//     // this.map.addControl(new MapboxGeocoder({ accessToken: mapboxgl.accessToken,
//     //   mapboxgl: mapboxgl }))

//     // this.map = new mapboxgl.Map({
//     //   container: this.element,
//     //   style: "mapbox://styles/pdunleav/cjofefl7u3j3e2sp0ylex3cyb" // <-- use your own!
//     // });
//   }
//   #fitMapToMarkers() {
//     const bounds = new mapboxgl.LngLatBounds()
//     this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
//     this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
//   }
// }
//   // #addMarkersToMap() {
//   //   this.markersValue.forEach((marker) => {
//   //     // Initialize a Mapbox Popup if info_window_html is provided
//   //     const popup = marker.info_window_html ? new mapboxgl.Popup().setHTML(marker.info_window_html) : null;

//   //     // Create a HTML element for your custom marker if marker_html is provided
//   //     const customMarker = document.createElement("div");
//   //     customMarker.className = 'custom-marker'; // Add a class for potential CSS styling
//   //     customMarker.innerHTML = marker.marker_html || ''; // Fallback to empty string if not provided

//   //     // Create and add the marker to the map
//   //     const mapMarker = new mapboxgl.Marker(customMarker)
//   //       .setLngLat([marker.lng, marker.lat])
//   //       .addTo(this.map);

//   //     // Attach the popup to the marker if it exists
//   //     if (popup) {
//   //       mapMarker.setPopup(popup);
//   //     }
//   //   });
//   // }

//   // #fitMapToMarkers() {
//   //   const bounds = new mapboxgl.LngLatBounds()
//   //   this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
//   //   this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
//   // }
// // }

// // import { Controller } from "@hotwired/stimulus";
// // import mapboxgl from "mapbox-gl";
// // import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder";

// // export default class extends Controller {
// //   static values = {
// //     apiKey: String,
// //     // Assuming addresses is an array of strings
// //     addresses: Array
// //   };

// //   connect() {
// //     mapboxgl.accessToken = this.apiKeyValue;

// //     this.map = new mapboxgl.Map({
// //       container: this.element,
// //       style: "mapbox://styles/mapbox/streets-v11"
// //     });

// //     this.addressesValue.forEach((address) => {
// //       this.geocodeAddress(address);
// //     });
// //   }

// //   geocodeAddress(address) {
// //     const geocoder = new MapboxGeocoder({
// //       accessToken: mapboxgl.accessToken,
// //       mapboxgl: mapboxgl,
// //     });

// //     geocoder.query(address, (err, data) => {
// //       if (data && data.features && data.features.length > 0) {
// //         const coords = data.features[0].center;
// //         new mapboxgl.Marker()
// //           .setLngLat(coords)
// //           .addTo(this.map);
// //       }
// //     });
// //   }
// // }

// // import { Controller } from "@hotwired/stimulus"
// // import mapboxgl from 'mapbox-gl'

// // export default class extends Controller {
// //   static values = {
// //     apiKey: String,
// //     addresses: Array
// //   }

// //   connect() {
// //     mapboxgl.accessToken = this.apiKeyValue

// //     this.map = new mapboxgl.Map({
// //       container: this.element,
// //       style: "mapbox://styles/mapbox/streets-v11"
// //     });

// //     this.addressesValue.forEach(address => {
// //       this.geocodeAddress(address);
// //     });
// //   }

// //   geocodeAddress(address) {
// //     const url = `https://api.mapbox.com/geocoding/v5/mapbox.places/${encodeURIComponent(address)}.json?access_token=${mapboxgl.accessToken}`;

// //     fetch(url)
// //       .then(response => response.json())
// //       .then(data => {
// //         console.log(data); // Log the full response
// //         if (data.features.length > 0) {
// //           const [lng, lat] = data.features[0].center;
// //           // Log to console to verify coordinates
// //           console.log(`Coordinates: ${lng}, ${lat}`);

// //           // Create a new marker and add it to the map
// //           new mapboxgl.Marker()
// //             .setLngLat([lng, lat])
// //             .addTo(this.map);

// //           // Center the map on the new marker and adjust zoom level
// //           this.map.flyTo({
// //             center: [lng, lat],
// //             zoom: 14 // Adjust the zoom level as necessary
// //           });
// //         }
// //       })
// //       .catch(error => console.log(error));
// //   }
// // }


import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    markers: Array,
    apiKey: String
  }

  connect() {
    console.log(this.markersValue)
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/satellite-streets-v12"
    })
    this.#addMarkersToMap()
    this.#fitMapToMarkers()
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window_html);

      const customMarker = document.createElement("div");
      customMarker.innerHTML = marker.marker_html;

      new mapboxgl.Marker(customMarker)
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(this.map)
    })
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 12, duration: 0 })
  }
}
