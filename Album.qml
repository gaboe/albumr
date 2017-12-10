import QtQuick 2.9
import QtQuick.Layouts 1.3

Item {
    GridLayout {
        layoutDirection: "LeftToRight"
        columnSpacing: 15
        id: grid
        columns: 1
        Image {
            sourceSize.height: 150
            sourceSize.width: 150

            fillMode: Image.PreserveAspectFit
            source: applicationPath + "/tpab.jpg"
        }

        Text {
            text: "To Pimp A Butterfly"
        }

        Text {
            text: "2017"
        }
    }
}
