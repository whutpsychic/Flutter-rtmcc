import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

// 默认5秒轮播间隔
const int du = 5;

List<Color> colors = [Colors.grey[400]!, Colors.grey[600]!];

class Carousel extends StatefulWidget {
  final List<String> data;
  final Function(dynamic it, int index)? onTap;
  final bool? enlargeCenterPage;
  final Axis? direction;
  final bool? autoPlay;
  Carousel({
    required this.data,
    this.onTap,
    this.enlargeCenterPage,
    this.direction,
    this.autoPlay,
  });

  @override
  State<StatefulWidget> createState() => CarouselState();
}

class CarouselState extends State<Carousel> {
  // 一共几张图片
  int nums = 0;
  // 当前第几张
  int curr = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      nums = widget.data.length;
    });
  }

  _renderRadios() {
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

    return arr;
  }

  _renderInnerRadios() {
    double _sw = MediaQuery.of(context).size.width;
    List<Widget> rs = _renderRadios();

    if (widget.direction != null && widget.direction != Axis.horizontal)
      return Container();

    return Positioned(
      bottom: 10,
      child: Container(
        width: _sw,
        child: Row(children: rs, mainAxisAlignment: MainAxisAlignment.center),
      ),
    );
  }

  _renderOuterRadios() {
    double _sw = MediaQuery.of(context).size.width;
    List<Widget> rs = _renderRadios();

    if (widget.direction != null && widget.direction != Axis.horizontal)
      return Container();

    return Container(
      width: _sw,
      child: Row(children: rs, mainAxisAlignment: MainAxisAlignment.center),
    );
  }

  _onPageChanged(int x, reason) {
    setState(() {
      curr = x;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool _enlargeCenterPage =
        widget.enlargeCenterPage == null || widget.enlargeCenterPage!;
    return Column(
      children: [
        Container(
          child: Stack(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: widget.autoPlay ?? true,
                  enlargeCenterPage: _enlargeCenterPage,
                  scrollDirection: widget.direction ?? Axis.horizontal,
                  viewportFraction: _enlargeCenterPage ? 0.8 : 1.0,
                  onPageChanged: _onPageChanged,
                ),
                items: widget.data.map((item) {
                  int i = widget.data.indexOf(item);
                  return GestureDetector(
                    onTap: () {
                      if (widget.onTap != null) widget.onTap!(item, i);
                    },
                    child: Container(
                      child: Center(
                        child: Image.network(
                          item,
                          width: 2000,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("加载中..."),
                                  Text(
                                      "${loadingProgress.expectedTotalBytes != null ? ((loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!) * 100).toStringAsFixed(0) : 0}%")
                                ],
                              ),
                            );
                          },
                          errorBuilder: (ctx, ex, st) =>
                              Container(child: Text("图片加载失败")),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              _enlargeCenterPage ? Container() : _renderInnerRadios()
            ],
          ),
        ),
        _enlargeCenterPage ? _renderOuterRadios() : Container(),
      ],
    );
  }
}
