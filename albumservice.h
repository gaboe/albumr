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

public:
    explicit AlbumService(QObject *parent = nullptr);
    Q_INVOKABLE QList<QVariant> getAlbums();
    Q_INVOKABLE QVariant getAlbum(int albumID);
    Q_INVOKABLE QList<QVariant> getSongs(int albumID);
    Q_INVOKABLE QList<QVariant> getAlbums(int authorID);
    Q_INVOKABLE void addSong(QString name,int albumID);
    Q_INVOKABLE void addAlbum(QString name, int authorID,int year, QString genreName);
    Q_PROPERTY(QVariant albumDetail READ albumDetail WRITE setAlbumDetail NOTIFY albumDetailChanged)
    Q_PROPERTY(QList<QVariant> songs READ songs WRITE setSongs NOTIFY songsChanged)
    Q_PROPERTY(QList<QVariant> authorAlbums READ authorAlbums WRITE setAuthorAlbums NOTIFY authorAlbumsChanged)

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

signals:

void albumDetailChanged(QVariant albumDetail);

void songsChanged(QList<QVariant> songs);

void authorAlbumsChanged(QList<QVariant> authorAlbums);

public slots:
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
};

#endif // ALBUMSERVICE_H
