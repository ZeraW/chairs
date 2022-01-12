import 'dart:io';
import 'package:chairs/ui_components/textfield_widget.dart';
import 'package:chairs/utils/colors.dart';
import 'package:chairs/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import '../../../../provider/add_provider.dart';
import '../../../../provider/edit_provider.dart';

//code text field for add and edit
class ChairCodeWidget extends StatelessWidget {
  final provider;

  ChairCodeWidget(this.provider);

  @override
  Widget build(BuildContext context) {
    return TextFormBuilder(
      hint: "Chair Code",
      controller: provider.codeController,
      errorText: provider.codeError,
    );
  }
}
//title text field for add and edit
class TitleWidget extends StatelessWidget {
  final provider;

  TitleWidget(this.provider);

  @override
  Widget build(BuildContext context) {
    return TextFormBuilder(
      hint: "Title",
      controller: provider.titleController,
      errorText: provider.titleError,
    );
  }
}
//desc text field for add and edit
class DescriptionWidget extends StatelessWidget {
  final provider;

  DescriptionWidget(this.provider);
  @override
  Widget build(BuildContext context) {
    return TextFormBuilder(
      hint: "Description",
      controller: provider.descriptionController,
      errorText: provider.descriptionError,
      maxLines: 3,
    );
  }
}
//Submit Btn for add and edit
class SubmitBtnWidget extends StatelessWidget {
  final provider;
  final String text;

  SubmitBtnWidget(this.provider,{@required this.text});
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () {
          provider.apiRequest();
        },
        style: ButtonStyle(
            padding:
            MaterialStateProperty.all(EdgeInsets.all(15)),
            backgroundColor:
            xColors.materialColor(xColors.mainColor)),
        child: Text(
          '$text',
          style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
//desc RadioBtn for add and edit
class StatusWidget extends StatelessWidget {
  final provider;
  final String init;

  StatusWidget(this.provider,{this.init});
  @override
  Widget build(BuildContext context) {
    return FormBuilderRadioGroup(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: const InputDecoration(
          contentPadding: const EdgeInsets.all(8),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
                width: 1, color: xColors.mainColor),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide:
            BorderSide(width: 1, color: Colors.redAccent),
          ),
          labelText: 'Status',
          labelStyle: const TextStyle(color: xColors.mainColor)),
      name: 'status',
      initialValue: init,
      activeColor: xColors.mainColor,
      validator: (v) => v == null ? provider.statusError : null,
      onChanged: (s)=>provider.updateStatus(s),
      options: ['Open', 'Closed']
          .map((lang) => FormBuilderFieldOption(value: lang))
          .toList(growable: false),
    );
  }
}
//parent Image
class _ImageWidget extends StatelessWidget {
  final provider;
  final Widget widget;
  final image;
  _ImageWidget(this.provider,{@required this.widget,@required this.image});
  @override
  Widget build(BuildContext context) {


    return FormBuilderField(
            name: "image",
            validator: (v) {
              if(image == null){
                if(provider.currentChairNote==null){
                  return provider.imageError;
                }else{
                  return null;
                }
              }else {
                return null;
              }
            } ,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            builder: (FormFieldState<dynamic> field) {
              return InputDecorator(
                decoration: InputDecoration(
                  contentPadding:
                  EdgeInsets.only(top: 10.0, bottom: 0.0),
                  border: InputBorder.none,
                  errorText: field.errorText,
                ),
                child: Row(
                  children: [
                    Container(
                      height: Responsive.width(20,context),
                      width: Responsive.width(22,context),
                      color: Colors.grey[400],
                      child: image != null
                          ? Image.file(image,fit: BoxFit.cover,)
                          : widget, // replace
                    ),
                    IntrinsicWidth(
                      child: ListTile(
                        onTap: (){
                          provider.takePicture();
                          field.didChange(null);
                        },
                        leading: CircleAvatar(
                          child: Icon(
                            Icons.camera_alt,
                            color: xColors.white,
                            size: 20,
                          ),
                          backgroundColor: xColors.mainColor  ,
                        ),
                        title: Text(
                          'Take a Picture',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
  }
//child image for Add screen
class ImageForAddScreen extends StatelessWidget {
  final provider;

  ImageForAddScreen(this.provider);
  @override
  Widget build(BuildContext context) {
    return Selector<AddVisualNoteProvider, File>(
        selector: (_, provider) => provider.image,
        builder: (context, image, child) {
          return _ImageWidget(provider,image: image,widget: Icon(Icons.photo_camera_back,size: 50,color: Colors.white,),) ;
        }
    );
  }
}
//child image for Edit screen
class ImageForEditScreen extends StatelessWidget {
  final provider;

  ImageForEditScreen(this.provider);
  @override
  Widget build(BuildContext context) {
    return Selector<EditVisualNoteProvider, File>(
        selector: (_, provider) => provider.image,
        builder: (context, image, child) {
          return _ImageWidget(provider,image: image,widget: Image.network(provider.currentChairNote.picture,fit: BoxFit.cover,height: 50,width: 50),) ;
        }
    );
  }
}







