#ifndef VARIABLE_H
#define VARIABLE_H

#include <QDesktopServices>
#include <QTextDocument>
#include <QPrinter>
#include <QString>
#include <QImage>
#include <QUrl>
#include <QDir>
#include <QObject>
#include <QMatrix>
#include <algorithm>
#include <QStringList>
#include <QElapsedTimer>
#include <QImageReader>

static QString bookfoldernum;
static QString pagenum;
static int oddcount;
static int evencount;

static QString bookname;


class firsttimeclass : public QObject
{
    Q_OBJECT
public:
    Q_INVOKABLE bool isfirsttime() const {
        if(QDir("/sdcard/ScanQT/").exists()) {
            return(true);
        }
        return(false);
      }
};

class startupclass : public QObject
{
    Q_OBJECT
public:
    Q_INVOKABLE void startupfunction() const {
        oddcount = 1;
        evencount = 2;
        if(QDir("/sdcard/ScanQT/folders/").exists()) {
            QDir dir("/sdcard/ScanQT/folders/");
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
            QString directory = QString("/sdcard/ScanQT/folders/book" + strbzero + strbooknum + "/");

            bookfoldernum = QString(strbzero + strbooknum);

            QDir().mkdir(directory);
        }
        else{
            QDir().mkdir("/sdcard/ScanQT/");
            QDir().mkdir("/sdcard/ScanQT/folders");
            QDir().mkdir("/sdcard/ScanQT/folders/book00001/");
            bookfoldernum = QString("00001");
    }
    }
};

class oddpgnumclass : public QObject
{
    Q_OBJECT
public:
    Q_INVOKABLE QString getoddpgnum() const {
        QDir().mkdir("/sdcard/ScanQT/");
        QString stroddcount = QString::number(oddcount);
        int lenstroddcount = stroddcount.length();
        QString strozero = "";
        int numberofzero = 5 - lenstroddcount;
        for (int i = 0 ; i < numberofzero ; i ++){
            strozero = strozero + "0";
        }
        pagenum = strozero + stroddcount;

        QString directory = QString("/sdcard/ScanQT/folders/book" + bookfoldernum + "/page" + strozero + stroddcount);
        oddcount = oddcount + 2;
        return directory;
    }
};

class evenpgnumclass : public QObject
{
    Q_OBJECT
public:
    Q_INVOKABLE QString getevenpgnum() const {
        QDir().mkdir("/sdcard/ScanQT/");
        QString strevencount = QString::number(evencount);
        int lenstrevencount = strevencount.length();
        QString strezero = "";
        int numberofzero = 5 - lenstrevencount;
        for (int i = 0 ; i < numberofzero ; i ++){
            strezero = strezero + "0";
        }
        pagenum = strezero + strevencount;

        QString directory = QString("/sdcard/ScanQT/folders/book" + bookfoldernum + "/page" + strezero + strevencount);
        evencount = evencount + 2;
        return directory;
    }
};

