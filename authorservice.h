#ifndef AUTHORSERVICE_H
#define AUTHORSERVICE_H
#include <QQmlListProperty>
#include <author.h>
#include <QObject>
#include <QDebug>
class AuthorService : public QObject
{
    Q_OBJECT
    QVariant m_authorDetail;

    QList<QVariant> m_authors;

public:
    explicit AuthorService(QObject *parent = nullptr);
    Q_INVOKABLE QList<QVariant> getNewAuthors();
    Q_INVOKABLE QVariant getAuthor(int authorID);
    Q_INVOKABLE void addAuthor(QString firstName,QString lastName);
    Q_PROPERTY(QVariant authorDetail READ authorDetail WRITE setAuthorDetail NOTIFY authorDetailChanged)
    Q_PROPERTY(QList<QVariant> authors READ authors WRITE setAuthors NOTIFY authorsChanged)

QVariant authorDetail() const
{
    return m_authorDetail;
}
QList<QVariant> authors() const
{
    return m_authors;
}

public slots:

void setNewAuthors(){
    auto authors = getNewAuthors();
    setAuthors(authors);
}

void setNewAuthorDetail(int authorID)
{
   auto author = getAuthor(authorID);
   setAuthorDetail(author);
}
void setAuthorDetail(QVariant authorDetail)
{
    if (m_authorDetail == authorDetail)
        return;

    m_authorDetail = authorDetail;
    emit authorDetailChanged(m_authorDetail);
}
void setAuthors(QList<QVariant> authors)
{
    if (m_authors == authors)
        return;

    m_authors = authors;
    emit authorsChanged(m_authors);
}

signals:
void authorDetailChanged(QVariant authorDetail);
void authorsChanged(QList<QVariant> authors);
};

#endif // AUTHORSERVICE_H
