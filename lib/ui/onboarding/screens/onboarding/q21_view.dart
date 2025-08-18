import 'package:admin_dashboard/app/helper/image_picker_helper.dart';
import 'package:admin_dashboard/data/nurse/model/nurse/onboarding/onboarding_model/customcard_model.dart';
import 'package:admin_dashboard/data/nurse/model/nurse/onboarding/onboarding_model/yesorno_model.dart';
import 'package:admin_dashboard/gen/assets.gen.dart';
import 'package:admin_dashboard/gen/colors.gen.dart';
import 'package:admin_dashboard/ui/onboarding/widgets/coustom_button.dart';
import 'package:admin_dashboard/ui/onboarding/widgets/custom_selection_card.dart';
import 'package:admin_dashboard/ui/onboarding/widgets/custom_textFeild.dart';
import 'package:admin_dashboard/ui/onboarding/widgets/custome_yesorno_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:admin_dashboard/ui/onboarding/bloc/onBoardingBloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:admin_dashboard/app/style_guide/typography.dart';
import 'package:admin_dashboard/app/helper/text_to_audio_helper.dart';
import 'package:admin_dashboard/app/string_constants.dart';
import '../../bloc/common/text_to_speech_bloc.dart';

import '../../bloc/common/text_to_speech_bloc.dart';

import '../../bloc/common/text_to_speech_bloc.dart';
import 'package:path/path.dart' as path;

class QTwentyOneView extends StatefulWidget {
  final OnboardingBloc bloc;
  final TextToSpeechBloc textToSpeechBloc;

  const QTwentyOneView({super.key, required this.bloc, required this.textToSpeechBloc});

  @override
  State<QTwentyOneView> createState() => _QTwentyOneViewState();
}

class _QTwentyOneViewState extends State<QTwentyOneView>
with AutoSpeechMixin {

  @override
  void initState() {
    super.initState();
    subscribeToSpeechStream(
      stream: widget.textToSpeechBloc.isAutoSpeechQuestion,
      onSpeak:
          () => widget.textToSpeechBloc.textToSpeech(StringConstants.q21Title),
      onStop: () => widget.textToSpeechBloc.stopSpeech(),
      // reset: widget.bloc.setAutoSpeach,
    );
    widget.bloc.updateUi();
  }

  final FilePickerHandler _filePicker = FilePickerHandler();


  Widget _filePickerView(){
    return  Container(
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: ColorName.grey1,),
      padding:  const EdgeInsets.all(12),
      child: Column(
        children: [
          Text(StringConstants.uploadDocument, style: placeholder.w400.text2),
          Gap(8),
          Text(StringConstants.inJpegOrPdf, style: small.w300.text1),
          Gap(8),
          _pickerButtonView(UploadFileType.folder),
          _orView(isFromButton: true),
          _pickerButtonView(UploadFileType.camera),
          if(widget.bloc.q21File != null)
            ...[
              Gap(16),
              Row(
                children: [
                  Expanded(
                    child: Tooltip(
                      message: path.basename(widget.bloc.q21File?.path.toString()??""),
                     margin: const EdgeInsets.symmetric(horizontal: 22),
                     preferBelow: false,
                     decoration: BoxDecoration(color: ColorName.grey2,borderRadius: BorderRadius.circular(8)),
                      textStyle: placeholder.w400.text2,
                      child: Container(
                        height: 40,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: ColorName.grey3)),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Center(
                            child: Row(
                              children: [
                                Assets.svgs.icFileImagePlaceholder.svg() ,
                                Gap(10),
                                Expanded(
                                  child: Text(path.basename(widget.bloc.q21File?.path.toString()??""),maxLines: 1,
                                      overflow: TextOverflow.ellipsis,style: placeholder.w400.text2),
                                ),
                                Gap(10),
                                Text(widget.bloc.q21FileSize.toString(),maxLines: 1,
                                    overflow: TextOverflow.ellipsis,style: s14.w300.text2)
                              ],
                            ),
                          )),
                    ),
                  ),
                  Gap(16),
                  InkWell(
                    onTap: (){
                      setState(() {
                        widget.bloc.q21File = null;
                      });
                      widget.bloc.updateUi();
                    },
                      child: Assets.svgs.icTrash.svg() ),
                  Gap(10),
                ],
              ),
            ]

        ],
      ),
    );
  }

  Widget _pickerButtonView(UploadFileType buttonType){
    return GestureDetector(
      onTap: () async {
        if(widget.bloc.q21Controller.text.isNotEmpty){
         return await _showMyDialog(isFromText: false);
        }

        if(widget.bloc.q21File == null){
          if(UploadFileType.folder == buttonType){
            final image =
            await _filePicker.pickPdfOrJpeg();
            setState(() {
              widget.bloc.q21File = image;
            });
          }else{
            final image =
            await _filePicker.pickImageFromCamera();
            setState(() {
              widget.bloc.q21File = image;
            });
          }
        }else{
         await _showMyDialog(isFromText:false,isImagedPicked: true);
        }

        if(widget.bloc.q21File != null){
          final fileSize = await _filePicker.getFileSize(widget.bloc.q21File);
          setState(() {
            widget.bloc.q21FileSize = fileSize;
          });
          widget.bloc.updateUi();
        }

      },
      child: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: ColorName.grey2,),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UploadFileType.folder == buttonType ? Assets.svgs.icUpload.svg() : Assets.svgs.icCamera.svg() ,
            Gap(10),
            Text(UploadFileType.camera == buttonType ? StringConstants.takePhoto : StringConstants.upload, style: h14),
          ],
        ),
      ),
    );
  }

  Widget _orView({bool isFromButton = false}){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: isFromButton == true ? 12 :32),
      child: Row(
        children: [
          Expanded(child: Divider(color: ColorName.grey2,thickness: 1,endIndent: 16,)),
          Text(StringConstants.or, style: h14),
          Expanded(child: Divider(color: ColorName.grey2,thickness: 1,indent: 16,)),

        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(StringConstants.q21Title, style: h24),
          Gap(16),
          GestureDetector(
            onTap: ()async{
              if(widget.bloc.q21File != null){
                await _showMyDialog(isFromText: true);
              }
            },
            child: CustomTextField.textFieldSingle(
              enabled: widget.bloc.q21File == null,
              widget.bloc.q21Controller,
              hintText: "Type",
              keyboardType: TextInputType.name,
            ),
          ),
          _orView(),
          _filePickerView(),
          Gap(49),
        ],
      ),
    );
  }

  Future<void> _showMyDialog({required isFromText,bool? isImagedPicked}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(

          title: Text('Note!',textAlign: TextAlign.center,style: h24,),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                isImagedPicked == true? Text("You've already uploaded an image. Please remove it if you want to Upload image.",style: h14,):
                Text(isFromText == true? "You've already uploaded an image. Please remove it if you want to enter GP.":
                "You've already entered GP. Please clear it if you want to upload an image.",style: h14,),
              ],
            ),
          ),
          actions: <Widget>[
            SubmitButton(
              "Ok",
              onTap: (loader) {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }


}

enum UploadFileType {camera,folder}