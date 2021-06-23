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

    articleBloc.currentSearchFilter = result ?? articleBloc.currentSearchFilter;
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
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
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
                readOnly: true,
                onTap: () async => controllers['category']!.text = await selectCategory(context),
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
              ),
              SizedBox(height: 10.0),
              NormalButton(
                text: 'Quitar filtros', 
                onPressed: () {
                  if(!_formKey.currentState!.validate()) return;
                  Navigator.pop(context, SearchFilterModel());
                }
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<String> selectCategory(BuildContext context) async {
    return await showDialog(
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
                  'Escoge una categoría',
                  style: GoogleFonts.montserrat(),
                  textAlign: TextAlign.center
                ),
                SizedBox(height: 10.0),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          'Sin seleccionar',
                          style: GoogleFonts.montserrat(),
                        ),
                        onTap: () => Navigator.pop(context, ''),
                      ),
                      ListTile(
                        title: Text(
                          'Hogar',
                          style: GoogleFonts.montserrat(),
                        ),
                        onTap: () => Navigator.pop(context, 'Hogar'),
                      ),
                      ListTile(
                        title: Text(
                          'Cuidado personal',
                          style: GoogleFonts.montserrat(),
                        ),
                        onTap: () => Navigator.pop(context, 'Cuidado personal'),
                      ),
                      ListTile(
                        title: Text(
                          'Alimentos',
                          style: GoogleFonts.montserrat(),
                        ),
                        onTap: () => Navigator.pop(context, 'Alimentos'),
                      ),
                      ListTile(
                        title: Text(
                          'Ropa',
                          style: GoogleFonts.montserrat(),
                        ),
                        onTap: () => Navigator.pop(context, 'Ropa'),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}