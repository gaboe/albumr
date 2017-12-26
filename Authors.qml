import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.3

Item {
    y: 30
    x: 10
    id: authors
    width: (layout.width - leftMenu.width)
    function addAuthor() {
        if (textEdit.text != "" && lastName.text != "") {
            authorService.addAuthor(textEdit.text, lastName.text)
            textEdit.text = ""
            lastName.text = ""
            authorService.setNewAuthors()
            layout.state = "authors-view"
        }
    }
    Text {
        font.pixelSize: 24
        text: "Authors"
        id: authorsHeader
        anchors.centerIn: authors
    }

    Text {
        font.pixelSize: 12
        text: "Add new author:"
        id: addNewAuthorHeader
        anchors.top: authorsHeader
    }

    Item {
        id: addAuthorWrapper
        anchors.top: addNewAuthorHeader.bottom
        TextEdit {
            y: 40
            id: textEdit
            width: 150
            height: 10
            font.pointSize: 15

            property string placeholderText: "Firstname..."
            Keys.onEnterPressed: {
                addAuthor()
            }
            Text {
                text: textEdit.placeholderText
                font.pointSize: 15
                color: "#aaa"
                visible: !textEdit.text
            }
        }
        TextEdit {
            y: 40
            x: 160
            id: lastName
            width: 150
            height: 100
            font.pointSize: 15
            property string placeholderText: "Lastname..."
            Keys.onEnterPressed: {
                addAuthor()
            }
            Text {
                text: lastName.placeholderText
                font.pointSize: 15
                color: "#aaa"
                visible: !lastName.text
            }
            Button {
                x: 280
                font.pointSize: 15
                anchors.centerIn: textEdit.verticalCenter
                text: "Add"
                highlighted: true
                Material.accent: Material.BlueGrey
                onClicked: {
                    addAuthor()
                }
            }
        }
    }

    Rectangle {
        y: 120
        width: ((layout.width - leftMenu.width) * .75)
        height: layout.height

        ListView {
            id: list
            anchors.fill: parent
            model: authorService.authors
            delegate: Text {
                font.pointSize: 12
                id: authorItem
                property int authorID: list.model[index].authorID
                text: list.model[index].authorID + " " + list.model[index].firstName
                      + " " + list.model[index].lastName
                MouseArea {
                    cursorShape: Qt.PointingHandCursor
                    anchors.fill: parent
                    onClicked: {
                        layout.state = "author-detail-view"
                        authorService.setNewAuthorDetail(authorItem.authorID)
                        albumService.setNewAuthorAlbums(authorItem.authorID)
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
