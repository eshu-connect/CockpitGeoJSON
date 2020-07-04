<?php

$app->on('admin.init', function() {
    $this->helper('admin')->addAssets('geojson:assets/components/geojson.tag');
    $this->helper('admin')->addAssets([
        'https://unpkg.com/leaflet@1.6.0/dist/leaflet.css',
        'https://unpkg.com/leaflet@1.6.0/dist/leaflet.js',
    ]);
    $this->helper('admin')->addAssets([
        'https://unpkg.com/@geoman-io/leaflet-geoman-free@latest/dist/leaflet-geoman.css',
        'https://unpkg.com/@geoman-io/leaflet-geoman-free@latest/dist/leaflet-geoman.min.js',
    ]);
});
