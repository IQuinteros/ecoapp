import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/article_bloc.dart';
import 'package:flutter_ecoapp/models/district.dart';
import 'package:flutter_ecoapp/models/search.dart';
import 'package:flutter_ecoapp/views/widgets/district_input.dart';
import 'package:flutter_ecoapp/views/widgets/normal_button.dart';
import 'package:flutter_ecoapp/views/widgets/normal_input.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchFilter extends StatelessWidget {
  SearchFilter({ Key? key}) : super(key: key);
  final Map<String, TextEditingController> controllers = {
    'category': TextEditingController(),
    'minPrice': TextEditingController(),
    'maxPrice': TextEditingController(),
  };

  final Map<String, DistrictModel?> selectedDistrict = {
    'district': null
  };

  static Future<SearchFilterModel> openSearchFilter({required BuildContext context}) async {
    final articleBloc = BlocProvider.of<ArticleBloc>(context);

    final result = await showDialog(
      context: context, 
      builder: (BuildContext context){
        return Dialog(
          elevation: 10,
          child: SearchFilter(),
        );
      }
    );

    articleBloc.currentSearchFilter = result ?? SearchFilterModel();
    return articleBloc.currentSearchFilter;
  }

  final _formKey = GlobalKey<FormState>(); 

  @override
  Widget build(BuildContext context) {

    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    controllers['category']!.text = articleBloc.currentSearchFilter.category ?? '';
    controllers['minPrice']!.text = articleBloc.currentSearchFilter.minPrice?.toString() ?? '';
    controllers['maxPrice']!.text = articleBloc.currentSearchFilter.maxPrice?.toString() ?? '';
    selectedDistrict['district'] = articleBloc.currentSearchFilter.district ?? null;
    
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 20.0
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          // TODO: Create combobox inputs
          children: [
            Text(
              'Filtrar por:',
              style: GoogleFonts.montserrat(
                fontSize: 18.0
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 10.0),
            Divider(thickness: 1,),
            SizedBox(height: 10.0),
            NormalInput(
              header: 'Categoría', 
              hint: 'Busca por categoría', 
              icon: Icons.category_rounded,
              controller: controllers['category'],
            ),
            SizedBox(height: 10.0),
            DistrictInput(
              selectedDistrict: (value) => selectedDistrict['district'] = value,
              validate: false,
              initialDistrict: selectedDistrict['district'],
              optional: true,
              hint: 'Sin seleccionar',
            ),
            SizedBox(height: 10.0),
            NormalInput(
              header: 'Precio mínimo', 
              hint: 'Desde', 
              icon: Icons.payments_rounded,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly
              ],
              type: TextInputType.number,
              controller: controllers['minPrice'],
              validator: (value){
                if(value != null && value.isNotEmpty && controllers['maxPrice']!.text.isNotEmpty){
                  if(int.parse(controllers['minPrice']!.text.toString()) > int.parse(controllers['maxPrice']!.text.toString())){
                    return 'El valor mínimo no puede ser mayor';
                  }
                }
              },
            ),
            SizedBox(height: 10.0),
            NormalInput(
              header: 'Precio máximo', 
              hint: 'Hasta', 
              icon: Icons.payments_rounded,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly
              ],
              type: TextInputType.number,
              controller: controllers['maxPrice'],
              validator: (value){
                if(value != null && value.isNotEmpty && controllers['minPrice']!.text.isNotEmpty){
                  if(int.parse(controllers['minPrice']!.text.toString()) > int.parse(controllers['maxPrice']!.text.toString())){
                    return 'El valor máximo no puede ser menor';
                  }
                }
              },
            ),
            NormalButton(
              text: 'Aplicar filtros', 
              onPressed: () {
                if(!_formKey.currentState!.validate()) return;
                Navigator.pop(context, SearchFilterModel(
                  category: controllers['category']!.text.isEmpty? null : controllers['category']!.text,
                  district: selectedDistrict['district'],
                  minPrice: int.tryParse(controllers['minPrice']!.text),
                  maxPrice: int.tryParse(controllers['maxPrice']!.text),
                ));
              }
            )
          ],
        ),
      ),
    );
  }
}