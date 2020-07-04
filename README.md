# Cockpit CMS GeoJSON Field

Add-on for [Cockpit CMS](https://getcockpit.com/) to add GeoJSON field types.
Editing powered by [Leaflet](https://leafletjs.com/) and [Leaflet-Geoman](https://github.com/geoman-io/leaflet-geoman).

![GeoJSON Field Preview](preview.png)

## Installation

From your Cockpit CMS installation's root folder:

```bash
git clone git@github.com:eshu-connect/CockpitGeoJSON.git addons/GeoJSON
```

## Configuration

| Field | Description |
| -- | -- |
| controls | Toolbar controls settings. Supports all [geoman](https://github.com/geoman-io/leaflet-geoman#leaflet-geoman-toolbar) settings. |
| global | Global geoman editor settings. Supports all [geoman](https://github.com/geoman-io/leaflet-geoman#options) options.

Example:

```json
{
  "controls": {
    "position": "topleft",
    "drawCircle": false,
    "drawCircleMarker": false,
    "drawRectangle": false,
    "drawPolyline": false
  },
  "global": {
    "snapDistance": 20,
    "snappable": true,
    "allowSelfIntersection": false
  }
}
```