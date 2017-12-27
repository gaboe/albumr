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
        font.pointSize: 18
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
        font.pointSize: 13
        anchors.leftMargin: 15
        id: albumAuthorName
        anchors.top: albumName.bottom
        anchors.left: albumCover.right
        text: albumService.albums[index].authorName
        MouseArea {
            anchors.fill: albumAuthorName
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                layout.state = "author-detail-view"
                authorService.setNewAuthorDetail(
                            albumService.albums[index].authorID)
                albumService.setNewAuthorAlbums(
                            albumService.albums[index].authorID)
            }
        }
    }

    Text {
        font.pointSize: 12
        anchors.leftMargin: 15
        id: albumYear
        anchors.top: albumAuthorName.bottom
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
        font.pointSize: 11
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
