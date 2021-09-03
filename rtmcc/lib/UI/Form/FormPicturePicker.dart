// 请一次性选择完毕
// 选择的照片一次性完全覆盖
// 拍摄的照片可以不消失并手动可删除
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import './FormItem.dart';
import '../../UI/ActionSheet/main.dart';

// 单次最多上传9张图片
const int maxNumber = 9;
// 缝隙宽度
const int w = 0;
// 左上角删除小标大小
const double ds = 24;

class FormPicturePicker extends StatefulWidget {
  final Key? key;
  // 标签
  final String label;
  // 是否是必选项
  final bool? required;

  FormPicturePicker({
    this.key,
    required this.label,
    this.required,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => FormPicturePickerState();
}

class FormPicturePickerState extends State<FormPicturePicker> {
  String? _errText;
  List<XFile> _imageFileList = [];
  List<XFile> _tokenFileList = [];
  dynamic _pickImageError;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  void picking() async {
    try {
      final List<XFile>? pickedFileList = await _picker.pickMultiImage(
        maxWidth: 100,
        maxHeight: 100,
      );
      setState(() {
        _imageFileList = pickedFileList!;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  void taking() async {
    try {
      final XFile? pickedFileList = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 100,
        maxHeight: 100,
      );
      setState(() {
        _tokenFileList = [..._tokenFileList, pickedFileList!];
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  // 快捷校验，不可为空
  bool _validate() {
    return true;
  }

  // 主校验入口
  bool validate() {
    // 如果有必填项才会继续向下判断
    if (widget.required != null && widget.required!) {
      // 如果没有则只进行非空校验
      return _validate();
    }
    // 默认不校验
    return true;
  }

  void error(String x) {
    setState(() {
      _errText = x;
    });
  }

  void validateSuccess() {
    setState(() {
      _errText = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    double _size = MediaQuery.of(context).size.width;
    _size = (_size - 40) / 3 - w;
    return FormItem(
      label: widget.label,
      isRequired: widget.required,
      errText: _errText,
      extend: true,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Wrap(
          children: [
            ..._renderImgs(_size),
            _renderAddPic(_size),
          ],
        ),
      ),
    );
  }

  _renderImgs(s) {
    List<Widget> arr = [];
    _imageFileList.forEach((el) {
      arr.add(PicItem(size: s, path: el.path, onDelete: _deleteIt));
    });
    _tokenFileList.forEach((el) {
      arr.add(PicItem(size: s, path: el.path, onDelete: _deleteIt));
    });
    return arr;
  }

  _deleteIt(path) {
    var it =
        _imageFileList.where((element) => element.path == path).toList()[0];

    setState(() {
      _imageFileList.remove(it);
    });
  }

  _renderAddPic(s) {
    // 尚未满最大数量
    if (_imageFileList.length >= maxNumber) {
      return Container();
    }
    return AddPic(size: s, onAdd: _onAddPicture);
  }

  _onAddPicture() {
    ActionSheet.of(context)
        .show(items: ["拍摄", "选择照片"], actions: [_gotoTakePhoto, _gotoAlbum]);
  }

  // 准备拍摄照片
  _gotoTakePhoto() {
    taking();
  }

  // 到相册里去选择
  _gotoAlbum() {
    picking();
  }

  @override
  void dispose() {
    // 及时销毁
    super.dispose();
  }
}

class PicItem extends StatelessWidget {
  final double size;
  final String path;
  final Function(String path) onDelete;
  PicItem({required this.size, required this.path, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size,
        height: size,
        margin: EdgeInsets.all(w / 2),
        child: Container(
          child: Stack(
            children: [
              Positioned(
                top: ds / 2,
                left: ds / 2,
                child: Container(
                  width: size - ds,
                  height: size - ds,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey)),
                  child: Image.file(File(path)),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: GestureDetector(
                  onTap: () {
                    onDelete(path);
                  },
                  child: Container(
                    width: ds,
                    height: ds,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(ds / 2),
                    ),
                    child: Icon(Icons.delete_outline,
                        color: Colors.white, size: ds - 6),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class AddPic extends StatelessWidget {
  final double size;
  final Function() onAdd;
  AddPic({required this.size, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: onAdd,
        child: Container(
          margin: EdgeInsets.all(w / 2),
          width: size - ds,
          height: size - ds,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: Icon(Icons.add_a_photo_outlined),
        ),
      ),
    );
  }
}
