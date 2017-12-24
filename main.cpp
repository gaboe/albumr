#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QtSql>
#include <QStandardPaths>
#include "dbmanager.h"
#include "authorservice.h"


int main(int argc, char *argv[])
{
#if defined(Q_OS_WIN)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    auto dbManager = new DbManager();
    auto isDbOpened = dbManager->open();
    if(!isDbOpened)
        return 1;

    auto authorService = new AuthorService();
    auto a = authorService->getAuthors();

    foreach (auto author, a) {
        qDebug() << author->firstName();
    }
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    engine.rootContext()->setContextProperty("applicationPath", "file://"+qApp->applicationDirPath()+ "/../albumr/images");

    engine.rootContext()->setContextProperty("firstAuthor", a.first());

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
