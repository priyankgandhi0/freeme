import 'dart:convert';
/// address : [{"address_line1":"jammu,kashmir.,ssakjdf,,sdc,,,,sdsd","address_line2":"sd.,lk,asdl/...,,,/';[]askljd","city":"suart","state":"gujrat","zip":"395006","country":"india"},{"address_line1":"jammu,kashmir.,ssakjdf,,sdc,,,,sdsd","address_line2":"sd.,lk,asdl/...,,,/';[]askljd","city":"ahmedabad","state":"gujrat","zip":"395010","country":"india"}]

AddressRequestModel addressRequestModelFromJson(String str) => AddressRequestModel.fromJson(json.decode(str));
String addressRequestModelToJson(AddressRequestModel data) => json.encode(data.toJson());
class AddressRequestModel {
  AddressRequestModel({
      List<AddressData>? address,}){
    _address = address;
}

  AddressRequestModel.fromJson(dynamic json) {
    if (json['address'] != null) {
      _address = [];
      json['address'].forEach((v) {
        _address?.add(AddressData.fromJson(v));
      });
    }
  }
  List<AddressData>? _address;
AddressRequestModel copyWith({  List<AddressData>? address,
}) => AddressRequestModel(  address: address ?? _address,
);
  List<AddressData>? get address => _address;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_address != null) {
      map['address'] = _address?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// address_line1 : "jammu,kashmir.,ssakjdf,,sdc,,,,sdsd"
/// address_line2 : "sd.,lk,asdl/...,,,/';[]askljd"
/// city : "suart"
/// state : "gujrat"
/// zip : "395006"
/// country : "india"

AddressData addressFromJson(String str) => AddressData.fromJson(json.decode(str));
String addressToJson(AddressData data) => json.encode(data.toJson());
class AddressData {
  AddressData({
      num? addressId,
      String? addressLine1,
      String? addressLine2,
      String? city,
      String? state,
      String? zip,
      String? country,}){
    _addressId = addressId;
    _addressLine1 = addressLine1;
    _addressLine2 = addressLine2;
    _city = city;
    _state = state;
    _zip = zip;
    _country = country;
}

  AddressData.fromJson(dynamic json) {
    _addressId = json['address_id'];
    _addressLine1 = json['address_line1'];
    _addressLine2 = json['address_line2'];
    _city = json['city'];
    _state = json['state'];
    _zip = json['zip'];
    _country = json['country'];
  }
  num? _addressId;
  String? _addressLine1;
  String? _addressLine2;
  String? _city;
  String? _state;
  String? _zip;
  String? _country;

  num? get  addressId => _addressId;
  String? get addressLine1 => _addressLine1;
  String? get addressLine2 => _addressLine2;
  String? get city => _city;
  String? get state => _state;
  String? get zip => _zip;
  String? get country => _country;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address_id'] = _addressId;
    map['address_line1'] = _addressLine1;
    map['address_line2'] = _addressLine2;
    map['city'] = _city;
    map['state'] = _state;
    map['zip'] = _zip;
    map['country'] = _country;
    return map;
  }

}