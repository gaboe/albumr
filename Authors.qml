import QtQuick 2.0
import QtQuick.Controls 2.2

Item {
    id: authors
    Text {
        font.pixelSize: 24
        text: "Authors"
        id: authorsHeader
    }
    Rectangle {
        y: 40
        width: ((layout.width - leftMenu.width) * .75)
        height: layout.height

        ListView {
            anchors.fill: parent
            model: 200
            delegate: Text {
                text: "Author: " + index
            }
            focus: true
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    layout.state = "author-detail-view"
                }
            }
        }
    }

    state: "hidden"
    states: [
        State {
            name: "focused"
            PropertyChanges {
                target: authors
                visible: true
            }
        },
        State {
            name: "hidden"
            PropertyChanges {
                target: authors
                visible: false
            }
        }
    ]
}
