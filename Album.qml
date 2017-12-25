import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4

Component {
    id: album

    Rectangle {
        width: ((layout.width - leftMenu.width) / 4) - 8
        height: ((layout.width - leftMenu.width) / 4) - 8
        Image {
            id: albumCover
            sourceSize.height: (((layout.width - leftMenu.width) / 4) - 8) * 0.75
            sourceSize.width: (((layout.width - leftMenu.width) / 4) - 8) * 0.75
            fillMode: Image.PreserveAspectFit
            source: applicationPath + "/" + albumsRepeater.model[index].albumID + ".jpg"
        }

        Text {
            id: albumName
            anchors.top: albumCover.bottom
            text: albumsRepeater.model[index].name
        }

        Text {
            id: albumYear
            anchors.top: albumName.bottom
            text: albumsRepeater.model[index].year
        }
        MouseArea {
            anchors.fill: albumCover
            onClicked: {
                albumService.setNewAlbumDetail(
                            albumsRepeater.model[index].albumID)
                albumService.setNewSongs(albumsRepeater.model[index].albumID)
                layout.state = "album-detail-view"
            }
        }
    }
}
