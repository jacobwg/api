var iCloud = require('./lib/icloud'),
    Firebase = require('firebase');
    _ = require('underscore'),
    moment = require('moment'),
    nconf = require('nconf');

nconf.argv()
     .env()
     .file({ file: 'config.json' });

var tracker = new iCloud(nconf.get('ICLOUD_USERNAME'), nconf.get('ICLOUD_PASSWORD')),
    db = new Firebase('https://jacob-gillespie.firebaseio.com');


var express = require('express');
var app = express();

app.get('/', function(req, res){
  res.send('hello world');
});

app.get('/v1/location', function(req, res) {
  tracker.locate(function(data) {
    data = data[nconf.get('DEVICE_ID')];
    res.jsonp({
      latitude: data.latitude,
      longitude: data.longitude,
      accuracy: data.horizontalAccuracy,
      timestamp: data.timeStamp
    });
  });
});

app.get('/v1/location/history', function(req, res) {
  db.child('location/history').on('value', function(snap) {
    res.jsonp(snap.val());
  });
});

var port = process.env.PORT || 3000;
app.listen(port);

locations = require('./locations');

_.each(locations, function(location, idx) {
  return;
  var latitude = location.latitude;
  var longitude = location.longitude;
  var time = moment(location.time);

  latitude = Math.ceil(latitude * 1000) / 1000;
  longitude = Math.ceil(longitude * 1000) / 1000;
  id = 'location/history/y' + time.year() + '/w' + time.isoWeek() + '/l' + (latitude + ':' + longitude).replace(/[.]/g, '_');

  db.child(id).transaction(function(count) {
    if (count)
      return count + 1;
    else
      return 1;
  });

  console.log(idx / 18837);

  //db.child('locations').push(location);
});

console.log('Server started on port 3000');


