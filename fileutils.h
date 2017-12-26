#ifndef FILEUTILS_H
#define FILEUTILS_H

#include <QObject>

class FileUtils : public QObject
{
    Q_OBJECT
    QString m_imagePath;

    QString m_applicationPath;

public:
    explicit FileUtils(QObject *parent = nullptr);
    Q_INVOKABLE bool imageExists(int albumID);
    Q_INVOKABLE QString getImagePath(int albumID);
    Q_INVOKABLE void setNewImage(int albumID,QString path);
    Q_PROPERTY(QString imagePath READ imagePath WRITE setImagePath NOTIFY imagePathChanged)
    Q_PROPERTY(QString applicationPath READ applicationPath WRITE setApplicationPath NOTIFY applicationPathChanged)

QString imagePath() const
{
    return m_imagePath;
}

QString applicationPath() const
{
    return m_applicationPath;
}

signals:

void imagePathChanged(QString imagePath);

void applicationPathChanged(QString applicationPath);

public slots:
void setImagePath(QString imagePath)
{
    if (m_imagePath == imagePath)
        return;

    m_imagePath = imagePath;
    emit imagePathChanged(m_imagePath);
}
void setApplicationPath(QString applicationPath)
{
    if (m_applicationPath == applicationPath)
        return;

    m_applicationPath = applicationPath;
    emit applicationPathChanged(m_applicationPath);
}
};

#endif // FILEUTILS_H
