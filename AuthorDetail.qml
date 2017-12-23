import QtQuick 2.0

Item {
    id: authorDetail
    Text {
        font.pixelSize: 24
        text: "Author detail"
        id: authorDetailHeader
    }

    state: "hidden"
    states: [
        State {
            name: "focused"
            PropertyChanges {
                target: authorDetail
                visible: true
            }
        },
        State {
            name: "hidden"
            PropertyChanges {
                target: authorDetail
                visible: false
            }
        }
    ]
}
