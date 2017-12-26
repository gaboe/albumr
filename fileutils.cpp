#include "fileutils.h"
#include <QFileInfo>
#include <QString>
#include <QDebug>
FileUtils::FileUtils(QObject *parent) : QObject(parent)
{

}

bool FileUtils::imageExists(int albumID)
{
    auto path = this->applicationPath().append("/").append(QString::number(albumID)).append(".jpg");
    QFile file(path);
    auto exists = file.exists();
    return exists;
    // check if file exists and if yes: Is it really a file and no directory?
}

QString FileUtils::getImagePath(int albumID)
{
    if(this->imageExists(albumID)){
        return this->imagePath().append("/").append(QString::number(albumID)).append(".jpg");
    }
    return this->imagePath().append("/").append("empty").append(".jpg");

}

void FileUtils::setNewImage(int albumID, QString path)
{

    auto newPath = this->applicationPath().append("/").append(QString::number(albumID)).append(".jpg");
    if (QFile::exists(newPath))
    {
        QFile::remove(newPath);
    }

    qDebug() << newPath;
    qDebug() << path;
    QFile::copy(path.replace(0,7,""),newPath );
}

