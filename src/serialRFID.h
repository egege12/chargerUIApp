#ifndef SERIALRFID_H
#define SERIALRFID_H

#include <QtSerialPort>
#include <QSerialPortInfo>
#include <QTimer>
#include "qobject.h"



#define PortName "ttyUSB2"
#define ReinitCycle 1000


class serialRFID :public QObject{
    Q_OBJECT
    Q_PROPERTY(bool serialInit READ serialInit WRITE setserialInit NOTIFY serialInitChanged FINAL)
public:
    explicit serialRFID();
    ~serialRFID();
    bool serialInit() const;
    void setserialInit(bool newSerialInit);

signals:
    void cardRead(QString ID);
    void serialInitChanged();


public slots:
    void initPort();
    void deinitPort();
    void readData();
    void readErrorOnSerialPort(QSerialPort::SerialPortError error);
private:
    QSerialPort serialPort;
    QTimer timerReinit;



    bool m_serialInit;
};

inline bool serialRFID::serialInit() const
{
    return m_serialInit;
}

inline void serialRFID::setserialInit(bool newSerialInit)
{
    if (m_serialInit == newSerialInit)
        return;
    m_serialInit = newSerialInit;
    emit serialInitChanged();
}

inline serialRFID::serialRFID()
{
    qDebug() << "Serial port reader constructed";
    connect(&serialPort, &QSerialPort::errorOccurred, this, &serialRFID::readErrorOnSerialPort);
}

inline serialRFID::~serialRFID()
{
    qDebug() << "Serial port reader deconstructed";
}

inline void serialRFID::initPort()
{

    serialPort.setPortName(PortName);
    serialPort.setBaudRate(QSerialPort::Baud9600);
    serialPort.setDataBits(QSerialPort::Data8);
    serialPort.setParity(QSerialPort::NoParity);
    serialPort.setStopBits(QSerialPort::OneStop);
    serialPort.setFlowControl(QSerialPort::NoFlowControl);

    if (serialPort.open( QIODeviceBase::ReadOnly)) {
        qDebug() << "Serial port open on "<< PortName;
        connect(&serialPort, &QSerialPort::readyRead, this, &serialRFID::readData);
        setserialInit(true);
        if(timerReinit.isActive()){
            qDebug() << "Timer was active but terminating ";
            timerReinit.stop();
            disconnect(&timerReinit,&QTimer::timeout,this, &serialRFID::initPort);
        }
    } else {
        qDebug() << "Serial port can not be open on "<< PortName;
        timerReinit.setInterval(ReinitCycle);
        connect(&timerReinit,&QTimer::timeout,this, &serialRFID::initPort);
        timerReinit.start();
    }
}

inline void serialRFID::deinitPort()
{
    serialPort.close();
    qDebug()<<"Serial port closed";
}

inline void serialRFID::readData()
{
    const QByteArray data = serialPort.readAll();
    qDebug() << "Serial port RFID data:" << data;
    QString dataStr = QString(data);
    this->cardRead(data);

}

inline void serialRFID::readErrorOnSerialPort(QSerialPort::SerialPortError error)
{
    qDebug() << "Error flag rised on serialport!";
    switch (error) {
    case QSerialPort::NoError:
        qDebug() << "No error occurred.";
        break;
    case QSerialPort::DeviceNotFoundError:
        qDebug() << "An error occurred while attempting to open a non-existing device.";
        break;
    case QSerialPort::PermissionError:
        qDebug() << "An error occurred while attempting to open an already opened device by another process or a user not having enough permission to open.";
        break;
    case QSerialPort::OpenError:
        qDebug() << "An error occurred while attempting to open an already opened device in this object.";
        break;
    case QSerialPort::NotOpenError:
        qDebug() << "This error occurs when an operation is executed that can only be successfully performed if the device is open.";
        break;
    case QSerialPort::WriteError:
        qDebug() << "An I/O error occurred while writing the data.";
        break;
    case QSerialPort::ReadError:
        qDebug() << "An I/O error occurred while reading the data.";
        break;
    case QSerialPort::ResourceError:
        qDebug() << "An I/O error occurred when a resource becomes unavailable, e.g., when the device is unexpectedly removed from the system.";
        break;
    case QSerialPort::UnsupportedOperationError:
        qDebug() << "The requested device operation is not supported or prohibited by the running operating system.";
        break;
    case QSerialPort::TimeoutError:
        qDebug() << "A timeout error occurred.";
        break;
    case QSerialPort::UnknownError:
    default:
        qDebug() << "An unidentified error occurred.";
        break;
    }
    setserialInit(false);
}

#endif // SERIALRFID_H
