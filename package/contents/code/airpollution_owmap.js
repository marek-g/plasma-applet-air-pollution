// https://openweathermap.org/api/air-pollution

var apiUrl = 'http://api.openweathermap.org/data/2.5/air_pollution?lat={latitude}&lon={longitude}&appid={key}';

// generated for me
var apiKey = '7136b1491588d38a25fc7cc4b2f66964';

// other working, found on the internet
/*var apiKey = '7e34aa1b1b97fe8e6e0233e91782bfb8';
var apiKey = '542ffd081e67f4512b705f89d2a611b2';
var apiKey = 'ba24c6018ddd72041749018d0c1b1ef8';*/

function getValue(latitude, longtitude, paramCode, callbackOk, callbackError) {
    var url = apiUrl.replace("{latitude}", latitude)
        .replace("{longitude}", longitude)
        .replace("{key}", apiKey);

    request(url, function (req) {
        console.log(req.responseText);
        var response = JSON.parse(req.responseText);
        callbackOk(response.list[0].components["pm2_5"]);
        return;
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
