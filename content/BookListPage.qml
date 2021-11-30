/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.1

ScrollView {
    width: parent.width
    height: parent.height

    flickableItem.interactive: true

    ListView {
        id: folderslist
        anchors.fill: parent
        model: mybook.getbook()
        delegate: AndroidDelegate {
            Image {
                id: bookthumbnail
                anchors.leftMargin: 20
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                source: mybookthumbnail.getbookthumbnail(modelData)
                width: 80
                height: 80
                fillMode: Image.PreserveAspectCrop
                clip: true
            }
            text: modelData
            onClicked: stackView.push(Qt.resolvedUrl("OptionsPage.qml")) & mybookname.setbookname(text)
            }

//        Rectangle{
//            visible: folderslist.model.length == 0
//            anchors.top: redarrow1.bottom
//            anchors.topMargin: parent.height / 6
//            anchors.horizontalCenter: parent.horizontalCenter
//            height: 100
//            width: 200
//            border.width: 2
//            border.color: black
//            radius: 4
//            Text {
//                id: learntext
//                visible: folderslist.model.length == 0
//                color: "red"
//                font.pixelSize: 60
//                font.bold: true
//                text: qsTr("راهنما")
//                anchors.centerIn: parent
//            }
//        }

//        Rectangle{
//            id: redarrow1
//            visible: folderslist.model.length == 0
//            height: 150
//            width: 150
//            color: "transparent"
//            anchors.top: parent.top
//            anchors.topMargin: 5
//            anchors.left: parent.left
//            anchors.leftMargin: 70
//            Image {
//                anchors.fill: parent
//                source: "../images/red_arrow_flip.png"
//            }
//        }
//        Text {
//            id: moreinfotext
//            visible: folderslist.model.length == 0
//            color: "red"
//            font.pixelSize: 20
//            font.bold: true
//            text: qsTr(". . .")
//            anchors.left: redarrow1.right
//            anchors.leftMargin: 5
//            anchors.verticalCenter: redarrow1.verticalCenter
//        }
        Rectangle{
            id: redarrow1
            visible: folderslist.model.length == 0
            height: 150
            width: 150
            rotation: -90
            color: "transparent"
            anchors.right: parent.right
            anchors.rightMargin: 70
            anchors.top: parent.top
            anchors.topMargin: 5
            Image {
                anchors.fill: parent
                source: "../images/red_arrow.png"
            }
        }
        Text {
            id: helptext
            visible: folderslist.model.length == 0
            color: "red"
            font.pixelSize: 40
            font.bold: true
            text: qsTr("Help")
            anchors.right: redarrow1.left
            anchors.rightMargin: 5
            anchors.verticalCenter: redarrow1.verticalCenter
        }

        Rectangle{
            id: redarrow2
            visible: folderslist.model.length == 0
            height: 150
            width: 150
            color: "transparent"
            anchors.right: circleButtom.left
            anchors.bottom: circleButtom.top
            Image {
                anchors.fill: parent
                source: "../images/red_arrow.png"
            }
        }
        Text {
            id: starttext
            visible: folderslist.model.length == 0
            color: "red"
            font.pixelSize: 40
            font.bold: true
            text: qsTr("Start")
            anchors.bottom: redarrow2.top
            anchors.horizontalCenter: redarrow2.horizontalCenter
        }


        Rectangle {
            id: circleButtom
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            width: parent.height / 8
            height: width
            anchors.margins: parent.width / 15
            color: "white"
            border.color: "gray"
            border.width: 3
            radius: width*0.5
            Text {
                id: circleButtomText
                text: "+"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                color: "black"
                font.pixelSize: parent.height / 1.5
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
                style: Text.Raised
                styleColor: "gray"
            }
        }
        Rectangle{
            id: circleButtomClickArea
            color: "#00000000"
            anchors.horizontalCenter: circleButtom.horizontalCenter
            anchors.verticalCenter: circleButtom.verticalCenter
            width: parent.height / 8
            height: width
            MouseArea{
                anchors.fill: parent
                onPressed: {
                    circleButtom.color = "black"
                    circleButtom.border.color = "white"
                    circleButtomText.color = "white"
                }
                onClicked: {
                    stackView.push(Qt.resolvedUrl("declarative-camera.qml")) & mystartup.startupfunction()
                    }
                onReleased: {
                    circleButtom.color = "white"
                    circleButtom.border.color = "gray"
                    circleButtomText.color = "black"
                    }
                }
            }
    }

    style: ScrollViewStyle {
        transientScrollBars: true
        handle: Item {
            implicitWidth: 14
            implicitHeight: 26
            Rectangle {
                color: "#424246"
                anchors.fill: parent
                anchors.topMargin: 6
                anchors.leftMargin: 4
                anchors.rightMargin: 4
                anchors.bottomMargin: 6
            }
        }
        scrollBarBackground: Item {
            implicitWidth: 14
            implicitHeight: 26
        }
    }
}


