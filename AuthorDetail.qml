import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.3

Item {
    y: 30
    id: authorDetail
    width: (layout.width - leftMenu.width)
    anchors.topMargin: 20
    function addAlbum() {
        if (textEdit.text != "") {
            albumService.addAlbum(textEdit.text,
                                  authorService.authorDetail.authorID, 2017,
                                  combobox.currentGenre)
            albumService.setNewAuthorAlbums(authorService.authorDetail.authorID)
            textEdit.text = ""
        }
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

            //anchors.left: authorAlbumsWrapper.right
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

        ComboBox {
            anchors.top: authorDetailName.bottom
            anchors.verticalCenter: textEdit.verticalCenter
            anchors.left: textEdit.right
            id: combobox
            currentIndex: 2
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
