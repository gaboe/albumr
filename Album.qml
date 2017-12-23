import QtQuick 2.9
import QtQuick.Layouts 1.3

Component {
    id: album

    Rectangle {
        width: ((layout.width - leftMenu.width) / 4) - 8
        height: ((layout.width - leftMenu.width) / 4) - 8
        Image {
            id: albumCover
            sourceSize.height: (((layout.width - leftMenu.width) / 4) - 8) * 0.75
            sourceSize.width: (((layout.width - leftMenu.width) / 4) - 8) * 0.75
            fillMode: Image.PreserveAspectFit
            source: applicationPath + "/tpab.jpg"
        }

        Text {
            id: albumName
            anchors.top: albumCover.bottom
            text: "To Pimp A Butterfly"
        }

        Text {
            id: albumYear
            anchors.top: albumName.bottom
            text: "2016"
        }
        MouseArea {
            anchors.fill: albumCover
            onClicked: {
                albumYear.text = 'clicked'
            }
        }
    }
}
