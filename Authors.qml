import QtQuick 2.0

Item {
    id: authors
    Text {
        font.pixelSize: 24
        text: "Authors"
        id: albumsHeader
    }

    state: "hidden"

    states: [
        State {
            name: "focused"
            PropertyChanges {
                target: authors
                visible: true
            }
        },
        State {
            name: "hidden"
            PropertyChanges {
                target: authors
                visible: false
            }
        }
    ]
}
