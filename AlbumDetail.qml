import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.3
import QtQuick.Dialogs 1.0

Item {
    y: 30
    id: albumDetail
    anchors.topMargin: 20
    width: (layout.width - leftMenu.width)
    property int albumID: albumService.albumDetail.albumID
    function addSong() {
        if (textEdit.text != "") {
            albumService.addSong(textEdit.text, albumDetail.albumID)
            albumService.setNewSongs(albumDetail.albumID)
            textEdit.text = ""
        }
    }
    TextEdit {
        anchors.top: albumDetail.anchors.top
        anchors.centerIn: albumDetail
        font.pointSize: 28
        id: albumDetailName
        text: albumService.albumDetail.name
        onTextChanged: {
            albumService.updateAlbumName(albumDetailName.text,
                                         albumService.albumDetail.albumID)
        }
    }
    Image {
        anchors.topMargin: 10
        anchors.leftMargin: 10
        anchors.bottom: albumDetailName.anchors.bottom
        anchors.left: albumDetailName.right
        id: icon
        source: applicationPath + "/pencil.svg"
        sourceSize.height: 14
        sourceSize.width: 14
    }

    Image {
        anchors.top: albumDetailName.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        horizontalAlignment: Image.AlignHCenter
        id: albumCover
        sourceSize.height: (layout.width - leftMenu.width) * 0.3
        sourceSize.width: (layout.width - leftMenu.width) * 0.3
        fillMode: Image.PreserveAspectFit
        source: albumService.albumDetail.imagePath
        cache: false
    }
    Button {
        id: changeImageButton
        anchors.top: albumCover.bottom
        x: (albumDetail.width / 2) - 100
        height: 40
        width: 200
        anchors.topMargin: 5
        anchors.bottomMargin: 20
        text: "Change album cover"
        highlighted: true
        Material.accent: Material.BlueGrey
        onClicked: {
            fileDialog.visible = true
        }
    }
    Text {
        font.pointSize: 20
        width: albumDetail.width
        horizontalAlignment: Text.AlignHCenter
        anchors.margins: 20
        anchors.top: changeImageButton.bottom
        id: albumDetailAuthorName
        text: "Author: " + albumService.albumDetail.authorName
        property int authorID: albumService.albumDetail.authorID
        MouseArea {
            cursorShape: Qt.PointingHandCursor
            anchors.fill: albumDetailAuthorName
            onClicked: {
                layout.state = "author-detail-view"
                authorService.setNewAuthorDetail(albumDetailAuthorName.authorID)
                albumService.setNewAuthorAlbums(albumDetailAuthorName.authorID)
            }
        }
    }

    Text {
        width: albumDetail.width
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 15
        anchors.top: albumDetailAuthorName.bottom
        id: albumDetailGenreName
        text: "Genre: " + albumService.albumDetail.genreName
    }

    Rectangle {
        id: songsListWrapper
        anchors.top: albumDetailGenreName.bottom
        x: (albumDetail.width / 2) - (albumDetail.width * 0.3)
        width: albumDetail.width * .15
        height: 100
        anchors.margins: 20
        ListView {
            id: songs
            anchors.fill: parent
            model: albumService.songs
            delegate: Text {
                font.pointSize: 12
                text: (index + 1) + ". " + albumService.songs[index].name
            }
            focus: true
        }
    }

    Item {
        id: addSongWrapper
        anchors.top: songsListWrapper.top
        anchors.left: songsListWrapper.right
        height: 80
        TextEdit {
            x: albumDetail.width * 0.10
            anchors.top: songsListWrapper.bottom
            anchors.verticalCenter: textEdit.verticalCenter
            anchors.margins: 20
            id: textEdit
            width: 200
            font.pointSize: 15
            property string placeholderText: "Add new song..."
            Keys.onEnterPressed: {
                addSong()
            }
            Text {
                id: addSongPlaceholder
                text: textEdit.placeholderText
                color: "#aaa"
                font.pointSize: 15
                visible: !textEdit.text
            }
            Button {
                height: 40
                width: 60
                anchors.margins: 15
                anchors.left: addSongPlaceholder.right
                anchors.verticalCenter: textEdit.verticalCenter
                text: "Add"
                highlighted: true
                Material.accent: Material.BlueGrey
                onClicked: {
                    addSong()
                }
            }
        }
    }
    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        folder: shortcuts.home
        visible: false
        onAccepted: {
            albumService.setNewImage(albumService.albumDetail.albumID, "")
            albumService.setNewAlbumDetail(albumService.albumDetail.albumID)
            albumService.setNewImage(albumService.albumDetail.albumID,
                                     fileDialog.fileUrls)
            albumService.setNewAlbumDetail(albumService.albumDetail.albumID)
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
