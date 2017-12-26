#ifndef AUTHOR_H
#define AUTHOR_H

#include <QObject>

class Author : public QObject
{
    Q_OBJECT

    int m_authorID;

    QString m_name;

public:
    Author(QObject *parent = nullptr);
    Author(const Author &obj);
    ~Author();

    Q_PROPERTY(int authorID READ authorID WRITE setAuthorID NOTIFY authorIDChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)

    int authorID() const
    {
        return m_authorID;
    }

    QString name() const
    {
        return m_name;
    }

signals:

void authorIDChanged(int authorID);

void nameChanged(QString name);

public slots:
void setAuthorID(int authorID)
{
    if (m_authorID == authorID)
        return;

    m_authorID = authorID;
    emit authorIDChanged(m_authorID);
}
void setName(QString name)
{
    if (m_name == name)
        return;

    m_name = name;
    emit nameChanged(m_name);
}
};
Q_DECLARE_METATYPE(Author)

#endif // AUTHOR_H
