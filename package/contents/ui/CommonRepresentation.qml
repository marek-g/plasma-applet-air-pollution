import QtQuick 2.1
import QtQuick.Layouts 1.2
import QtQuick.Controls

import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasmoid
import org.kde.plasma.components as PlasmaComponents

Item {
    anchors.fill: parent
    //Layout.minimumWidth: 40
    //Layout.minimumHeight: 25
    Layout.preferredWidth: 60
    Layout.preferredHeight: 40

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

        gradient: Gradient {
            GradientStop { position: 0.0; color: root.alertColor1 }
            GradientStop { position: 0.33; color: root.alertColor2 }
            GradientStop { position: 1.0; color: root.alertColor3 }
        }

        ColumnLayout {
            anchors.fill: parent
            spacing: 0

            PlasmaComponents.Label {
                text: root.paramCode

                Layout.fillWidth: true
                Layout.preferredHeight: parent.height / 2.0
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: Math.min(parent.height * 0.4, parent.width / 5.0)
            }

            PlasmaComponents.Label {
                text: root.value

                Layout.fillWidth: true
                Layout.preferredHeight: parent.height / 2.0
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: Math.min(parent.height * 0.4, parent.width / 5.0)
            }
        }
    }
}
