var apiUrl = 'https://airapi.airly.eu/v2/measurements/point?lat={latitude}&lng={longitude}&indexType=AIRLY_CAQI&indexPollutant=PM&includeSubindexes=true&includeWind=true&apikey={key}';

function getValue(latitude, longtitude, paramCode, callbackOk, callbackError) {
    var url = apiUrl.replace("{latitude}", latitude)
        .replace("{longitude}", longitude)
        .replace("{key}", "3xeoECM8FDFk5BnNZDWFbu0UOHuRubwN");

    request(url, function (req) {
        var response = JSON.parse(req.responseText);
        for (var i = 0; i < response.current.values.length; i++) {
            if (response.current.values[i].name === paramCode) {
                console.log("value: " + response.current.values[i].value);
                callbackOk(response.current.values[i].value);
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
