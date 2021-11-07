// Previous code, not used now

var apiUrl = 'http://api.gios.gov.pl/pjp-api/rest/';

function getValue(stationName, paramCode, callbackOk, callbackError) {
    getStationId(stationName, function (stationId) {
        getSensorId(stationId, paramCode, function (sensorId) {
            getSensorValue(sensorId, function (value) {
                callbackOk(value);
            }, callbackError);
        }, callbackError);
    }, callbackError);
}

function getStationId(stationName, callbackOk, callbackError) {
    request(apiUrl + 'station/findAll', function (req) {
        var stations = JSON.parse(req.responseText);
        for (var i = 0; i < stations.length; i++) {
            if (stations[i].stationName === stationName) {
                callbackOk(stations[i].id);
                return;
            }
        }
        callbackError("Not found");
    }, callbackError);
}

function getSensorId(stationId, paramCode, callbackOk, callbackError) {
    request(apiUrl + 'station/sensors/' + stationId, function (req) {
        var sensors = JSON.parse(req.responseText);
        for (var i = 0; i < sensors.length; i++) {
            if (sensors[i].param.paramCode === paramCode) {
                callbackOk(sensors[i].id);
                return;
            }
        }
        callbackError("Not found");
    }, callbackError);
}

function getSensorValue(sensorId, callbackOk, callbackError) {
    request(apiUrl + 'data/getData/' + sensorId, function (req) {
        var values = JSON.parse(req.responseText);
        for (var i = 0; i < values.values.length; i++) {
            if (values.values[i].value !== null) {
                callbackOk(values.values[i].value);
                return;
            }
        }
        callbackError("Not found");
    }, callbackError);
}

function request(url, callbackOk, callbackError) {
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = (function (xhr) {
        return function () {
            console.log(xhr.readyState);
            console.log("status: " + xhr.status);
            if (xhr.readyState == 4) {
                if (xhr.status == 200) {
                    callbackOk(xhr);
                } else {
                    callbackError(xhr);
                }
            }
        }
    })(xhr);
    xhr.open('GET', url, true);
    xhr.send();
}
