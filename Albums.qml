import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2

Item {
    id: albums
    property variant colorArray: ["#00bde3", "#67c111", "#ea7025"]

    Text {
        font.pixelSize: 24
        text: "Albums"
        id: allbumsHeader
    }

    //    GridLayout {
    //        anchors.fill: parent // GridLayout must have the right size now
    //        rows: 3
    //        columns: 3
    //        columnSpacing: 0
    //        rowSpacing: 0 // changed from spacing: 0

    //        Repeater {
    //            model: 9
    //            Button {
    //                // attached properties guiding resizing
    //                Layout.fillHeight: true
    //                Layout.fillWidth: true
    //            }
    //        }
    //    }
    Grid {
        anchors.topMargin: 50
        id: grid
        anchors.fill: parent
        anchors.margins: 8
        spacing: 4
        Repeater {
            model: 16

            Rectangle {

                width: ((layout.width - leftMenu.width) / 4) - 8
                height: ((layout.width - leftMenu.width) / 4) - 8
                property int colorIndex: Math.floor(Math.random() * 3)
                color: albums.colorArray[colorIndex]
                border.color: Qt.lighter(color)
                Text {
                    anchors.centerIn: parent
                    color: "#f0f0f0"
                    text: layout.height / 4
                }
            }
        }
    }
}
