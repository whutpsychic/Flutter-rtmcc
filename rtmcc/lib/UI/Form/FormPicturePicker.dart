import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import './FormItem.dart';

// 单次最多上传9张图片
const int maxNumber = 9;
// 缝隙宽度
const int w = 12;

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
  List<XFile>? _imageFileList;
  dynamic _pickImageError;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  void picking() async {
    try {
      final pickedFileList = await _picker.pickMultiImage(
        maxWidth: 100,
        maxHeight: 100,
        // imageQuality: quality,
      );
      setState(() {
        _imageFileList = pickedFileList;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  // 快捷校验，不可为空
  bool _validate() {
    // if (_currTime == null) {
    //   error("您必须选择${widget.label}!");
    //   return false;
    // } else {
    //   validateSuccess();
    //   return true;
    // }
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
        // color: Colors.orange,
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Wrap(
          children: [
            ..._renderImgs(_size),
            _renderAddPic(_size),
            // AddPic(size: _size, onAdd: _onAddPicture),
            // AddPic(size: _size, onAdd: _onAddPicture),
            // AddPic(size: _size, onAdd: _onAddPicture),
            // AddPic(size: _size, onAdd: _onAddPicture),
            // AddPic(size: _size, onAdd: _onAddPicture),
            // AddPic(size: _size, onAdd: _onAddPicture),
            // AddPic(size: _size, onAdd: _onAddPicture),
            // AddPic(size: _size, onAdd: _onAddPicture),
          ],
        ),
      ),
    );
  }

  _renderImgs(s) {
    if (_imageFileList != null) {
      List<Widget> arr = [];
      _imageFileList!.forEach((el) {
        Widget imgItem = Container(
          width: s,
          height: s,
          margin: EdgeInsets.all(w / 2),
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: Image.file(File(el.path)),
        );
        arr.add(imgItem);
      });

      return arr;
    }
    return [];
  }

  _renderAddPic(s) {
    // 尚未满最大数量
    if (_imageFileList != null && _imageFileList!.length >= maxNumber) {
      return Container();
    }
    return AddPic(size: s, onAdd: _onAddPicture);
  }

  _onAddPicture() {
    picking();
  }

  @override
  void dispose() {
    // 及时销毁
    super.dispose();
  }
}

class AddPic extends StatelessWidget {
  final double size;
  final Function() onAdd;
  AddPic({required this.size, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onAdd,
      child: Container(
        margin: EdgeInsets.all(w / 2),
        width: size,
        height: size,
        decoration:
            BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
        child: Icon(Icons.add_a_photo_outlined),
      ),
    );
  }
}
