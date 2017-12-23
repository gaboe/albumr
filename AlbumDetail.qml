import QtQuick 2.0

Item {
    id: albumDetail

    Text {
        font.pixelSize: 24
        text: "Album detail"
        id: albumDetailHeader
    }

    Text {
        id: albumDetailName
        text: ""
    }
    state: "hidden"
    states: [
        State {
            name: "focused"
            PropertyChanges {
                target: albumDetail
                visible: true
            }
        },
        State {
            name: "hidden"
            PropertyChanges {
                target: albumDetail
                visible: false
            }
        }
    ]
}
