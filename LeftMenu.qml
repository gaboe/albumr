import QtQuick 2.9
import QtQuick.Controls 2.2

ListView {
    width: parent.width
    model: ListModel {
        ListElement {
            name: "Albums"
        }
        ListElement {
            name: "Authors"
        }
    }
    delegate: ItemDelegate {
        text: name
        width: parent.width
    }
}
