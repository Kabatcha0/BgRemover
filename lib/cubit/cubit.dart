// ignore_for_file: unused_element, avoid_print
import 'dart:convert';
import 'dart:io';
import 'package:bgremover/cubit/states.dart';
import 'package:bgremover/shared/network.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BgRemoverCubit extends Cubit<BgRemoverStates> {
  BgRemoverCubit() : super(BgRemoverInitialState());
  static BgRemoverCubit get(context) => BlocProvider.of(context);
  Uint8List? imageAfter;
  FilePickerResult? result;
  File? file;
  pickImage() async {
    result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false)
        .then((value) {
      file = File(value!.files.single.path!.toString());

      print(file);
      emit(BgRemoverPickState());
    }).catchError((onError) {
      print(onError.toString());
      emit(BgRemoverErrorPickState());
    });
  }

  void sendPhoto() async {
    emit(BgRemoverSendLoadingState());
    String fileName = file!.path.split("/").last;
    print(fileName);
    FormData data = FormData.fromMap({"source_image_file": file!.path});
    List<int> trans = file!.path.codeUnits;
    Uint8List bytes = Uint8List.fromList(trans);
    String string = String.fromCharCodes(bytes);

    DioHelper.postData(data: {"source_image_file": string}).then((value) {
      imageAfter = value.data;
      emit(BgRemoverSendState());
    }).catchError((onError) {
      print("hello:${onError.toString()}");
      emit(BgRemoverErrorSendState());
    });
  }
}
