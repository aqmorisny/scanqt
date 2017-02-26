QT += qml quick
TARGET = touch
!no_desktop: QT += widgets

include(src/src.pri)
include(../shared/shared.pri)

OTHER_FILES += \
    main.qml \
    content/AndroidDelegate.qml \
    content/ButtonPage.qml \
    content/ListPage.qml \
    content/ProgressBarPage.qml \
    content/SliderPage.qml \
    content/TabBarPage.qml \
    content/TextInputPage.qml \
    content/OptionsPage.qml

RESOURCES += \
    resources.qrc

target.path = $$[QT_INSTALL_EXAMPLES]/quickcontrols/controls/touch
INSTALLS += target

QT += printsupport

SUBDIRS += \
    content/declarative-camera.pro

DISTFILES += \
    content/CameraButton.qml \
    content/CameraListButton.qml \
    content/CameraListPopup.qml \
    content/CameraPropertyButton.qml \
    content/CameraPropertyPopup.qml \
    content/declarative-camera.qml \
    content/FocusButton.qml \
    content/PhotoCaptureControls.qml \
    content/PhotoPreview.qml \
    content/Popup.qml \
    content/VideoCaptureControls.qml \
    content/VideoPreview.qml \
    content/ZoomControl.qml \
    content/OptionsPage.qml \
    android-sources/AndroidManifest.xml
ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android-sources
