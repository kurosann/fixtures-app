import 'package:fixtures/service/api/FileApi.dart';
import 'package:fixtures/service/api/UserApi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class AddBankCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddBankCardState();
}

class _AddBankCardState extends State<AddBankCard> with FileMixin, UserApi {
  var _idCardController = TextEditingController();
  var _phoneController = TextEditingController();
  var _nameController = TextEditingController();
  var _bankCardController = TextEditingController();
  var _bankController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          previousPageTitle: '返回',
          middle: Text("添加"),
        ),
        backgroundColor: CupertinoColors.systemGroupedBackground,
        child: GestureDetector(
          onPanDown: (_) {
            FocusScopeNode currentFocus = FocusScope.of(context);

            /// 键盘是否是弹起状态
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          child: ListView(
            children: [
              Form(
                autovalidateMode: AutovalidateMode.always,
                onChanged: () {
                  Form.of(primaryFocus!.context!)?.save();
                },
                child: CupertinoFormSection.insetGrouped(
                    margin: EdgeInsets.symmetric(
                        horizontal: gutter, vertical: gutterV),
                    children: [
                      _formCell(
                          title: '开户行',
                          controller: _bankController,
                          placeholder: '请输入开户行'),
                      _formCell(
                          title: '卡号',
                          controller: _bankCardController,
                          keyboardType: TextInputType.number,
                          maxLength: 16,
                          placeholder: '请输入卡号'),
                      _formCell(
                          title: '持卡人',
                          controller: _nameController,
                          placeholder: '请输入持卡人姓名'),
                      _formCell(
                          title: '身份证',
                          controller: _idCardController,
                          maxLength: 18,
                          regExp: r'[0-9|X|x]',
                          placeholder: '请输入身份证'),
                      _formCell(
                          title: '手机号',
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          placeholder: '请输入银行卡预留手机号',
                          maxLength: 11,
                          isDone: true),
                    ]),
              ),
            ],
          ),
        ));
  }

  void UploadFiles(file) async {
    postFile(
        file: file,
        successCallBack: (data) {
//          success
        },
        errorCallBack: (int code, String msg) {
//          error
        });
  }

  static final double gutterV = 4;

  static final double gutter = 8;

  CupertinoTextFormFieldRow _formCell(
      {required String title,
      required TextEditingController controller,
      String? placeholder,
      bool? readOnly,
      TextInputType? keyboardType,
      int? maxLength,
      String? regExp,
      bool? isDone}) {
    var inputFormatters = <TextInputFormatter>[];
    if (maxLength != null) {
      inputFormatters.add(LengthLimitingTextInputFormatter(maxLength));
    }
    if (regExp != null) {
      inputFormatters.add(FilteringTextInputFormatter.allow(RegExp(regExp)));
    }

    return CupertinoTextFormFieldRow(
      readOnly: readOnly == true,
      style: TextStyle(height: 1.4),
      controller: controller,
      prefix: Text(title),
      inputFormatters: inputFormatters,
      textAlign: TextAlign.end,
      keyboardType: keyboardType,
      placeholder: placeholder,
      textInputAction:
          isDone == true ? TextInputAction.done : TextInputAction.next,
    );
  }
}
