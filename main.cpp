#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QtSql>
#include <QStandardPaths>
#include "dbmanager.h"

int main(int argc, char *argv[])
{
#if defined(Q_OS_WIN)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    auto dbManager = new DbManager();
    dbManager->open();

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    engine.rootContext()->setContextProperty("applicationPath", "file://"+qApp->applicationDirPath()+ "/../albumr/images");

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
