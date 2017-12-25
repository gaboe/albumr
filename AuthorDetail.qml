import QtQuick 2.0

Item {
    id: authorDetail
    Text {
        font.pixelSize: 24
        text: "Author detail"
        id: authorDetailHeader
    }

    Text {
        y: 20
        font.pixelSize: 24
        text: authorService.authorDetail.firstName + " " + authorService.authorDetail.lastName
        id: authorDetailName
    }

    Text {
        y: 50
        text: "Albums:"
    }

    Rectangle {
        y: 70
        width: ((layout.width - leftMenu.width) * .75)
        height: layout.height
        ListView {
            id: songs
            anchors.fill: parent
            model: albumService.authorAlbums
            delegate: Text {
                text: albumService.authorAlbums[index].name
            }
            focus: true
        }
    }

    state: "hidden"
    states: [
        State {
            name: "focused"
            PropertyChanges {
                target: authorDetail
                visible: true
            }
        },
        State {
            name: "hidden"
            PropertyChanges {
                target: authorDetail
                visible: false
            }
        }
    ]
}
