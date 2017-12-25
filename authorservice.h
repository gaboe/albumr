#ifndef AUTHORSERVICE_H
#define AUTHORSERVICE_H
#include <QQmlListProperty>
#include <author.h>
#include <QObject>

class AuthorService : public QObject
{
    Q_OBJECT
    QVariant m_authorDetail;

public:
    explicit AuthorService(QObject *parent = nullptr);
    Q_INVOKABLE QList<QVariant> getAuthors();
    Q_PROPERTY(QVariant authorDetail READ authorDetail WRITE setAuthorDetail NOTIFY authorDetailChanged)

QVariant authorDetail() const
{
    return m_authorDetail;
}
public slots:
void setAuthorDetail(QVariant authorDetail)
{
    if (m_authorDetail == authorDetail)
        return;

    m_authorDetail = authorDetail;
    emit authorDetailChanged(m_authorDetail);
}
signals:
void authorDetailChanged(QVariant authorDetail);
};

#endif // AUTHORSERVICE_H
