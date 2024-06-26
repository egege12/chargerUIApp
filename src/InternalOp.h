
#ifndef INTERNALOP_H
#define INTERNALOP_H
#include "qdebug.h"
#include <QString>
#include <QMap>
#include <QFile>
#include <QList>
#include <QTextStream>
#include <QObject>

class InternalOp : public QObject{

    Q_OBJECT
    Q_PROPERTY(unsigned long activeScreen READ activeScreen WRITE setActiveScreen NOTIFY activeScreenChanged)
    Q_PROPERTY(bool loadingProgress READ loadingProgress WRITE setLoadingProgress NOTIFY loadingProgressChanged)
public:
    InternalOp();

    unsigned long activeScreen() const;
    void setActiveScreen(unsigned long newActiveScreen);
    bool loadingProgress() const;
    void setLoadingProgress(bool newLoadingProgress);
    bool queryID(QString data);
public slots:
    void checkforID(QString data);
signals:
    void activeScreenChanged();
    void loadingProgressChanged();

    void idResult(QString result);

private:
    unsigned long m_activeScreen;
    bool m_loadingProgress;
};

inline bool InternalOp::loadingProgress() const
{
    return m_loadingProgress;
}

inline void InternalOp::setLoadingProgress(bool newLoadingProgress)
{
    if (m_loadingProgress == newLoadingProgress)
        return;
    m_loadingProgress = newLoadingProgress;
    qInfo()<<"loading changed";
    emit loadingProgressChanged();

}

inline bool InternalOp::queryID(QString data)
{
    return true;
}

inline void InternalOp::checkforID(QString data)
{
    if(data ==""){
        emit this->idResult("000");
    }else if (queryID(data))
        emit this->idResult("200");
    else
        emit this->idResult("300");
}

inline unsigned long InternalOp::activeScreen() const
{
    return m_activeScreen;
}

inline void InternalOp::setActiveScreen(unsigned long newActiveScreen)
{
    if (m_activeScreen == newActiveScreen)
        return;
    m_activeScreen = newActiveScreen;
    setLoadingProgress(true);
    emit activeScreenChanged();

}
inline InternalOp::InternalOp(){
    m_activeScreen =1010;
    m_loadingProgress=false;
}
#endif // INTERNALOP_H




