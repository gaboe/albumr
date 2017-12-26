import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4

Component {
    id: album
    Rectangle {
        width: ((layout.width - leftMenu.width) / 4) - 8
        height: ((layout.width - leftMenu.width) / 4) - 8
        function redirectToDetail() {
            albumService.setNewAlbumDetail(albumsRepeater.model[index].albumID)
            albumService.setNewSongs(albumsRepeater.model[index].albumID)
            layout.state = "album-detail-view"
        }

        Image {
            id: albumCover
            sourceSize.height: (((layout.width - leftMenu.width) / 4) - 8) * 0.75
            sourceSize.width: (((layout.width - leftMenu.width) / 4) - 8) * 0.75
            fillMode: Image.PreserveAspectFit
            source: albumsRepeater.model[index].imagePath // fileUtils.getImagePath(albumsRepeater.model[index].albumID)
            cache: false
            Text {
                id: albumName
                anchors.top: albumCover.bottom
                text: albumsRepeater.model[index].name
                MouseArea {
                    anchors.fill: albumName
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        redirectToDetail()
                    }
                }
            }

            Text {
                id: albumYear
                anchors.top: albumName.bottom
                text: albumsRepeater.model[index].year
                MouseArea {
                    anchors.fill: albumYear
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        redirectToDetail()
                    }
                }
            }
            MouseArea {
                anchors.fill: albumCover
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    redirectToDetail()
                }
            }
        }
    }
}
