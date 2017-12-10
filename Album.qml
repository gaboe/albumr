import QtQuick 2.9
import QtQuick.Layouts 1.3

Item {
    GridLayout {
        layoutDirection: "LeftToRight"
        columnSpacing: 15
        id: grid
        columns: 1
        Text {
            text: "Image"
        }

        Text {
            text: "To Pimp A Butterfly"
        }

        Text {
            text: "2016"
        }
    }
}
