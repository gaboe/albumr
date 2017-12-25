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
            id: list
            anchors.fill: parent
            model: authorService.getAuthors()
            delegate: Text {
                property int authorID: list.model[index].authorID
                text: list.model[index].authorID + " " + list.model[index].firstName
                      + " " + list.model[index].lastName
                MouseArea {
                    anchors.fill: parent
                    onClicked: list.currentIndex = index
                }
            }
            focus: true
            onCurrentItemChanged: {
                layout.state = "author-detail-view"
                authorService.setAuthorDetail(list.model[list.currentIndex])
                albumService.setNewAuthorAlbums(
                            list.model[list.currentIndex].authorID)
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
