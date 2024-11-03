import 'package:flutter/material.dart';
import 'package:mynewearth/models/offering_model.dart';

class OfferingProvider extends ChangeNotifier{
  List<OfferingModel> _offerings=[];
  List<OfferingModel> get offerings=>_offerings;

  void addOffering(OfferingModel offering){
    _offerings.add(offering);
    notifyListeners();

  }
  void deleteoffering(int index)
  {
    _offerings.removeAt(index);
    if(index>=0 && index< _offerings.length)
    _offerings.removeAt(index);
    notifyListeners();

  }
  void updateoffering(int index,OfferingModel offering){
_offerings[index]=offering;
notifyListeners();
  }

  deleteOffering(int index) {}
}