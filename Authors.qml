import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.3

Item {
    y: 30
    x: 10
    id: authors
    width: (layout.width - leftMenu.width)
    function addAuthor() {
        if (textEdit.text != "") {
            authorModel.addAuthor(textEdit.text)
            textEdit.text = ""
            authorModel.setNewAuthors()
            layout.state = "authors-view"
        }
    }
    Text {
        font.pixelSize: 28
        text: "Authors"
        id: authorsHeader
        anchors.centerIn: authors
    }

    Text {
        font.pixelSize: 12
        text: "Add new author:"
        id: addNewAuthorHeader
        anchors.top: authorsHeader.bottom
        height: 20
    }

    Item {
        id: addAuthorWrapper
        anchors.top: addNewAuthorHeader.bottom
        height: 80

        TextEdit {
            anchors.verticalCenter: addAuthorWrapper.verticalCenter
            anchors.top: addNewAuthorHeader.bottom
            anchors.margins: 20
            id: textEdit
            width: 200
            font.pointSize: 15
            property string placeholderText: "New author..."
            Keys.onEnterPressed: {
                addAuthor()
            }
            Text {
                font.pointSize: 15
                id: addAlbumPlaceholder
                text: textEdit.placeholderText
                color: "#aaa"
                visible: !textEdit.text
            }
        }

        Button {
            height: 40
            width: 60
            anchors.margins: 15
            anchors.verticalCenter: addAuthorWrapper.verticalCenter
            anchors.left: textEdit.right
            text: "Add"
            highlighted: true
            Material.accent: Material.BlueGrey
            onClicked: {
                addAuthor()
            }
        }
    }

    Rectangle {
        y: 120
        x: 10
        width: ((layout.width - leftMenu.width) * .75)
        height: layout.height

        ListView {
            id: list
            anchors.fill: parent
            model: authorModel.authors
            delegate: Text {
                font.pointSize: 12
                id: authorItem
                property int authorID: list.model[index].authorID
                text: list.model[index].authorID + " " + list.model[index].name
                MouseArea {
                    cursorShape: Qt.PointingHandCursor
                    anchors.fill: parent
                    onClicked: {
                        layout.state = "author-detail-view"
                        authorModel.setNewAuthorDetail(authorItem.authorID)
                        albumModel.setNewAuthorAlbums(authorItem.authorID)
                    }
                }
                Image {
                    anchors.topMargin: 10
                    anchors.leftMargin: 10
                    anchors.right: authorItem.left
                    id: icon
                    source: applicationPath + "/delete.svg"
                    sourceSize.height: 16
                    sourceSize.width: 16
                    MouseArea {
                        cursorShape: Qt.PointingHandCursor
                        anchors.fill: parent
                        onClicked: {
                            albumModel.deleteAlbumsByAuthorID(
                                        authorItem.authorID)
                            authorModel.deleteAuthor(authorItem.authorID)
                            authorModel.setNewAuthors()
                        }
                    }
                }
            }
            focus: true
            onCurrentItemChanged: {

            }
        }
    }

    state: "hidden"
    states: [
        State {
            name: "focused"
            PropertyChanges {
                target: authors
                visible: true
            }
        },
        State {
            name: "hidden"
            PropertyChanges {
                target: authors
                visible: false
            }
        }
    ]
}
