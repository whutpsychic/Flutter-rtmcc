import 'package:flutter/material.dart';
import '../../core/Util/main.dart';
import 'package:scan/scan.dart';

class Scanning extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageState();
}

class _PageState extends State<Scanning> with RouteAware {
  @override
  void initState() {
    super.initState();
  }

  ScanController controller = ScanController();
  String qrcode = 'Unknown';

  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    print(' -=-=-=-=-=-=-=-= didPopNext -=-=-=-=-=-=-=-=-= ');
    controller.resume();
  }

  @override
  void didPushNext() {
    print(' -=-=-=-=-=-=-=-= didPushNext -=-=-=-=-=-=-=-=-= ');
  }

  @override
  Widget build(BuildContext context) {
    double _sw = MediaQuery.of(context).size.width;
    double _sh = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Container(
          width: _sw, // custom wrap size
          height: _sh,
          child: ScanView(
            controller: controller,
            // custom scan area, if set to 1.0, will scan full area
            scanAreaScale: .7,
            scanLineColor: Colors.green.shade400,
            onCapture: (data) {
              // do something
              _onGetResult(data);
            },
          ),
        ),
        Positioned(
            top: 50,
            right: 30,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.close_sharp, size: 30, color: Colors.white),
            )),
      ],
    );
  }

  _onGetResult(String data) {
    Navigator.of(context).pushNamed("/scan-result", arguments: [data]);
  }
}
