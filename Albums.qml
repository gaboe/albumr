import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.3

Item {
    y: 30
    width: (layout.width - leftMenu.width)
    id: albums
    property variant colorArray: ["#00bde3", "#67c111", "#ea7025"]
    state: "focused"
    function filter() {
        albumService.filterAlbums(filterByNameTextEdit.text,
                                  filterByGenreTextEdit.text,
                                  filterByYearTextEdit.text)
    }

    Text {
        anchors.top: albums.bottom
        anchors.centerIn: albums
        font.pixelSize: 24
        text: "Albums"
        id: albumsHeader
    }

    Item {
        id: filtersWrapper
        anchors.top: albumsHeader.bottom
        width: albums.width
        TextEdit {
            anchors.top: filtersWrapper.top
            anchors.margins: 20
            id: filterByNameTextEdit
            width: 200
            height: 50
            property string placeholderText: "Author name..."
            onTextChanged: {
                filter()
            }
            Text {
                id: filterByNameTextEditPlaceholder
                text: filterByNameTextEdit.placeholderText
                color: "#aaa"
                visible: !filterByNameTextEdit.text
            }
        }
        TextEdit {
            anchors.top: filtersWrapper.top
            anchors.left: filterByNameTextEdit.right
            anchors.margins: 20
            id: filterByYearTextEdit
            width: 200
            height: 50
            property string placeholderText: "Year..."
            onTextChanged: {
                filter()
            }
            Text {
                id: filterByYearTextEditPlaceholder
                text: filterByYearTextEdit.placeholderText
                color: "#aaa"
                visible: !filterByYearTextEdit.text
            }
        }
        TextEdit {
            anchors.top: filtersWrapper.top
            anchors.margins: 20
            anchors.left: filterByYearTextEdit.right
            id: filterByGenreTextEdit
            width: 200
            height: 50
            property string placeholderText: "Genre..."
            onTextChanged: {
                filter()
            }

            Text {
                id: filterByGenreTextEditPlaceholder
                text: filterByGenreTextEdit.placeholderText
                color: "#aaa"
                visible: !filterByGenreTextEdit.text
            }
        }
    }

    Grid {
        anchors.top: filtersWrapper.bottom
        anchors.topMargin: 50
        id: grid
        anchors.fill: parent
        anchors.margins: 8
        spacing: 4

        Repeater {
            id: albumsRepeater
            model: albumService.albums
            delegate: Album {
            }
        }
    }

    states: [
        State {
            name: "focused"
            PropertyChanges {
                target: albums
                visible: true
            }
        },
        State {
            name: "hidden"
            PropertyChanges {
                target: albums
                visible: false
            }
        }
    ]
}
