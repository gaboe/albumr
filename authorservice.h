#ifndef AUTHORSERVICE_H
#define AUTHORSERVICE_H
#include <QList>
#include <author.h>

class AuthorService
{
public:
    AuthorService();
    QList<Author*> getAuthors();
};

#endif // AUTHORSERVICE_H
