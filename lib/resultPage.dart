import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
//import 'dart:async';
import 'package:firebase_admob/firebase_admob.dart';

class ResultPage extends StatefulWidget {
  String barcodeResult ;
  ResultPage({this.barcodeResult});  
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {

  static final MobileAdTargetingInfo targetingInfo = new MobileAdTargetingInfo(
    //testDevices: testDevice!= null?<String>[testDevice]:null,
    testDevices: <String>[],
    keywords: <String>['Barcode','china','india','barcode'],
    childDirected: true,

  );
 BannerAd _bannerAd;
 InterstitialAd _interstitialAd;

BannerAd createBannerAd(){
  return new BannerAd(
    adUnitId: 'ca-app-pub-7876420299477023/9503618298', 
    size: AdSize.banner,
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event){
      print('Banner event: $event');
    }
    );
}

InterstitialAd createInterstitialAd(){
  return new InterstitialAd(
    adUnitId: 'ca-app-pub-7876420299477023/3540845171', 
    //size: AdSize.banner,
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event){
      print('Banner event: $event');
    }
    );
}

@override
  void initState() {

    // TODO: implement initState

FirebaseAdMob.instance.initialize(appId: "ca-app-pub-7876420299477023~7988831429");
_bannerAd = createBannerAd()
..load()
..show(
  //anchorType: AnchorType.top
);

    super.initState();
  }

@override
  void dispose() {
    // TODO: implement dispose
    _bannerAd?.dispose();
    _interstitialAd.dispose();
    super.dispose();
  }

  /*
  String _scanBarcode = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            "#ff6666", "Cancel", true, ScanMode.BARCODE)
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);
      //print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
          // Navigator.push(
          //                       context,
          //                       MaterialPageRoute(
          //                           builder: (context) => ResultPage()),
          //                     );
      //print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  } 
  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text('Result'),
      ),
      body: Builder(
        builder: (BuildContext context){
           return Column(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                child: Column(
                      children: <Widget>[
//                     Text(widget.barcodeResult),
                      Text('Barcode Scan Result : ${widget.barcodeResult}\n',
                          style: TextStyle(fontSize: 20)),
                        //checkBarCode(_scanBarcode),
                       // Text('Product Made By:',style: TextStyle(fontSize: 20),),
                        checkBarCode(widget.barcodeResult),
                      // // CheckStatus(String scan)
                    ])),
        //    ProductSearch(),
          ],
        );
        },),
    );
  }
  checkBarCode(String barNo) {
    var va = barNo.split('');
    String adv = va[0] + va[1] + va[2];
    // return Text(adv);

    if ((adv == '690') ||
        (adv == '691') ||
        (adv == '692') ||
        (adv == '693') ||
        (adv == '694') ||
        (adv == '695') ||
        (adv == '696') ||
        (adv == '697') ||
        (adv == '698') ||
        (adv == '699')) {
      return Column(
        children: <Widget>[
          ListTile(title: Text("Product Made By:"),
         subtitle: Text("China",style: TextStyle(
           fontSize: 20,
           color: Colors.black54,
           ),),
         leading: Image.asset('assets/images/china.png'),
  ),
        ],
      );
    } else if ((adv == '890')) {
      return Column(
        children: <Widget>[
          ListTile(title: Text("Product Made By:"),
         subtitle: Text("India",style: TextStyle(
           fontSize: 20,
           color: Colors.black54,
           ),),
         leading: Image.asset('assets/images/india.png'),
 ),

        ],
      );
          
    } else if ((adv == '955')) {
      return Column(
        children: <Widget>[
          ListTile(title: Text("Product Made By:"),
         subtitle: Text("Malesiya",style: TextStyle(
           fontSize: 20,
           color: Colors.black54,
           ),),
         leading: Image.asset('assets/images/Malesiya.png'),
 ),

        ],
      );
    } else {
      return Column(
        children: <Widget>[
          ListTile(title: Text("Product Made By:"),
         subtitle: Text("Product Country Not Found",style: TextStyle(
           fontSize: 20,
           color: Colors.black54,
           ),),
         leading: Image.asset('assets/images/noproduct.jpg'),
 ),

        ],
      );
    }
  }
}