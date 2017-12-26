#include "albumservice.h"
#include "album.h"
#include "song.h"
#include <QObject>
#include <QSqlQuery>
#include <QSqlRecord>
#include <QVariant>
#include <QSqlError>
#include <QFileInfo>

AlbumService::AlbumService(QObject *parent) : QObject(parent)
{

}

QList<QVariant> AlbumService::getAlbums()
{
    QSqlQuery query;
    QString queryString = "SELECT Albums.AlbumID, Albums.Name, Albums.AuthorID, Albums.Year, Albums.GenreID, Authors.FirstName, Authors.LastName,  Genres.Name as GenreName FROM Albums JOIN Authors  on Authors.AuthorID = Albums.AuthorID  JOIN Genres on Genres.GenreID = Albums.GenreID";

    query.exec(queryString);
    auto list = new QList<QVariant>();
    while (query.next()) {
        QSqlRecord record = query.record();

        auto album = new Album();
        album->setAlbumID(record.value("AlbumID").toInt());
        album->setName(record.value("Name").toString());
        album->setYear(record.value("Year").toInt());
        album->setGenreName(record.value("GenreName").toString());
        album->setAuthorID(record.value("AuthorID").toInt());
        album->setAuthorName(record.value("FirstName").toString() + " " + record.value("LastName").toString());
        album->setImagePath(getImagePath(album->albumID()));
        QVariant v = QVariant::fromValue(album);
        qDebug() << album->imagePath();
        list->insert(list->size(),v);
    }
    return *list;
}

QVariant AlbumService::getAlbum(int albumID)
{
    QSqlQuery query;
    QString queryString = "SELECT Albums.AlbumID, Albums.Name, Albums.AuthorID, Albums.Year, Albums.GenreID, Authors.FirstName, Authors.LastName,  Genres.Name as GenreName FROM Albums JOIN Authors  on Authors.AuthorID = Albums.AuthorID  JOIN Genres on Genres.GenreID = Albums.GenreID";
    queryString.append(" WHERE Albums.AlbumID = ");
    queryString.append(QString::number(albumID));
    query.exec(queryString);
    while (query.next()) {
        QSqlRecord record = query.record();

        auto album = new Album();
        album->setAlbumID(record.value("AlbumID").toInt());
        album->setName(record.value("Name").toString());
        album->setYear(record.value("Year").toInt());
        album->setGenreName(record.value("GenreName").toString());
        album->setAuthorID(record.value("AuthorID").toInt());
        album->setAuthorName(record.value("FirstName").toString() + " " + record.value("LastName").toString());
        album->setImagePath(this->getImagePath(album->albumID()));
        QVariant v = QVariant::fromValue(album);
        return v;
    }
}

QList<QVariant> AlbumService::getSongs(int albumID)
{

    QSqlQuery query;
    QString queryString = "SELECT SongID, Name FROM SONGS WHERE AlbumID = ";
    queryString.append(QString::number(albumID));

    query.exec(queryString);
    auto list = new QList<QVariant>();
    while (query.next()) {
        QSqlRecord record = query.record();

        auto song = new Song();
        song->setName(record.value("Name").toString());

        QVariant v = QVariant::fromValue(song);
        list->insert(list->size(),v);
    }
    return *list;
}

QList<QVariant> AlbumService::getAlbums(int authorID)
{

    QSqlQuery query;
    QString queryString = "SELECT Albums.AlbumID, Albums.Name, Albums.AuthorID, Albums.Year, Albums.GenreID, Authors.FirstName, Authors.LastName,  Genres.Name as GenreName FROM Albums JOIN Authors  on Authors.AuthorID = Albums.AuthorID  JOIN Genres on Genres.GenreID = Albums.GenreID";
    queryString.append(" WHERE Albums.AuthorID = ");
    queryString.append(QString::number(authorID));
    query.exec(queryString);
    auto list = new QList<QVariant>();
    while (query.next()) {
        QSqlRecord record = query.record();

        auto album = new Album();
        album->setAlbumID(record.value("AlbumID").toInt());
        album->setName(record.value("Name").toString());
        album->setYear(record.value("Year").toInt());
        album->setGenreName(record.value("GenreName").toString());
        album->setAuthorName(record.value("FirstName").toString() + " " + record.value("LastName").toString());
        QVariant v = QVariant::fromValue(album);
        list->insert(list->size(),v);
    }
    return *list;
}

void AlbumService::addSong(QString name, int albumID)
{
    QSqlQuery query;
    query.prepare("INSERT INTO Songs(Name,AlbumID) VALUES (:name, :albumID)");
    query.bindValue(":name",name);
    query.bindValue(":albumID", albumID);
    query.exec();
    QString str = query.lastQuery();
    QMapIterator<QString, QVariant> it(query.boundValues());

    it.toBack();

    while (it.hasPrevious())
    {
        it.previous();
        str.replace(it.key(),it.value().toString());
    }
    qDebug() << str;
}

void AlbumService::addAlbum(QString name, int authorID,int year, QString genreName)
{
    QSqlQuery query;
    query.prepare("INSERT INTO Albums(Name,AuthorID,Year,GenreID) VALUES (:name,:authorID,:year,(SELECT Genres.GenreID FROM Genres WHERE Genres.Name = :genreName LIMIT 1))");
    query.bindValue(":name",name);
    query.bindValue(":authorID", authorID);
    query.bindValue(":year",year);
    query.bindValue(":genreName",genreName);

    qDebug() << query.exec();
    qDebug() << genreName;

    qDebug() << query.lastError();
    qDebug() << query.lastQuery();

    QString str = query.lastQuery();
    QMapIterator<QString, QVariant> it(query.boundValues());

    it.toBack();

    while (it.hasPrevious())
    {
        it.previous();
        str.replace(it.key(),it.value().toString());
    }
    qDebug() << str;
}

bool AlbumService::imageExists(int albumID)
{
    auto path = this->applicationPath().append("/").append(QString::number(albumID)).append(".jpg");
    QFile file(path);
    auto exists = file.exists();
    return exists;
}

QString AlbumService::getImagePath(int albumID)
{
    if(this->imageExists(albumID)){
        return this->imagePath().append("/").append(QString::number(albumID)).append(".jpg");
    }
    return this->imagePath().append("/").append("empty").append(".jpg");

}

void AlbumService::setNewImage(int albumID, QString path)
{

    auto newPath = this->applicationPath().append("/").append(QString::number(albumID)).append(".jpg");
    if (QFile::exists(newPath))
    {
        QFile::remove(newPath);
    }

    QFile::copy(path.replace(0,7,""),newPath );
}
