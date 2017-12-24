#ifndef AUTHOR_H
#define AUTHOR_H

#include <QObject>

class Author : public QObject
{
    Q_OBJECT
    QString m_firstName;

public:
    explicit Author(QObject *parent = nullptr);
    Q_PROPERTY(QString firstName READ firstName WRITE setFirstName NOTIFY firstNameChanged)

QString firstName() const
{
    return m_firstName;
}

signals:

void firstNameChanged(QString firstName);

public slots:
void setFirstName(QString firstName)
{
    if (m_firstName == firstName)
        return;

    m_firstName = firstName;
    emit firstNameChanged(m_firstName);
}
};

#endif // AUTHOR_H
