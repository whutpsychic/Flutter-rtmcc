import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../core/MyPage/main.dart';
import './Page1.dart';
import './Page2.dart';
import './Page3.dart';
import './Page4.dart';

List<Color> colors = [Colors.grey[400]!, Colors.grey[600]!];

class CarouselOverview extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageState();
}

class _PageState extends State<CarouselOverview> with MyPage {
  int nums = 4;
  int curr = 0;

  @override
  Widget build(BuildContext context) {
    double _sh = MediaQuery.of(context).size.height;
    return MyScaffold(
      child: Container(
        child: Stack(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: _sh,
                viewportFraction: 1.0,
                onPageChanged: _onPageChanged,
                enableInfiniteScroll: false,
              ),
              items: [
                Page1(),
                Page2(),
                Page3(),
                Page4(),
              ],
            ),
            Positioned(bottom: 20, child: _renderRadios())
          ],
        ),
      ),
    );
  }

  _onPageChanged(x, reason) {
    setState(() {
      curr = x;
    });
  }

  _renderRadios() {
    double _sw = MediaQuery.of(context).size.width;
    List<Widget> arr = [];

    var r = Container(
      width: 10,
      height: 10,
      margin: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: colors[0],
        borderRadius: BorderRadius.circular(10),
      ),
    );

    var ar = Container(
      width: 40,
      height: 10,
      margin: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: colors[1],
        borderRadius: BorderRadius.circular(10),
      ),
    );

    for (int i = 0; i < nums; i++) {
      if (i == curr) {
        arr.add(ar);
      } else {
        arr.add(r);
      }
    }

    return Container(
        width: _sw,
        alignment: Alignment.center,
        child: Row(
          children: arr,
          mainAxisAlignment: MainAxisAlignment.center,
        ));
  }
}
