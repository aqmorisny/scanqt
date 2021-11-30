/****************************************************************************
**
** Copyright (C) 2015 The Qt Company Ltd.
** Contact: http://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
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

import QtQuick 2.0
import QtMultimedia 5.4


FocusScope {
    smooth: true

    rotation: 90

    property Camera camera
    property bool previewAvailable : false
    property bool isfocused : false

    property int buttonsPanelWidth: buttonPaneShadow.width

    signal previewSelected
    signal videoModeSelected
    property alias cameraButton1: cameraButton1

    id : captureControls

    Rectangle{
        smooth: true
        width: parent.height
        height: parent.width
        color: "#00000000"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter


    Rectangle {
        id: buttonPaneShadow
        width: bottomColumn.width + 16
        height: parent.height
        anchors.top: parent.top
        anchors.right: parent.right
        color: Qt.rgba(0.08, 0.08, 0.08, 1)

        Column {
            //unvisible all button when image captured
            visible: camera.imageCapture.ready
            anchors {
                right: parent.right
                top: parent.top
                margins: 8
            }

            id: buttonsColumn
            spacing: 8

//            FocusButton {
//                camera: captureControls.camera
//                visible: camera.cameraStatus == Camera.ActiveStatus && camera.focus.isFocusModeSupported(Camera.FocusAuto)
//            }

            CameraPropertyButton {
                id : wbModesButton
                value: CameraImageProcessing.WhiteBalanceAuto
                model: ListModel {
                    ListElement {
                        icon: "../images/camera_auto_mode.png"
                        value: CameraImageProcessing.WhiteBalanceAuto
                        text: "Auto"
                    }
                    ListElement {
                        icon: "../images/camera_white_balance_sunny.png"
                        value: CameraImageProcessing.WhiteBalanceSunlight
                        text: "Sunny"
                    }
                    ListElement {
                        icon: "../images/camera_white_balance_cloudy.png"
                        value: CameraImageProcessing.WhiteBalanceCloudy
                        text: "Cloudy"
                    }
                    ListElement {
                        icon: "../images/camera_white_balance_incandescent.png"
                        value: CameraImageProcessing.WhiteBalanceTungsten
                        text: "Tungsten"
                    }
                    ListElement {
                        icon: "../images/camera_white_balance_flourescent.png"
                        value: CameraImageProcessing.WhiteBalanceFluorescent
                        text: "Fluorescent"
                    }
                }
                onValueChanged: captureControls.camera.imageProcessing.whiteBalanceMode = wbModesButton.value
                //onValueChanged: captureControls.camera.imageProcessing.setWhiteBalanceMode(wbModesButton.value)
            }

            CameraButton {
                id: flashButton
                Image {
                    id: flashButtonIcon
                    anchors.centerIn: parent
                    source: "../images/camera_flash_fill.png"
                }
                //i can't set visiblity, if device has not flash the button should be hiden
//                visible: {
//                    camera.flash.mode = Camera.FlashOff
//                    if(camera.flash.mode == Camera.FlashVideoLight){
//                        return true
//                    }
//                    else{
//                        return false
//                    }
//                }
                onClicked: if(camera.flash.mode == Camera.FlashVideoLight){
                               camera.flash.mode = Camera.FlashOff
                               flashButtonIcon.source = "../images/camera_flash_fill.png"
                           }
                           else{
                               camera.flash.mode = Camera.FlashVideoLight
                               flashButtonIcon.source = "../images/camera_flash_off.png"
                           }

            }

//            CameraButton {
//                text: "captureControls.camera"
//                onClicked: captureControls.camera.imageProcessing.setColorFilter(CameraImageProcessing.ColorFilterNegative)
//            }
        }

        Column {
            anchors {
                right: parent.right
                verticalCenter: parent.verticalCenter
                margins: 8
            }

            id: middleColumn
            spacing: 8

            CameraButton {
                id: cameraButton1
                visible: camera.imageCapture.ready
                //text: "Capture odd page"
                Text {
                    rotation: -90
                    text: "Odd"
                    color: "White"
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.margins: 5
                    elide: Text.ElideRight
                    font.bold: true
                    style: Text.Raised
                    styleColor: "black"
                    font.pixelSize: 30
                }

                Image {
                    //anchors.centerIn: parent
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.margins: 5
                    source: "../images/camera_capture_button.png"
                }

                MouseArea{
                    anchors.fill: parent
                    onPressed: camera.searchAndLock();
                    onClicked: {
                        var timeStart = new Date().getTime();
                        while (new Date().getTime() - timeStart < 1000) {
                            // Do nothing
                        }
                        camera.imageCapture.captureToLocation(myoddpgnum.getoddpgnum());
                    }
//                    onReleased: {
//                        var timeStart = new Date().getTime();
//                        while (new Date().getTime() - timeStart < 1000) {
//                            // Do nothing
//                        }
//                        mythumbnail.createthumbnail();
//                    }
                }
            }
        }

        Column {
            anchors {
                bottom: parent.bottom
                right: parent.right
                margins: 8
            }

            id: bottomColumn
            spacing: 8

            CameraButton {
                id: cameraButton2
                visible: camera.imageCapture.ready
                //text: "Capture even page"

                Text {
                    rotation: -90
                    text: "Even"
                    color: "White"
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.margins: 1
                    elide: Text.ElideRight
                    font.bold: true
                    style: Text.Raised
                    styleColor: "black"
                    font.pixelSize: 30
                }

                Image {
                    //anchors.centerIn: parent
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.margins: 5
                    source: "../images/camera_capture_button.png"
                }

                MouseArea{
                    anchors.fill: parent
                    onPressed: camera.searchAndLock();
                    onClicked: {
                        var timeStart = new Date().getTime();
                        while (new Date().getTime() - timeStart < 1000) {
                            // Do nothing
                        }
                        camera.imageCapture.captureToLocation(myevenpgnum.getevenpgnum())
                    }
//                    onReleased: {
//                        var timeStart = new Date().getTime();
//                        while (new Date().getTime() - timeStart < 1000) {
//                            // Do nothing
//                        }
//                        mythumbnail.createthumbnail();
//                    }
                }


                //text: "Switch to Video"
                //onClicked: captureControls.videoModeSelected()
            }

            //CameraListButton {
            //    model: QtMultimedia.availableCameras
            //    onValueChanged: captureControls.camera.deviceId = value
            //}


            //            CameraButton {
            //                id: quitButton
            //                text: "Quit"
            //                onClicked: Qt.quit()
            //            }
        }


    }


    ZoomControl {
        x : 0
        y : 0
        width : 100
        height: parent.height

        currentZoom: camera.digitalZoom
        maximumZoom: Math.min(4.0, camera.maximumDigitalZoom)
        onZoomTo: camera.setDigitalZoom(value)
    }

   }
}
