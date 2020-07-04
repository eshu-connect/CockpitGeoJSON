<field-geojson style="width: 100%; height: 500px; z-index: 0">
  <script>
    this.value = null; 

    this.$updateValue = (value) => {
      this.value = value;
    };

    // Set default options
    var opts = this.opts;

    this.on('mount', () => {
      // Try getting geolocation first
      if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(showMap);
      } else {
        // If geolocation fails, then default to Kyoto
        showMap({
          position: {
            coords: {
              latitude: 35.011665,
              longitude: 135.768326,
            }
          }
        });
      }
    });

    var showMap = (position) => {      
      // Setup Leaflet JS map
      this.map = L.map(this.root, {
        center: [position.coords.latitude, position.coords.longitude],
        zoom: 13,
      });

      // Tile layer to show geometry
      L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png?{foo}', {
        foo: 'bar',
        attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>',
      }).addTo(this.map);

      // Geoman options
      this.map.pm.addControls(opts.controls);

      if (opts.global) {
        this.map.pm.setGlobalOptions(opts.global);
      }

      // Add existing geometry if available
      this.layers = [];

      var updateValue = () => {
        var geoJSON = layersToGeoJSON(this.layers);
        this.$setValue(geoJSON);
      }

      L.geoJSON(this.value, {
        onEachFeature: (feature, layer) => {
          this.layers.push(layer);
          layer.on('pm:edit', updateValue);
          layer.on('pm:dragend', updateValue);
        }
      }).addTo(this.map);

      // Editing callbacks
      this.map.on('pm:create', (e) => {
        this.layers.push(e.layer);
        updateValue();

        e.layer.on('pm:edit', updateValue);
        e.layer.on('pm:dragend', updateValue);
      });
      this.map.on('pm:remove', (e) => {
        var idx = this.layers.indexOf(e.layer);
        if (idx != -1) {
          this.layers.splice(idx, 1);
        }

        updateValue();
      });
    }

    // Merge all map layers into a single GeoJSON FeatureCollection.
    // If no layers were provided, then null is returned.
    function layersToGeoJSON(layers) {
      if (!layers || layers.length == 0) {
        return null;
      }
      var ret = {
        type: "FeatureCollection",
        features: [],
      };
      for (var layer of layers) {
        ret.features.push(layer.toGeoJSON());
      }
      return ret;
    }
  </script>
</field-geojson>
