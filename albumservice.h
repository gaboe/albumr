#ifndef ALBUMSERVICE_H
#define ALBUMSERVICE_H

#include <QObject>
#include <QVariant>
#include <QDebug>
#include <QSqlQuery>
#include "album.h"
class AlbumService : public QObject
{
    Q_OBJECT
    QVariant m_albumDetail;

    QList<QVariant> m_songs;

    QList<QVariant> m_authorAlbums;

    QString m_imagePath;

    QString m_applicationPath;

    QList<QVariant> m_albums;

public:
    explicit AlbumService(QObject *parent = nullptr);
    Q_INVOKABLE QList<QVariant> getAlbums();
    Q_INVOKABLE QVariant getAlbum(int albumID);
    Q_INVOKABLE QList<QVariant> getSongs(int albumID);
    Q_INVOKABLE QList<QVariant> getAlbums(int authorID);
    QList<QVariant> getAlbums(QString authorName,QString genre,int year = -1);
    Q_INVOKABLE void addSong(QString name,int albumID);
    Q_INVOKABLE void addAlbum(QString name, int authorID,int year, QString genreName);
    Q_PROPERTY(QVariant albumDetail READ albumDetail WRITE setAlbumDetail NOTIFY albumDetailChanged)
    Q_PROPERTY(QList<QVariant> songs READ songs WRITE setSongs NOTIFY songsChanged)
    Q_PROPERTY(QList<QVariant> authorAlbums READ authorAlbums WRITE setAuthorAlbums NOTIFY authorAlbumsChanged)
    Q_PROPERTY(QList<QVariant> albums READ albums WRITE setAlbums NOTIFY albumsChanged)
    Q_INVOKABLE bool imageExists(int albumID);
    Q_INVOKABLE QString getImagePath(int albumID);
    Q_INVOKABLE void setNewImage(int albumID,QString path);
    Q_PROPERTY(QString imagePath READ imagePath WRITE setImagePath NOTIFY imagePathChanged)
    Q_PROPERTY(QString applicationPath READ applicationPath WRITE setApplicationPath NOTIFY applicationPathChanged)

    QVariant albumDetail() const
{
    return m_albumDetail;
}

QList<QVariant> songs() const
{
    return m_songs;
}

QList<QVariant> authorAlbums() const
{
    return m_authorAlbums;
}

QString imagePath() const
{
    return m_imagePath;
}

QString applicationPath() const
{
    return m_applicationPath;
}

QList<QVariant> albums() const
{
    return m_albums;
}

signals:

void albumDetailChanged(QVariant albumDetail);

void songsChanged(QList<QVariant> songs);

void authorAlbumsChanged(QList<QVariant> authorAlbums);

void imagePathChanged(QString imagePath);

void applicationPathChanged(QString applicationPath);

void albumsChanged(QList<QVariant> albums);

public slots:

void filterAlbums(QString authorName,QString genre,int year){
    auto albums = getAlbums(authorName,genre,year);
    setAlbums(albums);
}

void refreshAlbums(){
    auto albums = getAlbums();
    setAlbums(albums);
}

void setNewAlbumDetail(int albumID){
    auto album = getAlbum(albumID);
    setAlbumDetail(album);
}

void setNewAuthorAlbums(int authorID){
    auto albums = getAlbums(authorID);
    setAuthorAlbums(albums);
}

void setNewSongs(int albumID){
    auto songs = getSongs(albumID);
    setSongs(songs);
}

void setAlbumDetail(QVariant albumDetail)
{
    if (m_albumDetail == albumDetail)
        return;

    m_albumDetail = albumDetail;
    emit albumDetailChanged(m_albumDetail);
}
void setSongs(QList<QVariant> songs)
{
    if (m_songs == songs)
        return;

    m_songs = songs;
    emit songsChanged(m_songs);
}
void setAuthorAlbums(QList<QVariant> authorAlbums)
{
    if (m_authorAlbums == authorAlbums)
        return;

    m_authorAlbums = authorAlbums;
    emit authorAlbumsChanged(m_authorAlbums);
}
void setImagePath(QString imagePath)
{
    if (m_imagePath == imagePath)
        return;

    m_imagePath = imagePath;
    emit imagePathChanged(m_imagePath);
}
void setApplicationPath(QString applicationPath)
{
    if (m_applicationPath == applicationPath)
        return;

    m_applicationPath = applicationPath;
    emit applicationPathChanged(m_applicationPath);
}
void setAlbums(QList<QVariant> albums)
{
    if (m_albums == albums)
        return;

    m_albums = albums;
    emit albumsChanged(m_albums);
}
};

#endif // ALBUMSERVICE_H
