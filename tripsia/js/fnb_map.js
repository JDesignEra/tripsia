$(document).ready(function () {
    mapboxgl.accessToken = "pk.eyJ1IjoiamRlc2lnbmVyYSIsImEiOiJjazVwMDBrNGkxYmU0M2RxcDJmcmZ3amN3In0.GwmfZFOXKAzvlF7qejj5lg";

    let map = new mapboxgl.Map({
        container: "map",
        style: "mapbox://styles/mapbox/streets-v11",
        center: [103.8, 1.3],
        zoom: 15.5,
        pitch: 45,
        bearing: -17.6,
        antialias: true
    });

    map.on('load', function () {
        let layers = map.getStyle().layers;
        let labelLayerId;

        for (var i = 0; i < layers.length; i++) {
            if (layers[i].type === 'symbol' && layers[i].layout['text-field']) {
                labelLayerId = layers[i].id;
                break;
            }
        }

        map.addLayer(
            {
                'id': '3d',
                'source': 'composite',
                'source-layer': 'building',
                'filter': ['==', 'extrude', 'true'],
                'type': 'fill-extrusion',
                'minzoom': 15,
                'paint': {
                    'fill-extrusion-color': '#00bcd4',
                    'fill-extrusion-height': [
                        'interpolate',
                        ['linear'],
                        ['zoom'],
                        15,
                        0,
                        15.05,
                        ['get', 'height']
                    ],
                    'fill-extrusion-base': [
                        'interpolate',
                        ['linear'],
                        ['zoom'],
                        15,
                        0,
                        15.05,
                        ['get', 'min_height']
                    ],
                    'fill-extrusion-opacity': 0.6
                }
            },
            labelLayerId
        );
    });
});