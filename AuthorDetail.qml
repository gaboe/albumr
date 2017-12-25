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
            delegate: Rectangle {
                width: ((layout.width - leftMenu.width) / 4) - 8
                height: ((layout.width - leftMenu.width) / 4) - 8
                Image {
                    id: albumCover
                    sourceSize.height: (((layout.width - leftMenu.width) / 4) - 8) * 0.75
                    sourceSize.width: (((layout.width - leftMenu.width) / 4) - 8) * 0.75
                    fillMode: Image.PreserveAspectFit
                    source: applicationPath + "/"
                            + albumService.authorAlbums[index].albumID + ".jpg"
                }

                Text {
                    id: albumName
                    anchors.top: albumCover.bottom
                    text: albumService.authorAlbums[index].name
                }

                Text {
                    id: albumYear
                    anchors.top: albumName.bottom
                    text: albumService.authorAlbums[index].year
                }
                MouseArea {
                    anchors.fill: albumCover
                    onClicked: {
                        albumService.setNewAlbumDetail(
                                    albumService.authorAlbums[index].albumID)
                        albumService.setNewSongs(
                                    albumService.authorAlbums[index].albumID)
                        layout.state = "album-detail-view"
                    }
                }
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
