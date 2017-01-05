#ifndef VARIABLE_H
#define VARIABLE_H

#include <QDesktopServices>
#include <QObject>
#include <QString>
#include <QUrl>

class oddpgnumclass : public QObject
{
    Q_OBJECT
public:
    static int oddcount;
    Q_INVOKABLE QString getoddpgnum() const {
        QString directory = QString("/sdcard/scanqt/book%1.jpg").arg(oddcount);
        oddcount = oddcount+2;
        return directory;
    }
};

class evenpgnumclass : public QObject
{
    Q_OBJECT
public:
    static int evencount;
    Q_INVOKABLE QString getevenpgnum() const {
        QString directory = QString("/sdcard/scanqt/book%1.jpg").arg(evencount);
        evencount = evencount+2;
        return directory;
    }
};

class openwebsiteclass : public QObject
{
    Q_OBJECT
public:
    Q_INVOKABLE void gotowebsite() const {
        QDesktopServices::openUrl(QUrl("http://www.scanqt.com", QUrl::TolerantMode));
      }
};

#endif // VARIABLE_H
