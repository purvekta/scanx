import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'dart:async';
import 'package:scanx/resultPage.dart';

import 'package:firebase_admob/firebase_admob.dart';

class CheckBarCode extends StatefulWidget {
  final String barcodeResult;
  CheckBarCode({this.barcodeResult});
  @override
  _CheckBarCodeState createState() => _CheckBarCodeState();
}

class _CheckBarCodeState extends State<CheckBarCode> {
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

  String _scanBarcode = 'Unknown';

  @override
  void initState() {
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
      print(barcodeScanRes);
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
          createInterstitialAd()..load()..show();
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ResultPage(barcodeResult: barcodeScanRes)),
      );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text('Check Product Country'),
      ),
      body: Builder(builder: (BuildContext context) {
        return Column(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                child: Column(
                    //  direction: Axis.vertical,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //  Text('Be Indian Boycoyt China'),
                      // Text('Want to KNow manufacuturing country of Product?'),
                      //Text('Scan the Barcode Here'),
                      RaisedButton(
                          
                          onPressed: () => scanBarcodeNormal(),
                          child: Text(
                            "Start barcode scan",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.pinkAccent,
                            ),
                          )),
                      // RaisedButton(
                      //   //onPressed: ()=> SecondPage(),
                      //   onPressed: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => CheckBarCode()),
                      //     );
                      //   },

                      //   child: Text('Capture Image'),
                      // ),
                      // // RaisedButton(
                      //     onPressed: () => scanQR(),
                      //     child: Text("Start QR scan")),
                      // RaisedButton(
                      //     onPressed: () => startBarcodeScanStream(),
                      //     child: Text("Start barcode scan stream")),

                      // Text('Scan result : $_scanBarcode\n',
                      //     style: TextStyle(fontSize: 20)),
                      //checkBarCode(_scanBarcode),
                      // // CheckStatus(String scan)
                    ])),
            // checkBarCode(_scanBarcode),
          ],
        );
      }),
    );
  }
  // checkBarCode(String barNo) {
  //   var va = barNo.split('');
  //   String adv = va[0] + va[1] + va[2];
  //   // return Text(adv);

  //   if ((adv == '690') ||
  //       (adv == '691') ||
  //       (adv == '692') ||
  //       (adv == '693') ||
  //       (adv == '694') ||
  //       (adv == '695') ||
  //       (adv == '696') ||
  //       (adv == '697') ||
  //       (adv == '698') ||
  //       (adv == '699')) {
  //     return Container(
  //         height: 300,
  //         width: 300,
  //         decoration: BoxDecoration(
  //           image: DecorationImage(
  //             image: AssetImage('assets/images/china.png'),
  //             fit: BoxFit.cover,
  //           ),
  //         ),
  //         //color: Colors.indigo,
  //         child: (Text('From China')));
  //   } else if ((adv == '890')) {
  //     return Container(
  //         height: 300,
  //         width: 300,
  //         decoration: BoxDecoration(
  //           image: DecorationImage(
  //             image: AssetImage('assets/images/india.png'),
  //             fit: BoxFit.cover,
  //           ),
  //         ),
  //         // color: Colors.indigo,
  //         child: (Text('with love India')));
  //   } else if ((adv == '955')) {
  //     return Container(
  //         height: 300,
  //         width: 300,
  //         decoration: BoxDecoration(
  //           image: DecorationImage(
  //             image: AssetImage('assets/images/malesiya.png'),
  //             fit: BoxFit.cover,
  //           ),
  //         ),
  //         //color: Colors.indigo,
  //         child: (Text('From Malesiya')));
  //   } else {
  //     return Container(
  //         height: 300,
  //         width: 300,
  //         decoration: BoxDecoration(
  //           image: DecorationImage(
  //             image: AssetImage('assets/images/malesiya.png'),
  //             fit: BoxFit.cover,
  //           ),
  //         ),
  //         //color: Colors.indigo,
  //         child: (Text('From Malesiya')));
  //   }
  // }
}
