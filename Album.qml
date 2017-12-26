import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4

Rectangle {
    anchors.margins: 15
    width: (layout.width - leftMenu.width)
    height: (layout.width - leftMenu.width) * 0.3
    Image {
        id: albumCover
        sourceSize.height: (layout.width - leftMenu.width) * 0.25
        sourceSize.width: (layout.width - leftMenu.width) * 0.25
        fillMode: Image.PreserveAspectFit
        cache: false
        source: albumService.getImagePath(albumService.albums[index].albumID)
    }

    Text {
        font.pointSize: 15
        anchors.leftMargin: 15
        id: albumName
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: albumCover.right
        text: albumService.albums[index].name
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
        text: albumService.albums[index].year
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
        text: albumService.albums[index].genreName
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
