#ifndef VARIABLE_H
#define VARIABLE_H

#include <QDesktopServices>
#include <QObject>
#include <QString>
#include <QUrl>
#include <QDir>
#include <QStringList>
#include <QDebug>
#include <QTextDocument>
#include <QPrinter>

static QString bookfoldernum;
static int oddcount;
static int evencount;

static QString bookname;

class startupclass : public QObject
{
    Q_OBJECT
public:
    Q_INVOKABLE void startupfunction() const {
        oddcount = 1;
        evencount = 2;
        if(QDir("/sdcard/scanqt/folders/").exists()) {
            QDir dir("/sdcard/scanqt/folders/");
            QStringList booklist = dir.entryList();
            QString lastbookname = booklist.at(booklist.size()-1);
            QString strbooknum = lastbookname.mid(4,5);

            int booknum = strbooknum.toInt() + 1;
            strbooknum = QString::number(booknum);

            int lenstrbooknum = strbooknum.length();
            QString strbzero = "";

            int numberofzero = 5 - lenstrbooknum;
            for (int i = 0 ; i < numberofzero ; i ++){
                strbzero = strbzero + "0";
            }
            QString directory = QString("/sdcard/scanqt/folders/book" + strbzero + strbooknum + "/");

            bookfoldernum = QString(strbzero + strbooknum);

            QDir().mkdir(directory);
        }
        else{
            QDir().mkdir("/sdcard/scanqt/");
            QDir().mkdir("/sdcard/scanqt/folders");
            QDir().mkdir("/sdcard/scanqt/folders/book00001/");
            bookfoldernum = QString("00001");
    }
    }
};

class oddpgnumclass : public QObject
{
    Q_OBJECT
public:
    Q_INVOKABLE QString getoddpgnum() const {
        QDir().mkdir("/sdcard/scanqt/");
        QString stroddcount = QString::number(oddcount);
        int lenstroddcount = stroddcount.length();
        QString strozero = "";
        int numberofzero = 5 - lenstroddcount;
        for (int i = 0 ; i < numberofzero ; i ++){
            strozero = strozero + "0";
        }
        QString directory = QString("/sdcard/scanqt/folders/book" + bookfoldernum + "/page"+ strozero + stroddcount);
        oddcount = oddcount+2;
        return directory;
    }
};

class evenpgnumclass : public QObject
{
    Q_OBJECT
public:
    Q_INVOKABLE QString getevenpgnum() const {
        QDir().mkdir("/sdcard/scanqt/");
        QString strevencount = QString::number(evencount);
        int lenstrevencount = strevencount.length();
        QString strezero = "";
        int numberofzero = 5 - lenstrevencount;
        for (int i = 0 ; i < numberofzero ; i ++){
            strezero = strezero + "0";
        }
        QString directory = QString("/sdcard/scanqt/folders/book" + bookfoldernum + "/page"+ strezero + strevencount);
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

class bookclass : public QObject
{
    Q_OBJECT
public:
    static QStringList dataList;
    Q_INVOKABLE QStringList getbook() const {
        QDir dir("/sdcard/scanqt/folders/");
        QStringList dirs = dir.entryList();
        dataList = dirs;
        return dataList;
    }
};

class booknameclass : public QObject
{
    Q_OBJECT
public:    
    Q_INVOKABLE void setbookname(QString nameofbook) const {
        bookname = nameofbook;
    }
};

class imagelistclass : public QObject
{
    Q_OBJECT
public:
    static QStringList imagelist;
    Q_INVOKABLE QStringList getimagelist() const {
        QDir dir("/sdcard/scanqt/folders/" + bookname);
        QStringList imagename = dir.entryList();
        imagelist = imagename;
        return imagelist;
    }
};

class opengalleryclass : public QObject
{
    Q_OBJECT
public:
    Q_INVOKABLE void opengallery(QString imageaddress) const {
        QDesktopServices::openUrl(QUrl("/sdcard/scanqt/folders/" + bookname + "/" + imageaddress, QUrl::TolerantMode));
      }
};


class continueclass : public QObject
{
    Q_OBJECT
public:
    Q_INVOKABLE int continuescan() const {
        //in this scope we should set bookfoldernum, oddcount, evencount for contnuing scannig
        //convert like this book00024 => 24, page00007 => 00007, we should detect odd and even pages
        bookfoldernum = bookname.mid(4,6);

        oddcount = 1;
        evencount = 2;
        //this pice of code 100% like class bookclass
        QDir dir("/sdcard/scanqt/folders/" + bookname + "/" );
        QStringList imagelist = dir.entryList();
        QString lastimgname = imagelist.at(imagelist.size()-1);
        //
        QString strlastimgnum = lastimgname.mid(4,5);

        int lastimgnum = strlastimgnum.toInt();

        int i = 2;
        //if last image number is odd
        if(lastimgnum % 2 != 0){
            oddcount = lastimgnum + 2;
            while( (lastimgnum % 2 != 0) & (imagelist.size()-i >= 0)){
                lastimgname = imagelist.at(imagelist.size()-i);
                strlastimgnum = lastimgname.mid(4,5);
                lastimgnum = strlastimgnum.toInt();
                if(lastimgnum % 2 == 0){
                    evencount = lastimgnum + 2;
                }
                i++;
            }
        }
        else{
            evencount = lastimgnum + 2;
            while( (lastimgnum % 2 == 0) & (imagelist.size()-i >= 0)){
                lastimgname = imagelist.at(imagelist.size()-i);
                strlastimgnum = lastimgname.mid(4,5);
                lastimgnum = strlastimgnum.toInt();
                if(lastimgnum % 2 != 0){
                    oddcount = lastimgnum + 2;
                }
                i++;
            }
        }
        return(1);
    }
};


class deletebookclass : public QObject
{
    Q_OBJECT
public:
    Q_INVOKABLE void deletebook() const {
        QDir dir("/sdcard/scanqt/folders/" + bookname + "/");
        dir.removeRecursively();
    }
};

class createpdfclass : public QObject
{
    Q_OBJECT
public:
    Q_INVOKABLE void createpdf() const {
        QTextDocument doc;
          doc.setHtml( "<p>A QTextDocument can be used to present formatted text "
                       "in a nice way.</p>"
                       "<p align=center>It can be <b>formatted</b> "
                       "<font size=+2>in</font> <i>different</i> ways.</p>"
                       "<p>The text can be really long and contain many "
                       "paragraphs. It is properly wrapped and such...</p>"
                       "<img src='/storage/emulated/0/book00001/page00001.jpg/'>");
           QPrinter printer;
           printer.setOutputFileName("/sdcard/scanqt/hello.pdf");
           printer.setOutputFormat(QPrinter::PdfFormat);
           doc.print(&printer);
           printer.newPage();
    }
};

#endif // VARIABLE_H
