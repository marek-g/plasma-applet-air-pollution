var apiUrl = 'http://api.gios.gov.pl/pjp-api/rest/';

function getValue(stationName, paramCode, callback) {
    getStationId(stationName, function(stationId) {
        getSensorId(stationId, paramCode, function(sensorId) {
            getSensorValue(sensorId, function(value) {
                callback(value);
            });
        });
    });
}

function getStationId(stationName, callback) {
    request(apiUrl + 'station/findAll', function(req) {
        var stations = JSON.parse(req.responseText);
        for (var i = 0; i < stations.length; i++) {
            if (stations[i].stationName === stationName) {
                callback(stations[i].id);
                return;
            }
        }
    });
}

function getSensorId(stationId, paramCode, callback) {
    request(apiUrl + 'station/sensors/' + stationId, function(req) {
        var sensors = JSON.parse(req.responseText);
        for (var i = 0; i < sensors.length; i++) {
            if (sensors[i].param.paramCode === paramCode) {
                callback(sensors[i].id);
                return;
            }
        }
    });
}

function getSensorValue(sensorId, callback) {
    request(apiUrl + 'data/getData/' + sensorId, function(req) {
        var values = JSON.parse(req.responseText);
        for (var i = 0; i < values.values.length; i++) {
            if (values.values[i].value !== null) {
                callback(values.values[i].value);
                return;
            }
        }
    });
} 

function request(url, callback) {
	var xhr = new XMLHttpRequest();
	xhr.onreadystatechange = (function(xhr) {
		return function() {
			callback(xhr);
		}
	})(xhr);
	xhr.open('GET', url, true);
	xhr.send('');
}
