import QtQuick 2.1
import QtQuick.Layouts 1.2
import QtQuick.Controls 1.4
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents
import "../code/airpollution.js" as AirPollution

Item {
	id: root

	property string stationName: 'Kraków, ul. Bujaka'
	property string paramCode: 'PM2.5'
	property string value: '...'
	property var norm: 25.0

	property color alertColor: "Transparent"
    property bool isBusy: false
	
	Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation
	Plasmoid.toolTipTextFormat: Text.RichText
	Plasmoid.backgroundHints: "StandardBackground"
    
    Plasmoid.compactRepresentation: Item {
        
        anchors.fill: parent
        Layout.preferredWidth: 60
        Layout.maximumWidth: 60
        Layout.preferredHeight: 40
        Layout.maximumHeight: 40
        
        MouseArea {
			id: mouseArea
			anchors.fill: parent
			hoverEnabled: true
			onClicked: {
                action_refresh(true);
			}
		}
		
		BusyIndicator {
			anchors.fill: parent
			running: root.isBusy
			visible: root.isBusy
		}
        
        Rectangle {

            anchors.fill: parent
            
            color: root.alertColor
            
            ColumnLayout {
                
                anchors.fill: parent
            
                PlasmaComponents.Label {
                    text: root.paramCode
                    
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: parent.width / parent.height > 3.0 ? parent.height * 0.4 : parent.width / 5.0
                }

                PlasmaComponents.Label {
                    text: root.value
                    
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: parent.width / parent.height > 3.0 ? parent.height * 0.4 : parent.width / 5.0
                }
            }
        }
        
    }
    
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
            console.log("TRUE");
        }
        
        AirPollution.getValue(root.stationName, root.paramCode, function(res) {
            var percentage = (res*100.0)/root.norm;
            if (percentage <= 50.0) {
                root.alertColor = "#8000FF00";
            } else if (percentage <= 100.0) {
                root.alertColor = "#80FFFF00";
            } else if (percentage <= 150.0) {
                root.alertColor = "#C0FF8000";
            } else if (percentage <= 200.0) {
                root.alertColor = "#80FF0000";
            } else if (percentage <= 300.0) {
                root.alertColor = "#80FF00FF";
            } else {
                root.alertColor = "#FF000000";
            }
            root.value = '' + Math.floor(res) + ' (' + Math.floor(percentage) + '%)';

            root.isBusy = false;
            console.log("FALSE");
        }, function(error) {
            root.value = "Error";
            root.isBusy = false;
        });
	}
}
