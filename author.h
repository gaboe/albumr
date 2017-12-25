#ifndef AUTHOR_H
#define AUTHOR_H

#include <QObject>

class Author : public QObject
{
    Q_OBJECT
    QString m_firstName;

    QString m_lastName;

    int m_authorID;

public:
    explicit Author(QObject *parent = nullptr);
    Q_PROPERTY(QString firstName READ firstName WRITE setFirstName NOTIFY firstNameChanged)
    Q_PROPERTY(QString lastName READ lastName WRITE setLastName NOTIFY lastNameChanged)
    Q_PROPERTY(int authorID READ authorID WRITE setAuthorID NOTIFY authorIDChanged)

    QString firstName() const
{
    return m_firstName;
}

    QString lastName() const
    {
        return m_lastName;
    }

    int authorID() const
    {
        return m_authorID;
    }

signals:

void firstNameChanged(QString firstName);

void lastNameChanged(QString lastName);

void authorIDChanged(int authorID);

public slots:
void setFirstName(QString firstName)
{
    if (m_firstName == firstName)
        return;

    m_firstName = firstName;
    emit firstNameChanged(m_firstName);
}
void setLastName(QString lastName)
{
    if (m_lastName == lastName)
        return;

    m_lastName = lastName;
    emit lastNameChanged(m_lastName);
}
void setAuthorID(int authorID)
{
    if (m_authorID == authorID)
        return;

    m_authorID = authorID;
    emit authorIDChanged(m_authorID);
}
};

#endif // AUTHOR_H
