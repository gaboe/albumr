#ifndef ALBUM_H
#define ALBUM_H

#include <QObject>

class Album : public QObject
{
    Q_OBJECT
    QString m_name;

    int m_albumID;

    int m_year;

    int m_authorID;

    int m_genreID;

    QString m_genreName;

QString m_authorName;

QString m_imagePath;

public:
    Album(QObject *parent = nullptr);
    Album(const Album &obj);
    ~Album();
    Q_PROPERTY(int albumID READ albumID WRITE setAlbumID NOTIFY albumIDChanged)
    Q_PROPERTY(int year READ year WRITE setYear NOTIFY yearChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(int authorID READ authorID WRITE setAuthorID NOTIFY authorIDChanged)
    Q_PROPERTY(int genreID READ genreID WRITE setGenreID NOTIFY genreIDChanged)
    Q_PROPERTY(QString genreName READ genreName WRITE setGenreName NOTIFY genreNameChanged)
    Q_PROPERTY(QString authorName READ authorName WRITE setAuthorName NOTIFY authorNameChanged)
    Q_PROPERTY(QString imagePath READ imagePath WRITE setImagePath NOTIFY imagePathChanged)
QString name() const
{
    return m_name;
}

int albumID() const
{
    return m_albumID;
}

int year() const
{
    return m_year;
}

int authorID() const
{
    return m_authorID;
}

int genreID() const
{
    return m_genreID;
}

QString genreName() const
{
    return m_genreName;
}

QString authorName() const
{
    return m_authorName;
}

QString imagePath() const
{
    return m_imagePath;
}

signals:

void nameChanged(QString name);

void albumIDChanged(int albumID);

void yearChanged(int year);

void authorIDChanged(int authorID);

void genreIDChanged(int genreID);

void genreNameChanged(QString genreName);

void authorNameChanged(QString authorName);

void imagePathChanged(QString imagePath);

public slots:
void setName(QString name)
{
    if (m_name == name)
        return;

    m_name = name;
    emit nameChanged(m_name);
}
void setAlbumID(int albumID)
{
    if (m_albumID == albumID)
        return;

    m_albumID = albumID;
    emit albumIDChanged(m_albumID);
}
void setYear(int year)
{
    if (m_year == year)
        return;

    m_year = year;
    emit yearChanged(m_year);
}
void setAuthorID(int authorID)
{
    if (m_authorID == authorID)
        return;

    m_authorID = authorID;
    emit authorIDChanged(m_authorID);
}
void setGenreID(int genreID)
{
    if (m_genreID == genreID)
        return;

    m_genreID = genreID;
    emit genreIDChanged(m_genreID);
}

void setGenreName(QString genreName)
{
    if (m_genreName == genreName)
        return;

    m_genreName = genreName;
    emit genreNameChanged(m_genreName);
}
void setAuthorName(QString authorName)
{
    if (m_authorName == authorName)
        return;

    m_authorName = authorName;
    emit authorNameChanged(m_authorName);
}
void setImagePath(QString imagePath)
{
    if (m_imagePath == imagePath)
        return;

    m_imagePath = imagePath;
    emit imagePathChanged(m_imagePath);
}
};
Q_DECLARE_METATYPE(Album)

#endif // ALBUM_H
