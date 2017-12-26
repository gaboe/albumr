#ifndef GENRE_H
#define GENRE_H

#include <QObject>

class Genre : public QObject
{
    Q_OBJECT
    QString m_name;

    int m_genreID;

public:
    explicit Genre(QObject *parent = nullptr);
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(int genreID READ genreID WRITE setGenreID NOTIFY genreIDChanged)

QString name() const
{
    return m_name;
}

int genreID() const
{
    return m_genreID;
}

signals:

void nameChanged(QString name);

void genreIDChanged(int genreID);

public slots:
void setName(QString name)
{
    if (m_name == name)
        return;

    m_name = name;
    emit nameChanged(m_name);
}
void setGenreID(int genreID)
{
    if (m_genreID == genreID)
        return;

    m_genreID = genreID;
    emit genreIDChanged(m_genreID);
}
};

#endif // GENRE_H
