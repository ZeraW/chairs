import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:chairs/utils/dimensions.dart';
import 'package:chairs/utils/colors.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';


class TextFormBuilder extends StatefulWidget {
  final String hint;
  final TextInputType keyType;
  final bool isPassword,enabled;
  final TextEditingController controller;
  final String errorText;
  final int maxLength,maxLines;
  final Color activeBorderColor;
  final FocusNode focusNode;

  TextFormBuilder(
      {this.hint,
      this.keyType,
      this.isPassword,
      this.controller,
        this.focusNode,
      this.errorText,this.maxLines=1,
        this.maxLength,
        this.enabled =true,
      this.activeBorderColor});

  @override
  _TextFormBuilderState createState() => _TextFormBuilderState();
}
class _TextFormBuilderState extends State<TextFormBuilder> {
  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      focusNode: widget.focusNode,
      autovalidateMode: AutovalidateMode.onUserInteraction,
        name: '${widget.hint}',
        maxLength: widget.maxLength,
        controller: widget.controller,
        style: TextStyle(fontSize: Responsive.isMobile(context) ?Responsive.width(3.5,context):17),
        validator: (value) {
          if (value.isEmpty) {
            return "${widget.errorText}";
          }
          return null;
        },
        enabled: widget.enabled,
        //controller: _controller,
        maxLines: widget.maxLines,
        textInputAction: TextInputAction.next,

        //onChanged: onChange,
        keyboardType: widget.keyType != null ? widget.keyType : TextInputType.text,
        obscureText: widget.isPassword != null ? widget.isPassword : false,
        decoration: InputDecoration(
          labelText: '${widget.hint}',
          labelStyle: TextStyle(
              color: widget.activeBorderColor ?? xColors.mainColor,
              fontSize: Responsive.isMobile(context) ?Responsive.width(3.5,context):17),
          hintText: "${widget.hint}",
          hintStyle: TextStyle(
              color: widget.activeBorderColor ?? xColors.hintColor,
              fontSize: Responsive.isMobile(context) ?Responsive.width(3.5,context) : 17),
          contentPadding: new EdgeInsets.symmetric(
              vertical: Responsive.height(2.5,context),
              horizontal: Responsive.width(2.0,context)),
          focusedErrorBorder: new OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: xColors.mainColor),
          ),
          errorStyle: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.w500),
          focusedBorder: new OutlineInputBorder(
            borderSide: BorderSide(
                width: 1, color: widget.activeBorderColor ?? xColors.mainColor),
          ),
          errorBorder: new OutlineInputBorder(
            borderSide:
                BorderSide(width: 1, color: Colors.redAccent),
          ),
          enabledBorder: new OutlineInputBorder(
            borderSide: BorderSide(
                width: 1, color: Colors.black54, style: BorderStyle.solid),
          ),
          disabledBorder: new OutlineInputBorder(
            borderSide: BorderSide(
                width: 1, color: Colors.black54, style: BorderStyle.solid),
          ),
          fillColor: Colors.white,
        ));
  }
}
