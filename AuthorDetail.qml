import QtQuick 2.0

Item {
    y: 30
    id: authorDetail
    width: (layout.width - leftMenu.width)
    anchors.topMargin: 20
    Text {
        anchors.top: authorDetail.anchors.top
        anchors.centerIn: authorDetail

        anchors.margins: 40
        font.pixelSize: 24
        text: authorService.authorDetail.firstName + " " + authorService.authorDetail.lastName
        id: authorDetailName
        anchors.bottomMargin: 20
    }

    Rectangle {
        anchors.top: authorDetailName.bottom
        x: authorDetail.width * 0.15
        anchors.topMargin: 50
        width: ((layout.width - leftMenu.width) * .75)
        height: layout.height
        ListView {
            id: songs
            anchors.fill: parent
            model: albumService.authorAlbums
            delegate: Rectangle {
                anchors.margins: 15
                width: (layout.width - leftMenu.width) * 0.3
                height: (layout.width - leftMenu.width) * 0.3
                Image {
                    id: albumCover
                    sourceSize.height: (layout.width - leftMenu.width) * 0.25
                    sourceSize.width: (layout.width - leftMenu.width) * 0.25
                    fillMode: Image.PreserveAspectFit
                    source: applicationPath + "/"
                            + albumService.authorAlbums[index].albumID + ".jpg"
                }

                Text {
                    anchors.leftMargin: 15
                    id: albumName
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: albumCover.right
                    text: albumService.authorAlbums[index].name
                }

                Text {
                    anchors.leftMargin: 15
                    id: albumYear
                    anchors.top: albumName.bottom
                    anchors.left: albumCover.right
                    text: albumService.authorAlbums[index].year
                }
                Text {
                    anchors.leftMargin: 15
                    id: albumGenre
                    anchors.top: albumYear.bottom
                    anchors.left: albumCover.right
                    text: albumService.authorAlbums[index].genreName
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
