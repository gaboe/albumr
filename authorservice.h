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

    QList<QString> m_genres;

public:
    explicit AuthorService(QObject *parent = nullptr);
    QList<QString> getGenres();
    Q_INVOKABLE QList<QVariant> getNewAuthors();
    Q_INVOKABLE QVariant getAuthor(int authorID);
    Q_INVOKABLE void addAuthor(QString name);
    Q_INVOKABLE void updateAuthorName(QString name, int authorID);
    Q_INVOKABLE void deleteAuthor(int authorID);
    Q_PROPERTY(QVariant authorDetail READ authorDetail WRITE setAuthorDetail NOTIFY authorDetailChanged)
    Q_PROPERTY(QList<QVariant> authors READ authors WRITE setAuthors NOTIFY authorsChanged)
    Q_PROPERTY(QList<QString> genres READ genres WRITE setGenres NOTIFY genresChanged)

QVariant authorDetail() const
{
    return m_authorDetail;
}
QList<QVariant> authors() const
{
    return m_authors;
}

QList<QString> genres() const
{
    return m_genres;
}

public slots:

void refreshGenres(){
    auto genres = getGenres();
    setGenres(genres);
}

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

void setGenres(QList<QString> genres)
{
    m_genres = genres;
}

signals:
void authorDetailChanged(QVariant authorDetail);
void authorsChanged(QList<QVariant> authors);
void genresChanged(QList<QString> genres);
};

#endif // AUTHORSERVICE_H
