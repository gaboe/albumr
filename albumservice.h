#ifndef ALBUMSERVICE_H
#define ALBUMSERVICE_H

#include <QObject>
#include <QVariant>

class AlbumService : public QObject
{
    Q_OBJECT
public:
    explicit AlbumService(QObject *parent = nullptr);
    Q_INVOKABLE QList<QVariant> getAlbums();

signals:

public slots:
};

#endif // ALBUMSERVICE_H
