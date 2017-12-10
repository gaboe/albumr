import QtQuick 2.9
import QtQuick.Layouts 1.3

GridLayout {
    layoutDirection: "LeftToRight"
    columnSpacing: 15
    id: grid
    columns: 1
    Text {
        font.pixelSize: 24
        text: "Albums"
    }

    Text {
        text: "Mazec"
    }
}
