import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Scroll")

    RowLayout {
        id: layout
        anchors.fill: parent
        state: "none"
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.minimumWidth: 20
            Layout.preferredWidth: 20
            Layout.minimumHeight: 150
            LeftMenu {
                id: leftMenu
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.minimumWidth: 100
            Layout.minimumHeight: 150

            Albums {
                id: albumsView
            }

            Authors {
                id: authorsView
            }

            AlbumDetail {
                id: albumDetailView
            }

            AuthorDetail {
                id: authorDetailView
            }
        }

        states: [
            State {
                name: "none"
            },
            State {
                name: "albums-view"
                PropertyChanges {
                    target: albumsView
                    state: "focused"
                }
                PropertyChanges {
                    target: authorsView
                    state: "hidden"
                }
                PropertyChanges {
                    target: authorDetailView
                    state: "hidden"
                }
                PropertyChanges {
                    target: albumDetailView
                    state: "hidden"
                }
            },
            State {
                name: "authors-view"
                PropertyChanges {
                    target: authorsView
                    state: "focused"
                }
                PropertyChanges {
                    target: albumsView
                    state: "hidden"
                }
                PropertyChanges {
                    target: authorDetailView
                    state: "hidden"
                }
                PropertyChanges {
                    target: albumDetailView
                    state: "hidden"
                }
            },
            State {
                name: "author-detail-view"
                PropertyChanges {
                    target: authorsView
                    state: "hidden"
                }
                PropertyChanges {
                    target: albumsView
                    state: "hidden"
                }
                PropertyChanges {
                    target: authorDetailView
                    state: "focused"
                }
                PropertyChanges {
                    target: albumDetailView
                    state: "hidden"
                }
            },
            State {
                name: "album-detail-view"
                PropertyChanges {
                    target: authorsView
                    state: "hidden"
                }
                PropertyChanges {
                    target: albumsView
                    state: "hidden"
                }
                PropertyChanges {
                    target: authorDetailView
                    state: "hidden"
                }
                PropertyChanges {
                    target: albumDetailView
                    state: "focused"
                }
            }
        ]
    }
}
