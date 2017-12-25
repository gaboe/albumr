import QtQuick 2.0

Item {
    id: albumDetail

    Text {
        font.pixelSize: 24
        text: "Album detail"
        id: albumDetailHeader
    }

    Text {
        y: 20
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
