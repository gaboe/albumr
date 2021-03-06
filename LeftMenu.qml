import QtQuick 2.9
import QtQuick.Controls 2.2

ListView {
    width: parent.width
    model: ListModel {
        ListElement {
            name: "Albums"
            property string stateName: "albums-view"
        }
        ListElement {
            name: "Authors"
            property string stateName: "authors-view"
        }
    }
    delegate: ItemDelegate {
        text: name
        width: parent.width
        MouseArea {
            cursorShape: Qt.PointingHandCursor
            anchors.fill: parent

            onClicked: {
                if (stateName == "authors-view") {
                    authorModel.setNewAuthors()
                } else if (stateName == "albums-view") {
                    albumModel.refreshAlbums()
                }
                layout.state = stateName
            }
        }
    }
}
