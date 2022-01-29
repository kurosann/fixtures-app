import 'package:fixtures/model/IdCardModel.dart';
import 'package:fixtures/service/api/FileApi.dart';
import 'package:fixtures/service/api/IdCardApi.dart';
import 'package:fixtures/service/api/UserApi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class AddBankCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddBankCardState();
}

class _AddBankCardState extends State<AddBankCard> with IdCardApi {
  var _idCardController = TextEditingController();
  var _phoneController = TextEditingController();
  var _nameController = TextEditingController();
  var _bankCardController = TextEditingController();
  var _bankController = TextEditingController();

  void openMsg(String msg) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('提示'),
            content: Text(msg),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('确认'),
                onPressed: () {
                  Navigator.of(context).pop("ok");
                },
              ),
            ],
          );
        });
  }
  void saveIdCard(){
    postIdCard(
      params: IdCardModel(
          bankName:_bankController.text,
          bankCardNo:_bankCardController.text,
          cardOwner:_nameController.text,
          idCard:_idCardController.text,
          phone:_phoneController.text),
      successCallBack: (data) {
        Navigator.of(context).pop(-1);
      },
      errorCallBack: (code, err) {
        if (code == 500) {
          openMsg(err);
        }
      }
    );
  }

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
              _btnWidget()
            ],
          ),
        ));
  }

  Widget _btnWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: 'toNext',
            child: CupertinoButton.filled(child: Text("提交"), onPressed: () {
              saveIdCard();
            }),
          ),
        ],
      ),
    );
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
