#ifndef DBMANAGER_H
#define DBMANAGER_H

#include <QObject>
#include <QtSql>

class DbManager
{
public:
    DbManager();
    bool open();

private:
    void init();
    void seed();
    QString getInitScriptForAuthors();
    QString getInitScriptForGenres();
    QString getInitScriptForAlbums();
    QString getInitScriptForSongs();

};

#endif // DBMANAGER_H
