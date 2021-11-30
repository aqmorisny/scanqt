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

StackView {

    ListModel {
        id: optionsModel
        ListElement {
            title: "View Pages"
            icon: "../images/file-document-box.png"
        }

        ListElement {
            title: "Continue Scanning"
            icon: "../images/scanner.png"
        }

        ListElement {
            title: "Create PDF"
            icon: "../images/file-pdf-box.png"
        }

        ListElement {            
            title: "Delete"
            icon: "../images/delete-forever.png"
        }

    }

    width: parent.width
    height: parent.height

    ListView {
        anchors.fill: parent
        model: optionsModel
        delegate: AndroidDelegate {
                text: title
                MouseArea{
                    id: touchArea
                    anchors.fill: parent
                    onPressed: if(text == "View Pages"){
                                   progress.visible = true;
                                   pageprogress.visible = true;
                               }
                               else if(text == "Create PDF"){
                                   progress.visible = true;
                                   pdfprogress.visible = true;
                               }
                    onClicked: if(text == "View Pages"){
                                   stackView.push(Qt.resolvedUrl("viewListPage.qml"))
                                   pageprogress.visible = false;
                                   progress.visible = false;
                               }
                               else if(text == "Continue Scanning"){
                                   mycontinue.continuescan() & stackView.push(Qt.resolvedUrl("declarative-camera.qml"))
                               }
                               else if(text == "Create PDF"){
                                   mycreatepdf.createpdf();
                                   pdfprogress.visible = false
                                   progress.visible = false;
                               }
                               else if(text == "Delete"){
                                   mydeletebook.deletebook() & stackView.pop() & stackView.pop() & stackView.push(Qt.resolvedUrl("BookListPage.qml"))
                               }
                }
            }

    }

    Rectangle {
        color: "#303030"

        border.color: "#009BCF"
        border.width: 3

        id: progress

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        width: parent.height / 2
        height: parent.width / 2

        visible: false

        Text {
            id: pdfprogress
            visible: false
            text: " Creating PDF . . . \n It may take several minutes "
            color: "White"
            anchors.centerIn: parent.Center
            font.bold: true
            anchors.fill: parent
            anchors.margins: 5
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
            style: Text.Raised
            styleColor: "black"
            font.pixelSize: 30
        }
        Text {
            id: pageprogress
            visible: false
            text: " Preparing pages . . . "
            color: "White"
            anchors.centerIn: parent.Center
            font.bold: true
            anchors.fill: parent
            anchors.margins: 5
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
            style: Text.Raised
            styleColor: "black"
            font.pixelSize: 30
        }
    }
}


