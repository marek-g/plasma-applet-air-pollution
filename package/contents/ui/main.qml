import QtQuick 2.1
import QtQuick.Layouts 1.2
import QtQuick.Controls 1.4
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents

Item {
	id: root

	property string stationName: 'Kraków, ul. Bujaka'
	property string paramCode: 'PM10'
	property string value: '100.0'
	
	Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation
	Plasmoid.toolTipTextFormat: Text.RichText
	Plasmoid.backgroundHints: "StandardBackground"
    
    Plasmoid.compactRepresentation: Item {
	
        anchors.fill: parent
        Layout.preferredWidth: 60
        Layout.maximumWidth: 60
        Layout.preferredHeight: 40
        Layout.maximumHeight: 40
        
        ColumnLayout {
            
            anchors.fill: parent
        
            PlasmaComponents.Label {
                text: root.paramCode
                
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
            }

            PlasmaComponents.Label {
                text: root.value
                
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
            }
        }
        
    }
}
