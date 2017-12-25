import QtQuick 2.0

Item {
    id: albumDetail
    Image {
        id: albumCover
        sourceSize.height: (((layout.width - leftMenu.width) / 4) - 8) * 0.75
        sourceSize.width: (((layout.width - leftMenu.width) / 4) - 8) * 0.75
        fillMode: Image.PreserveAspectFit
        source: applicationPath + "/" + albumService.albumDetail.albumID + ".jpg"
    }

    Text {
        y: 100
        font.pixelSize: 24
        text: "Album detail"
        id: albumDetailHeader
    }

    Text {
        y: 130
        id: albumDetailName
        text: "Name: " + albumService.albumDetail.name
    }

    Text {
        y: 140
        id: albumDetailAuthorName
        text: "Author: " + albumService.albumDetail.authorName
    }

    Text {
        y: 160
        id: albumDetailGenreName
        text: "Genre: " + albumService.albumDetail.genreName
    }

    Text {
        y: 180
        text: "Songs: "
    }

    Rectangle {
        y: 200
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
