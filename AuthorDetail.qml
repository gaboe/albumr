import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.3

Item {
    y: 30
    x: 10
    id: authorDetail
    width: (layout.width - leftMenu.width)
    anchors.topMargin: 20

    function redirectToAlbumDetail(index) {
        albumModel.setNewAlbumDetail(albumModel.authorAlbums[index].albumID)
        albumModel.setNewSongs(albumModel.authorAlbums[index].albumID)
        layout.state = "album-detail-view"
    }
    TextEdit {
        anchors.top: authorDetail.top
        anchors.centerIn: authorDetail
        anchors.margins: 40
        font.pixelSize: 28
        text: authorModel.authorDetail.name
        id: authorDetailName
        anchors.bottomMargin: 20

        onTextChanged: {
            authorModel.updateAuthorName(authorDetailName.text,
                                           authorModel.authorDetail.authorID)
        }
    }

    Image {
        anchors.leftMargin: 10
        anchors.left: authorDetailName.right
        id: icon
        source: applicationPath + "/pencil.svg"
        sourceSize.height: 14
        sourceSize.width: 14
    }
    AddAlbum {
        id: addAlbumWrapper
    }

    AuthorAlbums {
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
