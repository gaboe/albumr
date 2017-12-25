import QtQuick 2.0

Item {
    id: albumDetail

    Text {
        font.pixelSize: 24
        text: "Album detail"
        id: albumDetailHeader
    }

    Text {
        y: 30
        id: albumDetailName
        text: "Name: " + albumService.albumDetail.name
    }

    Text {
        y: 40
        id: albumDetailAuthorName
        text: "Author: " + albumService.albumDetail.authorName
    }

    Text {
        y: 60
        id: albumDetailGenreName
        text: "Genre: " + albumService.albumDetail.genreName
    }

    Text {
        y: 80
        text: "Songs: "
    }

    Rectangle {
        y: 100
        width: ((layout.width - leftMenu.width) * .75)
        height: layout.height
        ListView {
            id: songs
            anchors.fill: parent
            model: albumService.songs
            delegate: Text {
                text: (index + 1) + ". " + albumService.songs[index].name
            }
            focus: true
        }
    }

    state: "hidden"
    states: [
        State {
            name: "focused"
            PropertyChanges {
                target: albumDetail
                visible: true
            }
        },
        State {
            name: "hidden"
            PropertyChanges {
                target: albumDetail
                visible: false
            }
        }
    ]
}
