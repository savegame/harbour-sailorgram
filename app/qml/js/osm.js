/*
  http://wiki.openstreetmap.org/wiki/Slippy_map_tilenames
*/

function long2tile(lon, zoom) {
    var x = (Math.floor((lon + 180) / 360 * Math.pow(2, zoom)));
    return x;
}

function lat2tile(lat, zoom) {
    var y = (Math.floor((1 - Math.log(Math.tan(lat * Math.PI / 180) + 1 / Math.cos(lat * Math.PI / 180)) / Math.PI) / 2 * Math.pow(2, zoom)));
    return y;
}

function tile2long(x, zoom) {
    var lan = (x / Math.pow(2, zoom) * 360 - 180);
    return lan;
}

function tile2lat(y, zoom) {
    var n = Math.PI - 2 * Math.PI * y / Math.pow(2, zoom);
    var lat = (180 / Math.PI * Math.atan(0.5 * (Math.exp(n) - Math.exp(-n))));
    return lat;
}

function tile(lon, lat, zoom) {
    var url = 'http://{s}.tile.openstreetmap.org/{zoom}/{x}/{y}.png'
    var s = 'a';
    var x = long2tile(lon, zoom);
    var y = lat2tile(lat, zoom);
    return url.replace('{s}', s)
              .replace('{zoom}', zoom)
              .replace('{x}', x)
              .replace('{y}', y);
}
