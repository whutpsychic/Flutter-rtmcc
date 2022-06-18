import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import './IconBtn.dart';
import './TimeStamp.dart';
import './config.dart';

// 等待多久后控制层消失
const int timeout = 8;

// ----------- fixers -----------
// 非全屏隔宽度
const _nfsw = 200;
// 全屏隔宽度
const _fsw = 300;

class Video extends StatelessWidget {
  final String? title;
  final String? url;
  Video({required this.url, this.title});

  @override
  Widget build(BuildContext context) {
    return url != null ? VideoInner(url: url!, title: title) : Container();
  }
}

// -------------------------------------------

class VideoInner extends StatefulWidget {
  final String? title;
  final String url;
  VideoInner({required this.url, this.title});
  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<VideoInner> {
  late VideoPlayerController _controller;

  int? _timeLength;

  // 显藏控制器计时器按键
  Timer? _timeoutEvent;

  // states
  // 正在缓冲
  bool _loading = true;
  // 正在播放
  bool _playing = false;
  // 全屏模式
  bool _fullScreen = false;
  // 显示控制器层
  bool _showControls = true;
  // 进度条进度值
  double _rating = 0;
  // 当前第几秒
  int _cs = 0;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..addListener(() {
        double _r = (_controller.value.position.inSeconds /
                _controller.value.duration.inSeconds) *
            100;
        setState(() {
          _rating = _r;
          _cs = _controller.value.position.inSeconds.toInt();
          _loading = _controller.value.isBuffering;
        });
      })
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _timeLength = _controller.value.duration.inSeconds;
        });
      });

    _waitForAWhile();
  }

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.purple,
      child: _controller.value.isInitialized
          ? Stack(
              children: [
                // 视频层
                Container(
                  color: Colors.black,
                  width: _w,
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                ),
                // 全平面透明手势触发器层
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: GestureDetector(
                    onTap: _toggleShowControls,
                    onDoubleTap: () {
                      _commonOP(() {
                        setState(() {
                          _showControls = true;
                        });
                        _togglePlay();
                      });
                    },
                    child: Container(color: Colors.transparent, width: _w),
                  ),
                ),
                // 控制器层
                _showControls
                    ? Container(
                        width: _w,
                        child: AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconBtn(Icons.arrow_back_ios_new,
                                        onTap: _fallBack, size: -4),
                                    Text(
                                      widget.title ?? "",
                                      style: TextStyle(
                                          fontSize: 16, color: styleColor),
                                    ),
                                    // IconBtn(Icons.more_horiz)
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconBtn(
                                        _playing
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                        onTap: _togglePlay),
                                    TimeStamp(_cs),
                                    Container(
                                      width: _w - (_fullScreen ? _fsw : _nfsw),
                                      child: CupertinoSlider(
                                        value: _rating,
                                        onChangeStart: (x) {
                                          _waitUp();
                                          _controller.pause();
                                        },
                                        onChangeEnd: (x) {
                                          _waitForAWhile();
                                          _controller.play();
                                        },
                                        onChanged: (newRating) {
                                          setState(() {
                                            _rating = newRating;
                                          });
                                          _controller.seekTo(Duration(
                                            seconds:
                                                (_timeLength! / 100 * newRating)
                                                    .toInt(),
                                          ));
                                        },
                                        min: 0,
                                        max: 100,
                                      ),
                                    ),
                                    TimeStamp(_timeLength),
                                    IconBtn(
                                        _fullScreen
                                            ? Icons.fullscreen_exit
                                            : Icons.fullscreen,
                                        onTap: _toggleFullScreen),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : Container(),
                // 加载中提示
                _loading
                    ? Container(
                        width: _w,
                        child: AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: Center(
                            child: Text(
                              "正在缓冲...",
                              style: TextStyle(color: styleColor, fontSize: 12),
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            )
          : Container(),
    );
  }

  // 我正在操作的时候请等一下再消失
  void _waitUp() {
    if (_timeoutEvent != null) _timeoutEvent!.cancel();
  }

  // 计时若干秒后隐藏控制器视图
  void _waitForAWhile() {
    _waitUp();
    Timer _t = Timer(Duration(seconds: timeout), () {
      setState(() {
        _showControls = false;
      });
    });
    _timeoutEvent = _t;
  }

  // 常规操作
  void _commonOP(Function() fun) {
    _waitUp();
    fun();
    _waitForAWhile();
  }

  void _toggleShowControls() {
    if (_showControls) {
      setState(() {
        _showControls = false;
        if (_timeoutEvent != null) _timeoutEvent!.cancel();
      });
    } else {
      setState(() {
        _showControls = true;
      });
      _waitForAWhile();
    }
  }

  // 点击回退
  void _fallBack() {
    _commonOP(() {
      if (_fullScreen) {
        _exitFullScreen();
      } else {
        Navigator.of(context).pop();
      }
    });
  }

  void _togglePlay() {
    _commonOP(() {
      if (_playing) {
        _controller.pause();
        setState(() {
          _playing = false;
        });
      } else {
        _controller.play();
        setState(() {
          _playing = true;
        });
      }
    });
  }

  // 进入全屏模式
  void _toFullScreen() {
    _commonOP(() {
      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
      setState(() {
        _fullScreen = true;
      });
    });
  }

  // 退出全屏模式
  void _exitFullScreen() {
    _commonOP(() {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      setState(() {
        _fullScreen = false;
      });
    });
  }

  void _toggleFullScreen() {
    _commonOP(() {
      if (_fullScreen) {
        _exitFullScreen();
      } else {
        _toFullScreen();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
