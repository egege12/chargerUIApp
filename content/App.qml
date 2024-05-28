import QtQuick 6.2
import QtQuick.Controls 6.2
import chargerUI

Window {
    id: root
    width: 1024
    height: 768
    minimumWidth: 1024
    minimumHeight: 768
    maximumHeight:1536
    maximumWidth:2048
    visible: true
    flags: Qt.FramelessWindowHint | Qt.Window | Qt.MaximizeUsingFullscreenGeometryHint  // to hide windows window and still show minimized icon
    title: qsTr("Charger UI")
    color:"#F2EFEF"
    //Signals
    onWidthChanged: {
        contentfield.width=root.width - sideBar.width
    }
    onHeightChanged: {
        if(TopBar.visible){
            contentfield.height= root.height - TopBar.height
        }else{
            contentfield.height=root.height
        }
    }
    onFullscreenChanged: {
        image1.updateSize();
    }

    //Properties
    /*START MenuBar properties*/
    property bool fullscreen
    property bool iconSize
    property bool darkmode:false



    /*Application Properties*/
    property bool isDesktop:Qt.platform.os === "windows" || Qt.platform.os === "linux" || Qt.platform.os === "osx"   // Compile for desktop
    property bool startupFinished : false;



    /*Animation Properties*/
    property int startFrame:0 // 0000 ve 0032 arasındaki toplam frame sayısı
    property int endFrame:31
    property int currentFrame: 0 // Mevcut frame
    property string currentAnimation:"";
    property string currentSource:"";
    property int stateCode : 5 //IDLE



    /*DEMO*/
    property bool plugged1: false
    property bool plugged2: false
    property bool pluggedboth: false
    onPlugged1Changed: {
        if(plugged1 && plugged2)
            pluggedboth=true
        else
            pluggedboth=false
        root.stateMachine();
    }
    onPlugged2Changed: {
        if(plugged1 && plugged2)
            pluggedboth=true
        else
            pluggedboth=false
        root.stateMachine();
    }


    /*****/




    /* States of stateCode

    5  : startup start
    6  : startup finished
    10 : charging idle
    112 : 1 Charging Plugged in
    122 : 2 Charging Plugged in
    212 : 1 Charging Plugged in when 2 plugged in
    222 : 2 Charging Plugged in when 1 plugged in
    333 : Both plugged
    20 : details/maintenance
    30 : events
    40 : interface:
    50 : settings
    60 : parameters
    70 : account

    */

    function stateMachine() {
        if(!timerFrame.running)
        switch(root.stateCode) {
            case 5:
                console.log("State: Startup");
                root.selectTargetState("Startup");
                root.startAnimation();
                root.stateCode = 6;
                break;
            case 6:
                if(root.isDesktop === false){
                    root.showFullScreen()
                    sideBar.noSideBar()
                }else{
                    sideBar.closeSideBar()
                }
                root.setIdleImage(root.stateCode);
                root.stateCode = 10;
                openChargingPage(); // Bunlar daha sonra log file'a yazılacak **unutma
            break;
            case 10:
                if(sideBar.indexPage === 2){
                    if(root.currentAnimation !== "ChargeToMaintenance"){
                        root.setSceneNull();
                        root.selectTargetState("ChargeToMaintenance");
                        root.startAnimation();
                    }else{
                        root.changePage();
                        root.setIdleImage(root.stateCode);
                        root.stateCode = 20;
                    }
                }else if(sideBar.indexPage === 3){
                    if(root.currentAnimation !== "ChargeToEvent"){
                        root.setSceneNull();
                        root.selectTargetState("ChargeToEvent");
                        root.startAnimation();
                    }else{
                        root.changePage();
                        root.setIdleImage(root.stateCode);
                        root.stateCode = 30;
                    }
                }else if(sideBar.indexPage === 4){
                    if(root.currentAnimation !== "ChargeToMaintenance"){
                        root.setSceneNull();
                        root.selectTargetState("ChargeToMaintenance");
                        root.startAnimation();
                    }else{
                        root.changePage();
                        root.setIdleImage(root.stateCode);
                        root.stateCode = 40;
                    }
                }else if (pluggedboth){
                    if(root.currentAnimation !== "PlugBoth"){
                        root.setSceneNull();
                        root.selectTargetState("PlugBoth");
                        root.startAnimation();
                    }else{
                        root.changePage();
                        root.setIdleImage(root.stateCode);
                        root.stateCode = 333;
                    }
                }else if (plugged1){
                    if(root.currentAnimation !== "Plug1"){
                        root.setSceneNull();
                        root.selectTargetState("Plug1");
                        root.startAnimation();
                    }else{
                        root.changePage();
                        root.setIdleImage(root.stateCode);
                        root.stateCode = 112;
                    }
                }else if (plugged2){
                    if(root.currentAnimation !== "Plug2"){
                        root.setSceneNull();
                        root.selectTargetState("Plug2");
                        root.startAnimation();
                    }else{
                        root.changePage();
                        root.setIdleImage(root.stateCode);
                        root.stateCode = 122;
                    }
                }
                console.log("State: Charging Idle");
                break;
            case 112:
                console.log("State: 1 Charging Plugged in");
                if (!root.plugged1 || sideBar.indexPage !== 1){
                    if(root.currentAnimation !== "UnPlug1"){
                        root.setSceneNull();
                        root.selectTargetState("UnPlug1");
                        root.startAnimation();
                    }else{
                        if(sideBar.indexPage === 1){
                            root.changePage();
                        }
                        root.stateCode = 10;
                        root.stateMachine();
                    }
                }else if(root.plugged2){
                    if(root.currentAnimation !== "Plug2over1"){
                        root.setSceneNull();
                        root.selectTargetState("Plug2over1");
                        root.startAnimation();
                    }else{
                        root.changePage();
                        root.setIdleImage(root.stateCode);
                        root.stateCode = 333;
                    }
                }
                break;
            case 122:
                if (!root.plugged2 || sideBar.indexPage !== 1){
                    if(root.currentAnimation !== "UnPlug2"){
                        root.setSceneNull();
                        root.selectTargetState("UnPlug2");
                        root.startAnimation();
                    }else{
                        if(sideBar.indexPage === 1){
                            root.changePage();
                        }
                        root.stateCode = 10;
                        root.stateMachine();
                    }
                }else if(root.plugged1){
                    if(root.currentAnimation !== "Plug1over2"){
                        root.setSceneNull();
                        root.selectTargetState("Plug1over2");
                        root.startAnimation();
                    }else{
                        root.changePage();
                        root.setIdleImage(root.stateCode);
                        root.stateCode = 333;
                    }
                }
                console.log("State: 2 Charging Plugged in");
                break;
            case 333:
                if(sideBar.indexPage !== 1){
                    if(root.currentAnimation !== "UnPlugBoth"){
                        root.setSceneNull();
                        root.selectTargetState("UnPlugBoth");
                        root.startAnimation();
                    }else{
                        root.stateCode = 10;
                        root.stateMachine();
                    }
                }else if (!root.plugged1){
                    if(root.currentAnimation !== "UnPlug1over2"){
                        root.setSceneNull();
                        root.selectTargetState("UnPlug1over2");
                        root.startAnimation();
                    }else{
                        root.changePage();
                        root.setIdleImage(root.stateCode);
                        root.stateCode = 122;
                    }
                }else if(!root.plugged2){
                    if(root.currentAnimation !== "UnPlug2over1"){
                        root.setSceneNull();
                        root.selectTargetState("UnPlug2over1");
                        root.startAnimation();
                    }else{
                        root.changePage();
                        root.setIdleImage(root.stateCode);
                        root.stateCode = 112;
                    }
                }
                console.log("State: Both plugged");
                break;
            case 20: /*Details/Maintenance*/
                if(sideBar.indexPage !== 2){
                    if(root.currentAnimation !== "MaintenanceToCharge"){
                        root.setSceneNull();
                        root.selectTargetState("MaintenanceToCharge");
                        root.startAnimation();
                    }else{
                        if(sideBar.indexPage === 1){
                            root.changePage();
                        }
                        root.stateCode = 10;
                        root.setIdleImage(root.stateCode);
                        root.stateMachine();
                    }
                }
                console.log("State: Details/Maintenance");
                break;
            case 30:
                if(sideBar.indexPage !== 3){
                    if(root.currentAnimation !== "EventToCharge"){
                        root.setSceneNull();
                        root.selectTargetState("EventToCharge");
                        root.startAnimation();
                    }else{
                        if(sideBar.indexPage === 1){
                            root.changePage();
                        }
                        root.stateCode = 10;
                        root.setIdleImage(root.stateCode);
                        root.stateMachine();
                    }
                }
                console.log("State: Events");
                break;
            case 40:
                if(sideBar.indexPage !== 4){
                    if(root.currentAnimation !== "MaintenanceToCharge"){
                        root.setSceneNull();
                        root.selectTargetState("MaintenanceToCharge");
                        root.startAnimation();
                    }else{
                        if(sideBar.indexPage === 1){
                            root.changePage();
                        }
                        root.stateCode = 10;
                        root.setIdleImage(root.stateCode);
                        root.stateMachine();
                    }
                }
                console.log("State: Interface");
                break;
            case 50:
                console.log("State: Settings");
                break;
            case 60:
                console.log("State: Parameters");
                break;
            case 70:
                console.log("State: Account");
                break;
            default:
                console.log("Unknown state");
                break;
        }
    }

    //functions


    function selectTargetState(name){
        var state = findElementByName(name)
        root.currentAnimation= state.name
        root.startFrame = state.startFrame
        root.endFrame = state.endFrame
        root.currentSource = state.source
    }
    function findElementByName(name) {
            for (var i = 0; i < backgroundStateList.count; ++i) {
                if (backgroundStateList.get(i).name === name) {
                    return backgroundStateList.get(i);
                }
            }
            return null;
        }
    /*Start animation*/
    function startAnimation() {
        root.currentFrame = root.startFrame
        timerFrame.start()
    }
    function setIdleImage(state){
        if(image1.source!=="images/idles/S"+state)
            image1.source="images/idles/S"+state
        console.log("Idle image set to "+  image1.source);
    }

    /*Select Page*/
    function setSceneNull(){
        contentLoader.source="";
    }
    /*Go to page content*/
    function openChargingPage(){
        contentLoader.source = "Screen01.ui.qml"
        if(sideBar.indexPage !== 1){
            sideBar.indexPage=1;
        }
    }
    function openEventPage(){
        contentLoader.source="Screen02.ui.qml"
        if(sideBar.indexPage !== 2){
            sideBar.indexPage=2;
        }
    }
    function openMaintenancePage(){
        contentLoader.source="Screen03.ui.qml"
        if(sideBar.indexPage !== 3){
            sideBar.indexPage=3;
        }
    }
    function openInterfacePage(){
        contentLoader.source="Screen04.ui.qml"
        if(sideBar.indexPage !== 4){
            sideBar.indexPage=4;
        }
    }
    function openParametersPage(){
        contentLoader.source=""
        if(sideBar.indexPage !== 5){
            sideBar.indexPage=5;
        }
    }
    function openSettingsPage(){
        contentLoader.source=""
        if(sideBar.indexPage !== 6){
            sideBar.indexPage=6;
        }
    }
    function openAccountsPage(){
        contentLoader.source=""
        if(sideBar.indexPage !== 7){
            sideBar.indexPage=7;
        }
    }
    //To collect all the page commands
    function changePage(){
        switch(sideBar.indexPage){
        case 1:
            openChargingPage()
        break;
        case 2:
            openEventPage()
        break;
        case 3:
            openMaintenancePage()
        break;
        case 4:
            openInterfacePage()
        break;
        case 5:
            openParametersPage()
        break;
        case 6:
            openSettingsPage()
        break;
        case 7:
            openAccountsPage()
        break;
        default:
            openChargingPage()
        }
    }



    ListModel{
        id:backgroundStateList

        ListElement{
            name: "Startup"
            source: "images/startup/"
            startFrame:0
            endFrame:31
        }
        ListElement{
            name: "ChargeToEvent"
            source: "images/events/"
            startFrame:1
            endFrame:20
        }
        ListElement{
            name: "EventToCharge"
            source: "images/events/"
            startFrame:20
            endFrame:1
        }
        ListElement{
            name: "ChargeToMaintenance"
            source: "images/maintenance/"
            startFrame:1
            endFrame:40
        }
        ListElement{
            name: "MaintenanceToCharge"
            source: "images/maintenance/"
            startFrame:40
            endFrame:1
        }
        ListElement{
            name: "Plug1"
            source: "images/plug_in/single_1/"
            startFrame:2
            endFrame:100
        }
        ListElement{
            name: "UnPlug1"
            source: "images/plug_in/single_1/"
            startFrame:100
            endFrame:202
        }
        ListElement{
            name: "Plug2"
            source: "images/plug_in/single_2/"
            startFrame:2
            endFrame:100
        }
        ListElement{
            name: "UnPlug2"
            source: "images/plug_in/single_2/"
            startFrame:100
            endFrame:202
        }
        ListElement{
            name: "Plug1over2"
            source: "images/plug_in/1to2/"
            startFrame:2
            endFrame:100
        }
        ListElement{
            name: "UnPlug1over2"
            source: "images/plug_in/1to2/"
            startFrame:100
            endFrame:202
        }
        ListElement{
            name: "Plug2over1"
            source: "images/plug_in/2to1/"
            startFrame:2
            endFrame:100
        }
        ListElement{
            name: "UnPlug2over1"
            source: "images/plug_in/2to1/"
            startFrame:100
            endFrame:202
        }
        ListElement{
            name: "PlugBoth"
            source: "images/plug_in/both/"
            startFrame:2
            endFrame:100
        }
        ListElement{
            name: "UnPlugBoth"
            source: "images/plug_in/both/"
            startFrame:100
            endFrame:202
        }
    }

    /*END MenuBar properties */

    /*START SideBar properties*/

    /*END SideBar properties*/

    /*Make fullscreen when component loaded on charger screen*/

    /*Activate frameless, use qt window features*/


    Rectangle{
        anchors.fill:parent
        z:2
        color:"transparent"



        TopBar{
            id:windowButtonBar
            anchors.top: parent.top
            anchors.topMargin:0
            anchors.right:parent.right
            anchors.rightMargin:0
            height: 25
            width: parent.width
            onFullScreenClicked:{
                if(fullscreen === true){
                    root.showNormal()
                }else{
                    root.showFullScreen()
                }
                fullscreen= !fullscreen}
            onIconSizeClicked: {
                if(iconSize === true){
                    root.showNormal()
                }else{
                    root.showMinimized()
                }
                iconSize= !iconSize}
            onEscapeClicked: Qt.quit()
            visible: root.isDesktop
            z:5
        }
        SideBar{
            id:sideBar
            anchors.top:parent.top
            anchors.bottom:parent.bottom
            z:4
            isDesktop:root.isDesktop
            onIndexPageChanged: {
                root.stateMachine();
                console.log("INDEX***>>>>"+sideBar.indexPage);
            }
            onWidthChanged: {
                contentfield.width=parent.width - sideBar.width
            }

        }


        Rectangle{
            id:contentfield
            height: root.height
            width: root.width
            anchors.top:root.isDesktop ? windowButtonBar.bottom : parent.top
            anchors.left:sideBar.right
            anchors.bottom:root.bottom
            anchors.right:root.right
            state:'Charge'


            Loader{
                id:contentLoader
                focus:true
                anchors.fill: parent
                z: 2
                source: ""
                // Fade-out eski içerik, fade-in yeni içerik
                onLoaded: {
                    // Yeni içerik yüklendiğinde başlatılacak fade-in animasyonu
                    fadeInAnimation.start();
                    if(sideBar.indexPage == 1){
                        contentLoader.item.plugged1 = root.plugged1
                        contentLoader.item.plugged2 = root.plugged2
                    }
                }


                // Fade-in animasyonu
                NumberAnimation {
                    id: fadeInAnimation
                    target: contentLoader.item
                    property: "opacity"
                    from: 0
                    to: 1
                    duration: 500
                }

            }
            Rectangle{
                id:animebackground
                anchors.fill: parent
                clip:true
                z: 0



            Image {
                id: image1
                property real aspectRatio: image1.sourceSize.width / image1.sourceSize.height
                function updateSize(){
                    var newWidth = parent.width
                    var newHeight = parent.width / image1.aspectRatio

                    if (newHeight < parent.height) {
                        newHeight = parent.height
                        newWidth = parent.height * image1.aspectRatio
                    }

                    image1.width = newWidth
                    image1.height = newHeight
                }

                width: parent.width
                height: parent.width / aspectRatio
                anchors.centerIn: parent
                source: "images/startup/0.webp"
                onWidthChanged: image1.updateSize()
                onHeightChanged: image1.updateSize()
                fillMode: Image.PreserveAspectCrop


            }

            }
            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom:parent.bottom
                anchors.bottomMargin:10
                spacing :  5
                height:110
                visible:(sideBar.indexPage==1)
                Button{
                    width:100
                    height:100
                    text: root.plugged1 ? qsTr("Unplug \n EVSE 1") :qsTr("Plug \n EVSE 1")
                    onPressed: {
                        if(!timerFrame.running)
                        root.plugged1= !root.plugged1
                    }

                }
                Button{
                    width:100
                    height:100
                    text: root.plugged2 ? qsTr("Unplug \n EVSE 2") :qsTr("Plug \n EVSE 2")
                    onPressed: {
                        if(!timerFrame.running)
                        root.plugged2= !root.plugged2
                    }
                }
            }


        }


    }
    DragHandler {
        onActiveChanged: if(active) startSystemMove();
    }
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton
        z:1
        property int edges: 2;
        property int edgeOffest: 5;

        function setEdges(x, y) {
            edges = 0;
            if(x < edgeOffest) edges |= Qt.LeftEdge;
            if(x > (width - edgeOffest))  edges |= Qt.RightEdge;
            if(y < edgeOffest) edges |= Qt.TopEdge;
            if(y > (height - edgeOffest)) edges |= Qt.BottomEdge;
        }

        cursorShape: {
            return !containsMouse ? Qt.ArrowCursor:
                                    edges == 3 || edges == 12 ? Qt.SizeFDiagCursor :
                                                                edges == 5 || edges == 10 ? Qt.SizeBDiagCursor :
                                                                                            edges & 9 ? Qt.SizeVerCursor :
                                                                                                        edges & 6 ? Qt.SizeHorCursor : Qt.ArrowCursor;
        }

        onPositionChanged: setEdges(mouseX, mouseY);
        onPressed: {
            setEdges(mouseX, mouseY);
            if(edges && containsMouse) {
                startSystemResize(edges);
            }
        }
        visible:isDesktop
    }

//TIMERS
    //frame timer
    Timer {
        id: timerFrame
        interval: 30
        running: true
        repeat:true
        onTriggered: {
            if(root.endFrame > root.startFrame){
                if (root.currentFrame < root.endFrame) {
                    root.currentFrame += 1
                } else {
                    timerFrame.stop()
                    root.stateMachine();
                }
            }else{
                if (root.currentFrame > root.endFrame) {
                    root.currentFrame -= 1
                } else {
                    timerFrame.stop()
                    root.stateMachine();
                }
            }

            image1.source = root.currentSource+root.currentFrame+".webp"
            //console.log("Current Frame: " + animebackground.currentFrame + " Source: " + image1.source) // debug
        }
    }

//CONNECTIONS
    //RFID Menu trigger connection
    Connections{
        target:internalOp
        onIdResult:{
            sideBar.openSideBar();
        }
    }
    Component.onCompleted: {
        root.stateMachine()
    }

}
