import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import MeuiKit 1.0 as Meui

Item {
    id: buttonsView

    property var labels
    property var targets
    property int rowsCount: 5

    signal buttonClicked(string strToAppend)
    signal buttonLongPressed(string strToAppend)

    Grid {
        id: grid
        anchors.centerIn: parent
        anchors.margins: Meui.Units.smallSpacing
        columns: getColumnsCount()
        rows: buttonsView.rowsCount

        Repeater {
            model: buttonsView.labels

            MouseArea {
                id: buttonRect                
                width: buttonsView.width / grid.columns - Meui.Units.smallSpacing / 2
                height: buttonsView.height / grid.rows - Meui.Units.smallSpacing / 2
                onClicked: buttonsView.buttonClicked(targets[index])
                onPressAndHold: buttonsView.buttonLongPressed(targets[index])

                Rectangle {
                    anchors.centerIn: parent
                    radius: Meui.Theme.smallRadius
                    width: parent.width - radius
                    height: parent.height - radius
                    color: buttonRect.pressed ? Meui.Theme.highlightColor : Meui.Theme.backgroundColor

                    Behavior on color {
                        ColorAnimation {
                            duration: 50
                        }
                    }
                }

                Text {
                    anchors.fill: parent
                    text: modelData
                    horizontalAlignment: Qt.AlignHCenter
                    verticalAlignment: Qt.AlignVCenter
                    fontSizeMode: Text.Fit
                    minimumPointSize: Math.round(buttonRect.height / 5)
                    font.pointSize: Math.round(buttonRect.height / 4)

                    color: text === "+" || text === "−" || text === "×" || text === "÷"
                    ? buttonRect.pressed
                        ? Meui.Theme.textColor
                        : Meui.Theme.highlightColor
                    : Meui.Theme.textColor
                    font.bold: text === "+" || text === "−" || text === "×" || text === "÷"
                }
            }
        }
    }

    function getColumnsCount() {
        return Math.ceil(buttonsView.labels.length / buttonsView.rowsCount);
    }
}
