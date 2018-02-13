import QtQuick 2.1
import QtQuick.Layouts 1.2
import QtQuick.Controls 1.4
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents

Item {
	id: root
	
	anchors.fill: parent

	property string stationName: 'Kraków, ul. Bujaka'
	property string paramCode: 'PM10'
	property string value: '100.0'

	Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation
	Plasmoid.toolTipTextFormat: Text.RichText
	Plasmoid.backgroundHints: plasmoid.configuration.showBackground ? "StandardBackground" : "NoBackground"
    
    Plasmoid.compactRepresentation: Item {
	
        anchors.fill: parent
        
        ColumnLayout {
        
            PlasmaComponents.Label {
                text: root.paramCode
                
                horizontalAlignment: Text.AlignHCenter
            }

            PlasmaComponents.Label {
                text: root.value
                
                horizontalAlignment: Text.AlignHCenter
            }
        }
        
    }
}
