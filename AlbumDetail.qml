import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.3

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
    Text {
        anchors.top: albumDetail.anchors.top
        anchors.centerIn: albumDetail
        font.pointSize: 24
        id: albumDetailName
        text: albumService.albumDetail.name
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
        source: applicationPath + "/" + albumService.albumDetail.albumID + ".jpg"
    }

    Text {
        x: albumDetail.width * 0.10
        anchors.top: albumCover.bottom
        id: albumDetailAuthorName
        text: "Author: " + albumService.albumDetail.authorName
        property int authorID: albumService.albumDetail.authorID
        MouseArea {
            anchors.fill: albumDetailAuthorName
            onClicked: {
                console.log(albumDetailAuthorName.authorID)
                layout.state = "author-detail-view"
                authorService.setNewAuthorDetail(albumDetailAuthorName.authorID)
                albumService.setNewAuthorAlbums(albumDetailAuthorName.authorID)
            }
        }
    }

    Text {
        x: albumDetail.width * 0.10
        anchors.top: albumDetailAuthorName.bottom
        id: albumDetailGenreName
        text: "Genre: " + albumService.albumDetail.genreName
    }

    Text {
        x: albumDetail.width * 0.10
        anchors.top: albumDetailGenreName.bottom
        id: songsHeader
        text: "Songs: "
    }

    Rectangle {
        id: songsListWrapper
        anchors.top: songsHeader.bottom
        x: albumDetail.width * 0.10
        width: albumDetail.width * .15
        height: layout.height
        anchors.margins: 20
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

    TextEdit {
        anchors.left: songsListWrapper.right
        anchors.top: songsHeader.bottom
        anchors.margins: 20
        id: textEdit
        width: 200
        height: 50
        property string placeholderText: "Add new song..."
        Keys.onEnterPressed: {
            addSong()
        }
        Text {
            id: addSongPlaceholder
            text: textEdit.placeholderText
            color: "#aaa"
            visible: !textEdit.text
        }
        Button {
            anchors.margins: 15
            anchors.left: addSongPlaceholder.right
            text: "Add"
            highlighted: true
            Material.accent: Material.BlueGrey
            onClicked: {
                addSong()
            }
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
