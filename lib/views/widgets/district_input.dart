import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/district_bloc.dart';
import 'package:flutter_ecoapp/models/district.dart';
import 'package:flutter_ecoapp/models/profile.dart';
import 'package:flutter_ecoapp/views/widgets/normal_input.dart';
import 'package:google_fonts/google_fonts.dart';

class DistrictInput extends StatelessWidget {
  DistrictInput({ 
    Key? key, 
    required this.selectedDistrict, 
    this.validationMessage = 'Debe ingresar su comuna', 
    this.optional = false, 
    this.validate = true, 
    this.initialDistrict, 
    this.hint = 'Ingresa tu comuna'
  }) : super(key: key);

  final controller = TextEditingController();
  final String validationMessage;
  final bool validate;
  final bool optional;
  final String hint;

  final Function(DistrictModel?) selectedDistrict;
  final DistrictModel? initialDistrict;
  
  final Map<String, List<DistrictModel>>districts = {
    'districts' : []
  };

  @override
  Widget build(BuildContext context) {
    final districtBloc = BlocProvider.of<DistrictBloc>(context);

    return NormalInput(
      future: districtBloc.getDistricts(),
      initialData: districtBloc.loadedDistricts,
      header: 'Comuna', 
      hint: hint, 
      icon: Icons.location_on,
      readOnly: true, 
      onTap: () => selectDistrict(
        context,
        onSelect: (district) {
          controller.text = district?.name ?? '';
          selectedDistrict(district);
        },
        districts: districts['districts']!,
      ),
      onDoneSnapshot: (List<DistrictModel>? data, bool stillLoading){
        districts['districts'] = data ?? [];
        controller.text = initialDistrict?.name ?? '';
        if(initialDistrict != null) selectedDistrict(initialDistrict!);
      },
      controller: controller,
      validator: validate? (value) => value == null || value.isEmpty? validationMessage : null : null
    );
  }

  void selectDistrict(
    BuildContext context, 
    {
      Function(DistrictModel? district)? onSelect,
      List<DistrictModel> districts = const [],
    }
  ) async {
    final tempDistricts = [];
    tempDistricts.addAll(districts);
    if(optional){
      tempDistricts.insert(0, DistrictModel(id: 0, name: 'Sin seleccionar'));
    }
    final districtsTiles = tempDistricts.map<_DistrictTile>((element) => _DistrictTile(
      district: element,
      onTap: (){
        onSelect?.call(element.id <= 0? null : element);
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
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
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