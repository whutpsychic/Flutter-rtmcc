import 'package:flutter/material.dart' hide Form, FormState;
import '../../core/MyPage/main.dart';
import '../../UI/Form/main.dart';
import '../../UI/Button/main.dart';

import '../../static/main.dart';

GlobalKey<FormState> fk = GlobalKey();
GlobalKey<FormInputState> fik = GlobalKey();
GlobalKey<FormNumberInputState> fnk = GlobalKey();
GlobalKey<FormPickerState> fpk = GlobalKey();
GlobalKey<FormMultiPickerState> fmpk = GlobalKey();
GlobalKey<FormLevelPickerState> flpk = GlobalKey();
GlobalKey<FormTreePickerState> ftpk = GlobalKey();
GlobalKey<FormYearPickerState> fypk = GlobalKey();
GlobalKey<FormMonthPickerState> fmopk = GlobalKey();
GlobalKey<FormDatePickerState> fdpk = GlobalKey();
GlobalKey<FormMinutePickerState> fmipk = GlobalKey();
GlobalKey<FormPicturePickerState> fimpk = GlobalKey();

class FormItems extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageState();
}

class _PageState extends State<FormItems> {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: "表单",
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
            key: fk,
            keys: [
              fik,
              fnk,
              fpk,
              fmpk,
              flpk,
              ftpk,
              fypk,
              fmopk,
              fdpk,
              fmipk,
              fimpk
            ],
            children: [
              // ============================================
              FormInput(
                key: fik,
                label: "一般文字输入框",
                required: true,
                // enabled: false,
                // defaultValue: "jdsklfjkldsjkl",
              ),
              FormNumberInput(
                key: fnk,
                label: "数字输入框",
                required: true,
                // enabled: false,
                // defaultValue: "798789",
              ),
              FormPicker(
                key: fpk,
                label: "一般单选",
                data: selectData,
                required: true,
                // enabled: false,
                // defaultValue: 4,
                onChange: (v) {
                  print(v);
                },
              ),
              FormMultiPicker(
                key: fmpk,
                label: "多列选择",
                data: [selectData, selectData2],
                required: true,
                // enabled: false,
                // defaultValue: [4, 6],
                onChange: (v) {
                  print(v);
                },
              ),
              FormLevelPicker(
                key: flpk,
                label: "级联选择",
                data: treeData,
                depth: 3,
                required: true,
                // enabled: false,
                // defaultValue: 154,
                onChange: (v) {
                  print(v);
                },
              ),
              FormTreePicker(
                key: ftpk,
                label: "树形选择",
                data: treeData,
                required: true,
                // enabled: false,
                // defaultValue: 154,
                onChange: (v) {
                  print(v);
                },
              ),
              FormYearPicker(
                key: fypk,
                label: "年份选择器",
                required: true,
                // enabled: false,
                // defaultValue: DateTime(2000),
                onChange: (v) {
                  print(v);
                  print(v is DateTime);
                },
              ),
              FormMonthPicker(
                key: fmopk,
                label: "月份选择器",
                required: true,
                // enabled: false,
                // defaultValue: DateTime(2000, 2),
                onChange: (v) {
                  print(v);
                  print(v is DateTime);
                },
              ),
              FormDatePicker(
                key: fdpk,
                label: "日期选择器",
                required: true,
                // enabled: false,
                // defaultValue: DateTime(2000, 2, 2),
                onChange: (v) {
                  print(v);
                  print(v is DateTime);
                },
              ),
              FormMinutePicker(
                key: fmipk,
                label: "时分选择器",
                required: true,
                // enabled: false,
                // defaultValue: DateTime(2000, 2, 2),
                onChange: (v) {
                  print(v);
                  print(v is DateTime);
                },
              ),
              FormPicturePicker(key: fimpk, label: "图片选择器", required: true),
              // ============================================
              Container(
                margin: EdgeInsets.only(top: 10),
                child: BlockButton(child: Text('Check'), onPressed: _onCheck),
              )
            ],
          ),
        ),
      ),
    );
  }

  _onCheck() {
    bool result = fk.currentState!.validate();

    print(result);
  }
}
