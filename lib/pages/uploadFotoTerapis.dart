import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:haldac/pages/mainTherapis.dart';
import 'package:haldac/provider/auth_provider.dart';
import 'package:haldac/theme.dart';
import 'package:haldac/widget/loading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadFotoTerapis extends StatefulWidget {
  const UploadFotoTerapis({Key? key}) : super(key: key);

  @override
  _UploadFotoTerapisState createState() => _UploadFotoTerapisState();
}

class _UploadFotoTerapisState extends State<UploadFotoTerapis> {
  bool isLoading = false;
  File? getImage;
  String imagePath = '';
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    Future getImageGallery() async {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image?.path != null) {
        var imageTemporary = File(image?.path as String);
        getImage = imageTemporary;
        setState(() {});
      } else if (image?.path == null) {
        print('coba');
      }
      print(getImage);

      print(image?.path);
    }

    uploadHandler() async {
      setState(() {
        isLoading = true;
      });
      SharedPreferences pref = await SharedPreferences.getInstance();
      if (getImage != null) {
        if (await AuthProvider()
            .getPicTherapis(pref.get('token') as String, getImage as File)) {
          await Provider.of<AuthProvider>(context, listen: false).getDokter();

          print(Provider.of<AuthProvider>(context, listen: false).dokter.photo);

          await Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MainTherapis()),
              (route) => false);
        }

        setState(() {
          isLoading = false;
        });
      } else if (getImage == null) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: buttonMerah,
            content: Text(
              "Silahkan Upload Foto Terbaru",
              textAlign: TextAlign.center,
            )));
      }

      // Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    }

    lewatiHandler() async {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainTherapis()),
          (route) => false);
    }

    Future getImageCamera() async {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image?.path != null) {
        var imageTemporary = File(image?.path as String);
        getImage = imageTemporary;
        setState(() {});
      } else {
        print('Coba');
      }

      print(image?.path);
    }

    Widget photo() {
      return Column(
        children: [
          (getImage != null)
              ? Container(
                  margin: EdgeInsets.only(bottom: 24),
                  child: Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: primary,
                      image: DecorationImage(
                          image: FileImage(getImage as File),
                          fit: BoxFit.cover),
                    ),
                    // child: (getImage != null)
                    //     ? Image.file(
                    //         getImage as File,
                    //         fit: BoxFit.contain,
                    //         width: 100,
                    //         height: 100,
                    //       )
                    //     : Image.asset(
                    //         'assets/UserPic.png',
                    //         fit: BoxFit.cover,
                    //       )
                  ),
                )
              : (authProvider.dokter.photo != null)
                  ? CachedNetworkImage(
                      imageBuilder: (context, imageProvider) {
                        return Container(
                            margin: EdgeInsets.only(bottom: 24),
                            height: 160,
                            width: 160,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover)));
                      },
                      imageUrl: authProvider.dokter.photo as String,

                      // progressIndicatorBuilder:
                      //     (context, url, downloadProgress) =>
                      //         CircularProgressIndicator(
                      //             value: downloadProgress.progress),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      fit: BoxFit.contain)
                  : Container(
                      margin: EdgeInsets.only(bottom: 24),
                      height: 160,
                      width: 160,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage('assets/VectorProfile.png'),
                              fit: BoxFit.cover))),
          SizedBox(
            height: 8,
          ),
          Text(
            authProvider.dokter.name as String,
            style: whiteText.copyWith(fontSize: 24, fontWeight: semiBold),
          )
        ],
      );
      // return
    }

    Widget header() {
      return Container(
        height: 300,
        decoration: BoxDecoration(color: hijauBlock),
      );
      // return
    }

    Widget button(String text, String tipe, {int? index}) {
      return GestureDetector(
        onTap: () {
          if (tipe == 'gallery') {
            getImageGallery();
          } else if (tipe == 'camera') {
            getImageCamera();
          } else if (tipe == 'upload') {
            uploadHandler();
          } else if (tipe == 'lewati') {
            lewatiHandler();
          }
        },
        child: Container(
          margin: EdgeInsets.only(top: (index == 1) ? 20 : 30),
          height: 55,
          width: MediaQuery.of(context).size.width - 60,
          decoration: BoxDecoration(
              color: buttonHijau, borderRadius: BorderRadius.circular(8)),
          child: Center(
            child: Text(
              text,
              style: whiteText.copyWith(fontSize: 18, fontWeight: semiBold),
            ),
          ),
        ),
      );
    }

    Widget containerButton() {
      return Container(
        height: 420,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: white),
        child: Container(
          margin: EdgeInsets.only(top: 30),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text(
              'Atur Profile Saya',
              style: blackText.copyWith(fontSize: 20, fontWeight: regular),
            ),
            button('Ambil Gambar dari gallery', 'gallery', index: 1),
            button('Ambil Gambar dari kamera', 'camera'),
            (isLoading == true)
                ? Loading(
                    margin: 30,
                  )
                : button('Upload', 'upload'),
            button('Lewati', 'lewati')
          ]),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: hijauBlock,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(alignment: Alignment.center, children: [
                header(),
                photo(),
              ]),
              containerButton()
            ],
          ),
        ),
      ),
    );
  }
}
