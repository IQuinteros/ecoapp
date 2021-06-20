import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/district_bloc.dart';
import 'package:flutter_ecoapp/models/district.dart';
import 'package:flutter_ecoapp/models/profile.dart';
import 'package:flutter_ecoapp/views/widgets/normal_input.dart';
import 'package:google_fonts/google_fonts.dart';

class DistrictInput extends StatelessWidget {
  DistrictInput({ Key? key, required this.selectedDistrict, this.profile }) : super(key: key);

  final controller = TextEditingController();

  final Function(DistrictModel) selectedDistrict;
  final ProfileModel? profile;
  
  final Map<String, List<DistrictModel>>districts = {
    'districts' : []
  };

  @override
  Widget build(BuildContext context) {
    final districtBloc = BlocProvider.of<DistrictBloc>(context);

    return NormalInput(
      future: districtBloc.getDistricts(),
      header: 'Comuna', 
      hint: 'Ingresa tu comuna', 
      icon: Icons.location_on,
      readOnly: true, 
      onTap: () => selectDistrict(
        context,
        onSelect: (district) {
          controller.text = district.name;
          selectedDistrict(district);
        },
        districts: districts['districts']!,
      ),
      onDoneSnapshot: (List<DistrictModel>? data){
        districts['districts'] = data ?? [];
        if(profile != null && profile!.district != null){
          controller.text = profile!.district!.name;
          selectedDistrict(profile!.district!);
        }
      },
      controller: controller,
      validator: (value) => value == null || value.isEmpty? 'Debe ingresar su comuna' : null
    );
  }

  void selectDistrict(
    BuildContext context, 
    {
      Function(DistrictModel district)? onSelect,
      List<DistrictModel> districts = const [],
    }
  ) async {
    final districtsTiles = districts.map<_DistrictTile>((element) => _DistrictTile(
      district: element,
      onTap: (){
        if(onSelect != null) onSelect(element);
        Navigator.pop(context);
      }
    )).toList();

    showDialog(
      context: context, 
      builder: (__){
        return Dialog(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 20.0
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Escoge una comuna',
                  style: GoogleFonts.montserrat(),
                  textAlign: TextAlign.center
                ),
                SizedBox(height: 10.0),
                Column(
                  children: districtsTiles,
                )
              ],
            ),
          ),
        );
      }
    );
  }
}

class _DistrictTile extends StatelessWidget {
  const _DistrictTile({
    Key? key,
    required this.onTap,
    required this.district
  }) : super(key: key);

  final Function() onTap;
  final DistrictModel district;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        district.name,
        style: GoogleFonts.montserrat(),
      ),
      onTap: onTap
    );
  }
}