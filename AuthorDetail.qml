import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.3

Item {
    y: 30
    id: authorDetail
    width: (layout.width - leftMenu.width)
    anchors.topMargin: 20
    function addAlbum() {
        if (textEdit.text != "" && !/\D/.test(yearTextEdit.text)) {
            albumService.addAlbum(textEdit.text,
                                  authorService.authorDetail.authorID,
                                  yearTextEdit.text, combobox.currentGenre)
            albumService.setNewAuthorAlbums(authorService.authorDetail.authorID)
            textEdit.text = ""
            yearTextEdit.text = ""
        }
    }
    function redirectToAlbumDetail(index) {
        albumService.setNewAlbumDetail(albumService.authorAlbums[index].albumID)
        albumService.setNewSongs(albumService.authorAlbums[index].albumID)
        layout.state = "album-detail-view"
    }
    Text {
        anchors.top: authorDetail.anchors.top
        anchors.centerIn: authorDetail

        anchors.margins: 40
        font.pixelSize: 24
        text: authorService.authorDetail.firstName + " " + authorService.authorDetail.lastName
        id: authorDetailName
        anchors.bottomMargin: 20
    }
    anchors.top: authorDetailName.bottom
    Item {
        id: addAlbumWrapper
        width: authorDetail.width
        height: 60
        TextEdit {
            anchors.top: authorDetailName.bottom
            anchors.margins: 20
            id: textEdit
            width: 100
            height: 50
            font.pointSize: 15
            property string placeholderText: "Add new album..."
            Keys.onEnterPressed: {
                addAlbum()
            }
            Text {
                id: addAlbumPlaceholder
                text: textEdit.placeholderText
                color: "#aaa"
                visible: !textEdit.text
            }
        }

        TextEdit {
            anchors.top: authorDetailName.bottom
            anchors.left: textEdit.right
            anchors.margins: 20
            id: yearTextEdit
            width: 100
            height: 50
            font.pointSize: 15
            property string placeholderText: "year"

            Keys.onEnterPressed: {
                addAlbum()
            }
            Text {
                id: yearTextEditPlaceholed
                text: yearTextEdit.placeholderText
                color: "#aaa"
                visible: !yearTextEdit.text
            }
        }

        ComboBox {
            anchors.top: authorDetailName.bottom
            anchors.verticalCenter: textEdit.verticalCenter
            anchors.left: yearTextEdit.right
            id: combobox
            anchors.margins: 20
            property string currentGenre: "Rock"
            model: ListModel {
                id: cbItems
                ListElement {
                    text: "Rock"
                }
                ListElement {
                    text: "Rap"
                }
                ListElement {
                    text: "Pop"
                }
                ListElement {
                    text: "Metal"
                }
                ListElement {
                    text: "RnB"
                }
            }
            onCurrentIndexChanged: combobox.currentGenre = cbItems.get(
                                       currentIndex).text

            width: 200
        }

        Button {
            height: 40
            width: 60
            anchors.margins: 15
            anchors.verticalCenter: combobox.verticalCenter
            anchors.left: combobox.right
            text: "Add"
            highlighted: true
            Material.accent: Material.BlueGrey
            onClicked: {
                addAlbum()
            }
        }
    }

    Rectangle {

        id: authorAlbumsWrapper
        anchors.top: addAlbumWrapper.bottom
        x: authorDetail.width * 0.15
        width: ((layout.width - leftMenu.width) * .3)
        height: layout.height
        ListView {
            id: authorAlbums
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
                    cache: false
                    source: albumService.getImagePath(
                                albumService.authorAlbums[index].albumID)
                }

                Text {
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
