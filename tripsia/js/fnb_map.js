mapboxgl.accessToken = "pk.eyJ1IjoiamRlc2lnbmVyYSIsImEiOiJjazVwMDBrNGkxYmU0M2RxcDJmcmZ3amN3In0.GwmfZFOXKAzvlF7qejj5lg";

let geoLoc = new mapboxgl.GeolocateControl({
    positionOptions: {
        enableHighAccuracy: true
    },
    trackUserLocation: true
});

$(document).ready(function () {
    let currCoords;
    let map = new mapboxgl.Map({
        container: "map",
        style: "mapbox://styles/mapbox/streets-v10",
        center: [103.8, 1.3],
        zoom: 16.5,
        pitch: 45,
        bearing: -17.6,
        antialias: true
    });

    map.addControl(geoLoc);

    map.addControl(new mapboxgl.NavigationControl());

    map.on('load', function () {
        geoLoc.trigger();

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

    geoLoc.on('geolocate', function (e) {
        currCoords = [e.coords.longitude, e.coords.latitude];

        map.jumpTo({
            center: currCoords
        });
    });

    geoLoc.on('error', function () {
        toastDanger(
            'Either you did not allow us to know your location or your browser does not support it.',
            'CANNOT GET YOUR CURRENT LOCATION',
            -1
        );

        // ToDo: May need to update
        $(locClientId).removeAttr('value');
        $(locClientId).next().removeClass('active');
    });

    $('button[data-role="zoomCurrLoc"]').on('click', function () {
        if ($(locClientId).val() == 'Current Location') {
            map.flyTo({
                center: currCoords,
                zoom: 16.5,
                pitch: 45,
                bearing: -17.6,
            });
        }
        else if ($(locClientId).val() && $(locClientId).val() != 'Current Location') {
            /* ToDo: Manual location from location input
            map.flyTo({
                center: currCoords,
                zoom: 16.5,
                pitch: 45,
                bearing: -17.6,
            });
            */
        }
    });
});