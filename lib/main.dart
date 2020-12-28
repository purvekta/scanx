import 'package:flutter/material.dart';
import 'package:scanx/checkbarcode.dart';
import 'package:firebase_admob/firebase_admob.dart';
void main() =>
    runApp(new MaterialApp(
      debugShowCheckedModeBanner: false,
       home: new MyApp()));

const String testDevice='';
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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

  @override
  Widget build(BuildContext context) {
    FirebaseAdMob.instance.initialize(appId:'ca-app-pub-7876420299477023~7988831429').then((response){
    _bannerAd = createBannerAd()
..load()
..show(
  //anchorType: AnchorType.top
);      
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //backgroundColor: Colors.indigo,
        appBar: AppBar(
          title: const Text('Check Product Country'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {
                  showAlertDialog(context);
                })
          ],
          backgroundColor: Colors.pinkAccent,
        ),
        body: Column(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                       Container(
                        width: 350,
                        //height: 300,
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: Colors.pinkAccent,
                          child: Column(
                            children:<Widget> [
                              Text(
                        'Made in',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                      SizedBox(height: 30),
                      Text(
                        'Click to Open Scanner',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                      SizedBox(height: 30),
                      Text(
                        'Scan the Barcode Here',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                      SizedBox(height: 30),
                      RaisedButton(
                        onPressed: () {
                          createInterstitialAd()..load()..show();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CheckBarCode()),
                          );
                        },

                        child: Text('Scan the Barcode Here'),
                      ),
                            ]
                          ),
                        ),
                      ),
                    ])),
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = FlatButton(
        child: Text('OK'),
        onPressed: () {
          Navigator.of(context).pop();
        });

    //create alert dialog
    AlertDialog alert = AlertDialog(
      title: Text("About us"),
      content: Text("Made in India"),
      actions: [
        okButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
