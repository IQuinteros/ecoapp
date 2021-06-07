import 'package:flutter_ecoapp/models/base.dart';

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
    birthday         = DateTime.parse(json['birthday']);
    termsChecked    = json['termsChecked'];
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
    'lastName'        : this.lastName,
    'email'           : this.email,
    'contactNumber'   : this.contactNumber,
    'birthday'         : this.birthday,
    'termsChecked'    : this.termsChecked,
    'location'        : this.location,
    'rut'             : this.rut,
    'rutDv'           : this.rutDv,
    'createdDate'     : this.createdDate,
    'lastUpdateDate'  : this.lastUpdateDate
  };
}