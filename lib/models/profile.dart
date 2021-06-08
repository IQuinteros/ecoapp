import 'package:flutter_ecoapp/models/base.dart';
import 'package:flutter_ecoapp/models/district.dart';
import 'package:flutter_ecoapp/models/user.dart';

class ProfileModel extends BaseModel
{
  late String name;
  late String lastName;
  late String email;
  late int contactNumber;
  late DateTime birthday;
  late bool termsChecked;
  late String location;
  late DateTime createdDate;
  late DateTime lastUpdateDate;
  late int rut;
  late String rutDv;
  
  DistrictModel get district => DistrictModel(id: 1, name: 'Concepción');
  UserModel get user => UserModel(id: 1, createdDate: DateTime.now());

  String get fullName => '$name $lastName';

  ProfileModel({
    required int id,
    required this.name,
    required this.lastName,
    required this.email, 
    required this.contactNumber,
    required this.birthday,
    required this.termsChecked,
    required this.location,
    required this.createdDate,
    required this.lastUpdateDate,
    required this.rut,
    required this.rutDv,
  }) : super(id: id);

  ProfileModel.fromJsonMap(Map<String, dynamic> json) : super(id: json['id']){
    name            = json['name'];
    lastName        = json['last_name'];
    email           = json['email'];
    contactNumber   = json['contact_number'];
    birthday        = DateTime.parse(json['birthday']);
    termsChecked    = json['terms_checked'] is bool? json['terms_checked'] : json['terms_checked'] != 0;
    location        = json['location'];
    createdDate     = DateTime.parse(json['creation_date']);
    lastUpdateDate  = DateTime.parse(json['last_update_date']);
    rut             = json['rut'];
    rutDv           = json['rut_cd'];
  }

  @override
  Map<String, dynamic> toJson() => {
    'id'              : this.id,
    'name'            : this.name,
    'last_name'        : this.lastName,
    'email'           : this.email,
    'contact_number'   : this.contactNumber,
    'birthday'         : this.birthday.toString(),
    'terms_checked'    : this.termsChecked,
    'district'          : this.district.id,
    'location'          : this.location,
    'rut'             : this.rut,
    'rut_cd'           : this.rutDv,
    'creation_date'     : this.createdDate.toString(),
    'last_update_date'  : this.lastUpdateDate.toString(),
    'user'              : this.user.id
  };

  @override
  Map<String, dynamic> toSqliteParams(){
    final json = super.toSqliteParams();
    json['terms_checked'] = termsChecked? 1 : 0;
    return json;
  }
}