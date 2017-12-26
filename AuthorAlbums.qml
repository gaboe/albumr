import QtQuick 2.0

Rectangle {
    id: authorAlbumsWrapper
    anchors.top: addAlbumWrapper.bottom
    x: authorDetail.width * 0.10
    width: (layout.width - leftMenu.width)
    height: layout.height - 100

    ListView {
        anchors.top: addAlbumWrapper.bottom
        id: authorAlbums
        height: layout.height
        width: (layout.width - leftMenu.width)
        anchors.fill: parent
        model: albumService.authorAlbums
        clip: true
        focus: true
        delegate: Rectangle {
            anchors.margins: 15
            width: (layout.width - leftMenu.width)
            height: (layout.width - leftMenu.width) * 0.3
            Image {
                id: albumCover
                sourceSize.height: (layout.width - leftMenu.width) * 0.25
                sourceSize.width: (layout.width - leftMenu.width) * 0.25
                fillMode: Image.PreserveAspectFit
                cache: false
                source: albumService.getImagePath(
                            albumService.authorAlbums[index].albumID)
            }

            Text {
                font.pointSize: 15
                anchors.leftMargin: 15
                id: albumName
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: albumCover.right
                text: albumService.authorAlbums[index].name
                MouseArea {
                    anchors.fill: albumName
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        redirectToAlbumDetail(index)
                    }
                }
            }

            Text {
                font.pointSize: 12
                anchors.leftMargin: 15
                id: albumYear
                anchors.top: albumName.bottom
                anchors.left: albumCover.right
                text: albumService.authorAlbums[index].year
                MouseArea {
                    anchors.fill: albumYear
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        redirectToAlbumDetail(index)
                    }
                }
            }
            Text {
                font.pointSize: 14
                anchors.leftMargin: 15
                id: albumGenre
                anchors.top: albumYear.bottom
                anchors.left: albumCover.right
                text: albumService.authorAlbums[index].genreName
                MouseArea {
                    anchors.fill: albumGenre
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        redirectToAlbumDetail(index)
                    }
                }
            }
            MouseArea {
                anchors.fill: albumCover
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    redirectToAlbumDetail(index)
                }
            }
        }
    }
}
