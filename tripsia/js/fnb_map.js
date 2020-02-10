let map;
let marker = null;
let geoLoc = new mapboxgl.GeolocateControl({
    positionOptions: {
        enableHighAccuracy: true
    },
    trackUserLocation: true
});

let directions = new MapboxDirections({
    accessToken: mapboxgl.accessToken,
    interactive: false,
    placeholderOrigin: 'From location'
});


let destCoords;
let currCoords;

$(document).ready(function () {
    map = new mapboxgl.Map({
        container: "map",
        style: "mapbox://styles/mapbox/streets-v10",
        center: [103.8, 1.3],
        zoom: 16.5,
        pitch: 45,
        bearing: -17.6,
        antialias: true
    });

    map.addControl(directions, 'top-left');

    map.addControl(geoLoc, 'bottom-right');

    map.addControl(new mapboxgl.NavigationControl(), 'bottom-right');

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

    setInterval(function () {
        if ($('.mapboxgl-user-location-dot').length > 0) {
            $('button[data-role="zoomCurrLoc').removeClass('d-none');
            $('button[data-role="setOriginCurrLoc"]').removeClass('d-none');
        }
        else {
            $('button[data-role="zoomCurrLoc').addClass('d-none');
            $('button[data-role="setOriginCurrLoc"]').addClass('d-none');
        }
    }, 1000);

    geoLoc.on('geolocate', function (e) {
        currCoords = [e.coords.longitude, e.coords.latitude];

        $(latClientId).val(currCoords[1]);
        $(lngClientId).val(currCoords[0]);

        if ($('input[placeholder="From location"]').val() === '') {
            directions.setOrigin(currCoords);
        }

        map.flyTo({
            center: currCoords,
            zoom: 16.5
        });
    });

    geoLoc.on('error', function () {
        toastDanger(
            'Either you did not allow us to know your location or your browser does not support it.',
            'CANNOT GET YOUR CURRENT LOCATION',
            -1
        );
    });

    directions.on('destination', function () {
        $('button[data-role="zoomDest"').removeClass('d-none');
    });

    directions.on('clear', function (e) {
        if (e.type === 'destination') {
            $('button[data-role="zoomDest"').addClass('d-none');
        }
    });

    $('button[data-role="zoomCurrLoc"]').on('click', function () {
        map.flyTo({
            center: currCoords,
            zoom: 16.5,
            pitch: 45,
            bearing: -17.6,
        });
    });

    $('button[data-role="setOriginCurrLoc"]').on('click', function () {
        directions.setOrigin(currCoords);
    });

    $('button[data-role="zoomDest"]').on('click', function () {
        map.flyTo({
            center: destCoords,
            zoom: 16.5
        });
    });

    $(setRadClientId).css({
        'border-top-left-radius': 'unset',
        'border-bottom-left-radius': 'unset'
    });

    $(setRadClientId).parent().css({
        'border-top-left-radius': 'unset',
        'border-bottom-left-radius': 'unset'
    });

    $('button.geocoder-icon-close').attr('type', 'button');
});

function getDirection(el) {
    if (marker !== null) {
        marker.remove();
    }

    destCoords = [$(el).attr('data-lng'), $(el).attr('data-lat')];

    marker = new mapboxgl.Marker({ color: '#ff3547' }).setLngLat(destCoords).addTo(map);
    directions.setDestination([$(el).attr('data-lng'), $(el).attr('data-lat')]);
}

function leaveReviewBtn_OnClick(el) {
    $(idTxtBoxCid).val($(el).attr('data-id'));
}