import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.3

Item {
    function addAlbum() {
        if (textEdit.text != "" && !/\D/.test(yearTextEdit.text)) {
            albumModel.addAlbum(textEdit.text,
                                  authorService.authorDetail.authorID,
                                  yearTextEdit.text, combobox.currentGenre)
            albumModel.setNewAuthorAlbums(authorService.authorDetail.authorID)
            textEdit.text = ""
            yearTextEdit.text = ""
        }
    }
    id: addAlbumWrapper
    width: authorDetail.width
    height: 80
    x: authorDetail.width * 0.15
    TextEdit {
        anchors.verticalCenter: addAlbumWrapper.verticalCenter
        anchors.top: authorDetailName.bottom
        anchors.margins: 20
        id: textEdit
        width: 200
        font.pointSize: 15
        property string placeholderText: "Add new album..."
        Keys.onEnterPressed: {
            addAlbum()
        }
        Text {
            font.pointSize: 15
            id: addAlbumPlaceholder
            text: textEdit.placeholderText
            color: "#aaa"
            visible: !textEdit.text
        }
    }

    TextEdit {
        anchors.verticalCenter: addAlbumWrapper.verticalCenter
        anchors.top: authorDetailName.bottom
        anchors.left: textEdit.right
        anchors.margins: 20
        id: yearTextEdit
        width: 100
        font.pointSize: 15
        property string placeholderText: "year"

        Keys.onEnterPressed: {
            addAlbum()
        }
        Text {
            font.pointSize: 15
            id: yearTextEditPlaceholed
            text: yearTextEdit.placeholderText
            color: "#aaa"
            visible: !yearTextEdit.text
        }
    }
    ComboBox {
        anchors.top: authorDetailName.bottom
        anchors.verticalCenter: addAlbumWrapper.verticalCenter
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
        anchors.verticalCenter: addAlbumWrapper.verticalCenter
        anchors.left: combobox.right
        text: "Add"
        highlighted: true
        Material.accent: Material.BlueGrey
        onClicked: {
            addAlbum()
        }
    }
}
