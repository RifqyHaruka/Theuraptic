import 'package:flutter/cupertino.dart';
import 'package:haldac/model/category_model.dart';
import 'package:haldac/services/category_services.dart';

class CategoryProvider with ChangeNotifier {
  // CategoryGet? _doki;

  // CategoryGet get doki => _doki as CategoryGet;

  // set doki(CategoryGet doki) {
  //   _doki = doki;
  //   notifyListeners();
  // }

  // Future<bool> getData(String? categoriesId) async {
  //   try {
  //     CategoryGet category =
  //         await CategoryService().getProductsbyCategory(categoriesId);
  //     _doki = category;
  //     return true;
  //   } catch (e) {
  //     print(e);
  //     return false;
  //   }
  // }

  List<DoctorModel> _dokter = [];

  List<DoctorModel> get dokter => _dokter;

  set dokter(List<DoctorModel> dokter) {
    _dokter = dokter;
    notifyListeners();
  }

  Future<void> getData(String? categoriesId, String? token) async {
    try {
      List<DoctorModel> dokter =
          await CategoryService().getProductsbyCategory(categoriesId, token);
      _dokter = dokter;
    } catch (e) {
      print(e);
    }
  }
}