class thumbnailclass : public QObject
{
    Q_OBJECT
public:
    Q_INVOKABLE QString createthumbnail(QString imagename) const {
/* creating thumbnails after click on view pages, for speed up resize photos i use this alorithm: https://web.archive.org/web/20120423092551/http://olliwang.com/2010/01/30/creating-thumbnail-images-in-qt/ */
        if(QDir("/sdcard/ScanQT/thumbnail/" + bookname + "/" + imagename).exists()) {
            return("file:///sdcard/ScanQT/thumbnail/" + bookname + "/" + imagename);
        }

        int length = 200;
        QImageReader image_reader("/sdcard/ScanQT/folders/" + bookname + "/" + imagename);
        int image_width = image_reader.size().width();
        int image_height = image_reader.size().height();
        if (image_width > image_height) {
          image_height = static_cast<double>(length) / image_width * image_height;
          image_width = length;
        }
        else if (image_width < image_height) {
          image_width = static_cast<double>(length) / image_height * image_width;
          image_height = length;
        }
        else {
          image_width = length;
          image_height = length;
        }
        image_reader.setScaledSize(QSize(image_width, image_height));
        QImage thumbnail = image_reader.read();

        if(thumbnail.height() < thumbnail.width()) {
            QMatrix matrix;
            matrix.rotate(90);
            thumbnail = thumbnail.transformed(matrix);
        }
        QDir().mkdir("/sdcard/ScanQT/thumbnail/");
        QDir().mkdir("/sdcard/ScanQT/thumbnail/" + bookname + "/");
        thumbnail.save("/sdcard/ScanQT/thumbnail/" + bookname + "/" + imagename);
        return("file:///sdcard/ScanQT/thumbnail/" + bookname + "/" + imagename);

/*creating thumbnails after click on view pages */
//        QString orginalpagestr = QString("/sdcard/ScanQT/folders/" + bookname + "/" + imagename);
//        QImage page;
//        page.load(orginalpagestr);

//        QMatrix matrix;
//        matrix.rotate(90);
//        if(page.height() < page.width()) {
//            page = page.scaledToWidth(100);
//            page = page.transformed(matrix);
//        }
//        else{
//            page = page.scaledToHeight(100);
//        }
//        QDir().mkdir("/sdcard/ScanQT/thumbnail/");
//        QDir().mkdir("/sdcard/ScanQT/thumbnail/" + bookname + "/");
//        page.save("/sdcard/ScanQT/thumbnail/" + bookname + "/" + imagename);
//        return("file:///sdcard/ScanQT/thumbnail/" + bookname + "/" + imagename);

/*creating thumbnails after cature photo */
//        QString logstr = pathtopreviewphoto;
//        logstr.replace("/","x");
//        QDir().mkdir("/sdcard/ScanQT/" + logstr + "/" );
//        QString orginalpagestr = QString("/sdcard/ScanQT/folders/book" + bookfoldernum + "/page" + pagenum + "jpg");
//        QString orginalpagestr = QString(pathtopreviewphoto);
//        QImage page;
//        page.load(orginalpagestr);

//        QMatrix matrix;
//        matrix.rotate(90);
//        if(page.height() < page.width()) {
//            page = page.scaledToWidth(100);
//            page = page.transformed(matrix);
//        }
//        else{
//            page = page.scaledToHeight(100);
//        }
//        QDir().mkdir("/sdcard/ScanQT/thumbnail/");
//        QDir().mkdir("/sdcard/ScanQT/thumbnail/book" + bookfoldernum + "/");
//        page.save("/sdcard/ScanQT/thumbnail/book" + bookfoldernum + "/page" + pagenum + "jpg");
    }
};

class bookthumbnailclass : public QObject
{
    Q_OBJECT
public:
    Q_INVOKABLE QString getbookthumbnail(QString bookfolder) const {

        if(QDir("/sdcard/ScanQT/thumbnail/" + bookname + ".jpg").exists()){
            return("/sdcard/ScanQT/thumbnail/" + bookfolder + ".jpg");
        }

        QDir dir("/sdcard/ScanQT/folders/" + bookfolder + "/");
        QStringList pageslist = dir.entryList();

        if(pageslist.size() > 2){
            int length = 200;
            QImageReader image_reader("/sdcard/ScanQT/folders/" + bookfolder + "/" + pageslist.at(2));
            int image_width = image_reader.size().width();
            int image_height = image_reader.size().height();
            if (image_width > image_height) {
              image_height = static_cast<double>(length) / image_width * image_height;
              image_width = length;
            }
            else if (image_width < image_height) {
              image_width = static_cast<double>(length) / image_height * image_width;
              image_height = length;
            }
            else {
              image_width = length;
              image_height = length;
            }
            image_reader.setScaledSize(QSize(image_width, image_height));
            QImage thumbnail = image_reader.read();

            if(thumbnail.height() < thumbnail.width()) {
                QMatrix matrix;
                matrix.rotate(90);
                thumbnail = thumbnail.transformed(matrix);
            }
            QDir().mkdir("/sdcard/ScanQT/thumbnail/");
            thumbnail.save("/sdcard/ScanQT/thumbnail/" + bookfolder + ".jpg");
            return("file:///sdcard/ScanQT/thumbnail/" + bookfolder + ".jpg");
        }
        return("");
      }
};

class emptyfoldersclass : public QObject
{
    Q_OBJECT
public:
    Q_INVOKABLE void remove() const {
        QDir dir("/sdcard/ScanQT/folders/");
        QStringList booklist = dir.entryList();
        //remove empty folders:
        for(int i = 2 ; i < booklist.size() ; i++){
            QDir dir("/sdcard/ScanQT/folders/" + booklist.at(i) + "/");
            QStringList pagelist = dir.entryList();
            if(pagelist.size() < 3){
                dir.removeRecursively();
            }
        }
      }
};

