import QtQuick 2.9
import QtQuick.Layouts 1.3

Item {
    GridLayout {
        columnSpacing: 15
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
            text: year
        }
    }
}
