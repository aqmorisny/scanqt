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
import QtQuick.Window 2.2

import "content"

ApplicationWindow {
    visible: true
    width: 800
    height: 1280

    Rectangle {
        color:"#FFFFFF"
        anchors.fill: parent
        Image {
            id: scanqtlogo
            source: "images/scanqt_logo_contrast.png"
            anchors.verticalCenter: parent.verticalCenter
            //width: parent.width
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            visible: stackView.depth < 2
        }
    }

    toolBar: BorderImage {
        id: toolbarscope
        x: 0
        y: 0
        border.bottom: 8
        source: "images/toolbar.png"
        width: parent.width
        height: 80

        Rectangle {
            id: backButton
            width: opacity ? 72 : 0
            anchors.left: parent.left
            anchors.leftMargin: 20
            opacity: stackView.depth > 2 ? 2 : 0
            anchors.verticalCenter: parent.verticalCenter
            antialiasing: true
            height: 72
            radius: 4
            color: backmouse.pressed ? "#222" : "transparent"
            Behavior on opacity { NumberAnimation{} }
            Image {
                anchors.centerIn: parent
                //anchors.verticalCenter: parent.verticalCenter
                source: "images/navigation_previous_item.png"
            }
            MouseArea {
                id: backmouse
                anchors.fill: parent
                anchors.margins: -10
                onClicked: if (stackView.depth > 3) {
                               stackView.pop();
                               event.accepted = true;
                           }
                           else if(stackView.depth == 3){
                               myemptyfolders.remove()
                               stackView.pop();
                               stackView.pop();
                               stackView.push(Qt.resolvedUrl("content/BookListPage.qml"))
                               event.accepted = true;
                           }
            }
        }

        Rectangle {
            id: hamburgerbutton
            width: opacity ? 72 : 0
            anchors.left: parent.left
            anchors.leftMargin: 20
            opacity: stackView.depth <= 2 ? 2 : 0
            anchors.verticalCenter: parent.verticalCenter
            antialiasing: true
            height: 72
            radius: 4
            color: hamburgermouse.pressed ? "#222" : "transparent"
            Behavior on x { NumberAnimation{ easing.type: Easing.OutCubic} }
            x: backButton.x + backButton.width + 10

            Image {
                anchors.centerIn: parent
                //anchors.verticalCenter: parent.verticalCenter
                source: "images/hamburger_button.png"
            }
            MouseArea{
                id: hamburgermouse
                anchors.fill: parent
                onClicked: {
                    stackView.push(Qt.resolvedUrl("content/HamburgerPage.qml")) & mythumbnail.createthumbnail()
                    }
                }
        }

        Rectangle {
            id: helpbutton
            width: opacity ? 72 : 0
            anchors.right: parent.right
            anchors.rightMargin: 20
            opacity: stackView.depth <= 2 ? 2 : 0
            anchors.verticalCenter: parent.verticalCenter
            antialiasing: true
            height: 72
            radius: 4
            color: helpmouse.pressed ? "#222" : "transparent"
            Behavior on x { NumberAnimation{ easing.type: Easing.OutCubic} }
            x: backButton.x + backButton.width + 10

            Image {
                anchors.centerIn: parent
                //anchors.verticalCenter: parent.verticalCenter
                source: "images/help-circle-outline.png"
            }
            MouseArea{
                id: helpmouse
                anchors.fill: parent
                onClicked: {
                    stackView.push(Qt.resolvedUrl("content/help-0.qml"))
                    }
                }
        }

        Text {
            id: apptitle
            font.pixelSize: 42
            x: if( stackView.depth <= 2 ){
                   hamburgerbutton.x + hamburgerbutton.width + 30
               }
               else{
                   backButton.x + backButton.width + 30
               }
            anchors.verticalCenter: parent.verticalCenter
            color: "white"
            text: "ScanQT"
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent
        // Implements back key navigation
        focus: true
        Keys.onReleased: if (event.key === Qt.Key_Back && stackView.depth > 3) {
                             stackView.pop();
                             event.accepted = true;
                         }
                         else if(event.key === Qt.Key_Back && stackView.depth == 3){
                             myemptyfolders.remove()
                             stackView.pop();
                             stackView.pop();
                             stackView.push(Qt.resolvedUrl("content/BookListPage.qml"))
                             event.accepted = true;
                         }

        initialItem: Item {
            width: parent.width
            height: parent.height
            ListView {
                anchors.rightMargin: 4
                anchors.bottomMargin: -8
                anchors.leftMargin: 4
                anchors.topMargin: 8
                model: pageModel
                anchors.fill: parent
                delegate: AndroidDelegate {
                    text: title
                    onClicked: if(text == "New Scan"){
                               //    stackView.push(Qt.resolvedUrl(page)) & mystartup.startupfunction()
                               }
//                               else if(text == "Website") {
//                                   myopenwebsite.gotowebsite()
//                               }
//                               else if(text == "Check For Update") {
//                                   myopenwebsite.gotowebsite()
//                               }
//                               else {
//                                   stackView.push(Qt.resolvedUrl(page))
//                               }
                    Component.onCompleted: myemptyfolders.remove()
                }
            }
        }
        Component.onCompleted: stackView.push(Qt.resolvedUrl("content/BookListPage.qml"))
    }
}
