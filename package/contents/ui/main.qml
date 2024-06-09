import QtQuick 2.1
import QtQuick.Layouts 1.2
import QtQuick.Controls

import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasmoid
import org.kde.plasma.components as PlasmaComponents
import "../code/airpollution_airly.js" as AirPollution

PlasmoidItem {
	id: root

	property string latitude: '49.9996157206'
    property string longitude: '19.9660634995'
	property string paramCode: 'PM25'
	property string value: '...'
	property var norm: 25.0

	property color alertColor1: "Transparent"
	property color alertColor2: "Transparent"
	property color alertColor3: "Transparent"
    property bool isBusy: false
	
	toolTipTextFormat: Text.RichText

    compactRepresentation: CommonRepresentation {}
    fullRepresentation: CommonRepresentation {}

    Timer {
        id: airPollutionTimer
        interval: 15 * 60 * 1000
        running: true
        repeat: true
        triggeredOnStart: true
        
        onTriggered: {
            action_refresh(false);
        }
    }
    
    function action_refresh(withBusyIndicator) {
        if (withBusyIndicator) {
            root.isBusy = true;
            //console.log("TRUE");
        }
        
        AirPollution.getValue(root.latitude, root.longitude, root.paramCode, function(res) {
            var percentage = (res*100.0)/root.norm;
            if (percentage <= 50.0) {
                root.alertColor1 = "#8000AA00";
				root.alertColor2 = "#8000FF00";
				root.alertColor3 = "#8000AA00";
            } else if (percentage <= 100.0) {
                root.alertColor1 = "#80AAAA00";
				root.alertColor2 = "#80FFFF00";
				root.alertColor3 = "#80AAAA00";
            } else if (percentage <= 150.0) {
                root.alertColor1 = "#C0AA5000";
				root.alertColor2 = "#C0FF8000";
				root.alertColor3 = "#C0AA5000";
            } else if (percentage <= 200.0) {
                root.alertColor1 = "#80AA0000";
				root.alertColor2 = "#80FF0000";
				root.alertColor3 = "#80AA0000";
            } else if (percentage <= 300.0) {
                root.alertColor1 = "#80AA00AA";
				root.alertColor2 = "#80FF00FF";
				root.alertColor3 = "#80AA00AA";
            } else {
                root.alertColor1 = "#FF000000";
				root.alertColor2 = "#FF222222";
				root.alertColor3 = "#FF000000";
            }
            root.value = '' + Math.floor(res) + ' (' + Math.floor(percentage) + '%)';

            root.isBusy = false;
            //console.log("FALSE");
        }, function(error) {
            root.value = "Error";
            root.isBusy = false;
        });
	}
}
