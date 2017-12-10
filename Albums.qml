import QtQuick 2.9
import QtQuick.Layouts 1.3

Item {
    id: albums
    Text {
        font.pixelSize: 24
        text: "Albums"
        id: allbumsHeader
    }

    GridLayout {
        layoutDirection: "LeftToRight"
        columnSpacing: 15
        anchors.top: allbumsHeader.bottom
        id: grid
        columns: 3
        Album {
        }
    }
}