class openwebsiteclass : public QObject
{
    Q_OBJECT
public:
    Q_INVOKABLE void gotowebsite() const {
        QDesktopServices::openUrl(QUrl("http://www.ScanQT.com/en", QUrl::TolerantMode));
      }
    Q_INVOKABLE void getupdate() const {
        QDesktopServices::openUrl(QUrl("http://www.ScanQT.com/en/update-version-1-1-en", QUrl::TolerantMode));
      }
};

class bookclass : public QObject
{
    Q_OBJECT
public:
    static QStringList dataList;
    Q_INVOKABLE QStringList getbook() const {
        QDir dir("/sdcard/ScanQT/folders/");
        QStringList dirs = dir.entryList();

        //remove . and .. from the list:
        /**/QStringList outputqstrinlist;
        /**/for(int i=2 ; i<dirs.size() ; i++){
        /**/    outputqstrinlist.append( dirs.at(i) );
        /**/}

        //reverse the list:
        /**/std::reverse(outputqstrinlist.begin(), outputqstrinlist.end());

        dataList = outputqstrinlist;
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
    Q_INVOKABLE QString getbookname() const {
        return(bookname);
    }
};

class imagelistclass : public QObject
{
    Q_OBJECT
public:
    static QStringList imagelist;
    Q_INVOKABLE QStringList getimagelist() const {
        QDir dir("/sdcard/ScanQT/folders/" + bookname);
        QStringList imagename = dir.entryList();

        //remove . and .. from the list:
        /**/QStringList outputqstrinlist;
        /**/for(int i=2 ; i<imagename.size() ; i++){
        /**/    outputqstrinlist.append( imagename.at(i) );
        /**/}

        imagelist = outputqstrinlist;
        return imagelist;
    }
};

class opengalleryclass : public QObject
{
    Q_OBJECT
public:
    Q_INVOKABLE void opengallery(QString imageaddress) const {
        QDesktopServices::openUrl(QUrl("/sdcard/ScanQT/folders/" + bookname + "/" + imageaddress, QUrl::TolerantMode));
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
        QDir dir("/sdcard/ScanQT/folders/" + bookname + "/" );
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
        QDir dir("/sdcard/ScanQT/folders/" + bookname + "/");
        dir.removeRecursively();

        QDir dirthumb("/sdcard/ScanQT/thumbnail/" + bookname + "/");
        dirthumb.removeRecursively();

        QFile bookthumb("/sdcard/ScanQT/thumbnail/" + bookname + ".jpg");
        bookthumb.remove();
    }
};

class createpdfclass : public QObject
{
    Q_OBJECT
public:
    Q_INVOKABLE void createpdf() const {
        //QElapsedTimer timer;
        //timer.start();

        QDir dir("/sdcard/ScanQT/folders/" + bookname + "/" );
        QStringList imagelist = dir.entryList();

        QMatrix matrix;
        matrix.rotate(90);
        QImage page;
        for (int i = 0 ; i < imagelist.size() ; i ++){
            page.load("/sdcard/ScanQT/folders/" + bookname + "/" + imagelist.at(i));
            if(page.height() < page.width()) {
            page = page.transformed(matrix);
            page.save("/sdcard/ScanQT/folders/" + bookname + "/" + imagelist.at(i));
            }
        }

        QString myhtml;
        myhtml = "";
        for (int i = 2 ; i < imagelist.size() ; i ++){
            myhtml = myhtml + "<p><img width='826' src='" + "/sdcard/ScanQT/folders/" + bookname + "/" + imagelist.at(i) + "'></p><a href='http://ScanQT.com'>Scanned by ScanQT</a>";
        }

        QTextDocument doc;
        QSizeF size(826, 1169);
        doc.setPageSize(size);
        doc.setHtml( myhtml );
        QPrinter printer;

        printer.setOutputFileName("/sdcard/ScanQT/"+ bookname + ".pdf");
        printer.setOutputFormat(QPrinter::PdfFormat);
        printer.setPaperSize(QPrinter::A4);
        printer.setColorMode(QPrinter::GrayScale);
        printer.setFullPage(true);
        doc.print(&printer);
        printer.newPage();

        //QDir().mkdir("/sdcard/ScanQT/pdfpix_" + QString::number(timer.elapsed()) + "/");

        QDesktopServices::openUrl(QUrl("/sdcard/ScanQT/"+ bookname + ".pdf", QUrl::TolerantMode));
    }
};

#endif // VARIABLE_H
