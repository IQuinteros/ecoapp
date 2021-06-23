import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/cart_bloc.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/utils/currency_util.dart';
import 'package:flutter_ecoapp/views/article_view.dart';
import 'package:flutter_ecoapp/views/widgets/articles/mini_eco_indicator.dart';
import 'package:flutter_ecoapp/views/widgets/normal_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';

class CartArticleCard extends StatefulWidget {

  final ArticleModel article;
  final Function() onDelete;
  final int initialQuantity;

  const CartArticleCard({Key? key, required this.article, required this.onDelete, required this.initialQuantity}) : super(key: key);

  @override
  _CartArticleCardState createState() => _CartArticleCardState();
}

class _CartArticleCardState extends State<CartArticleCard> {

  int? _quantity;
  bool _deleted = false;

  @override
  Widget build(BuildContext context) {
    
    if(_quantity == null) _quantity = widget.initialQuantity;
    
    ImageProvider<Object> imageData = AssetImage('assets/png/no-image-bg.png');
    if(widget.article.photos.length > 0)
      imageData = NetworkImage(widget.article.photos[0].photoUrl);

    final image = Image(
      image: imageData,
      height: 120,
      width: 120,
      fit: BoxFit.cover,
    );

    final imageContainer = Container(
      child: image,
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, .25),
            blurRadius: 10.0,
            spreadRadius: 5.0
          )
        ]
      ),
    );


    final ecoIndicator = MiniEcoIndicator(
      ecoIndicator: widget.article.form.getIndicator()
    );

    final title = Text(
      widget.article.title,
      textAlign: TextAlign.start,
      style: GoogleFonts.montserrat(),
    );

    final priceRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        ecoIndicator,
        Text(
          CurrencyUtil.formatToCurrencyString(widget.article.price.toInt(), symbol: '\$'),
          style: GoogleFonts.montserrat(),
          textAlign: TextAlign.end,
        ),
      ],
    );

    var column = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(width: 10.0),
        title,
        SizedBox(height: 30),
        priceRow,
        SizedBox(width: 10.0)
      ],
    );

    final rowFirst = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        imageContainer,
        SizedBox(width: 20.0),
        Expanded(child: column, flex: 1,),
        SizedBox(width: 20.0)
      ],
    );

    final deleteButton = TextButton(
      child: Text('Eliminar'),
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.black54),
        textStyle: MaterialStateProperty.all(GoogleFonts.montserrat())
      ),
      onPressed: () {
        AwesomeDialog(
          title: 'Eliminar artículo del carrito',
          desc: 'Se eliminará este artículo del carrito. Lo puedes volver a agregar cuando quieras',
          dialogType: DialogType.INFO, 
          animType: AnimType.BOTTOMSLIDE,
          context: context,
          btnOkText: 'Volver',
          btnCancelText: 'Eliminar',
          btnOkOnPress: () {},
          btnOkColor: Colors.black26,
          //btnCancelColor: Colors.black26,
          btnCancelOnPress: () {
            _deleteArticleFromCart(context);
          },
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0)
        )..show();
      },
    );

    final quantitySelector = Container(
      child: InkWell(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 5
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(child: Container()),
              Text(
                _quantity.toString(),
                style: GoogleFonts.montserrat(),
                textAlign: TextAlign.end,
              ),
              Icon(
                Icons.arrow_drop_down
              )
            ],
          ),
        ),
        onTap: () => selectQuantity(context),
      ),
    );

    final rowSecond = Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20.0
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          deleteButton,
          SizedBox(width: 20.0,),
          Expanded(child: quantitySelector)
        ],
      ),
    );

    final card = Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      child: Column(
        children: [
          rowFirst,
          Divider(height: 0, thickness: 1, color: Colors.black12,),
          rowSecond,
        ],
      )
    );

    final layout = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints){
        print(constraints.maxWidth);
        return card;
      }
    );

    return Visibility(
      visible: !_deleted,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 10.0
        ),
        child: InkWell(
          child: layout,
          borderRadius: BorderRadius.circular(20.0),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (__) => ArticleView(article: widget.article))),
        ),
      ),
    );
  }

  int _tempQuantity = 1;
  void selectQuantity(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context){
        return _QuantitySelector(
          onChanged: (value) {
            _tempQuantity = value;
          },
          initialValue: _quantity!,
        );
      },
      elevation: 10,
      enableDrag: false
    );
    
    final cartBloc = BlocProvider.of<CartBloc>(context);
    await cartBloc.updateArticleToCart(widget.article, _tempQuantity);
    setState(() => _quantity = _tempQuantity);
  }

  void _deleteArticleFromCart(BuildContext context) async {
    final cartBloc = BlocProvider.of<CartBloc>(context);
    setState(() {
      _deleted = true;
    }); 
    await cartBloc.removeArticleToCart(widget.article);
    widget.onDelete();
  }
}

class _QuantitySelector extends StatefulWidget {
  const _QuantitySelector({
    Key? key,
    required this.onChanged,
    this.initialValue = 1
  }) : super(key: key);

  final Function(int) onChanged;
  final int initialValue;

  @override
  __QuantitySelectorState createState() => __QuantitySelectorState();
}

class __QuantitySelectorState extends State<_QuantitySelector> {
  int quantity = 1;
  bool first = true;

  @override
  Widget build(BuildContext context) {
    if(first) quantity = widget.initialValue;

    final numberPicker = Container(
      child: NumberPicker(
        value: quantity,
        minValue: 1,
        maxValue: 100,
        itemCount: 3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        
        textMapper: (value) => '$value ' + (value != '1'? 'unidades' : 'unidad'),
        onChanged: (value) {
          setState(() {
            first = false;
            quantity = value;
          });
          widget.onChanged(value);
        }
      ),
    );

    final title = ([TextAlign textAlign = TextAlign.center]) => Text(
      'Escoge la cantidad para este artículo',
      style: GoogleFonts.montserrat(),
      textAlign: textAlign,
    );

    final backBtn = NormalButton(
      text: 'Volver', 
      onPressed: () => Navigator.pop(context)
    );

    final maxSize = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        title(),
        SizedBox(height: 20.0,),
        numberPicker,
        SizedBox(height: 20.0,),
        backBtn
      ],
    );

    final lowSize = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        title(TextAlign.start),
        SizedBox(height: 10.0,),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(child: numberPicker, flex: 2),
            SizedBox(height: 20.0,),
            Expanded(child: backBtn)
          ],
        )
      ],
    );

    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 20.0
        ),
        child: LayoutBuilder(
          builder: (context, constraints){
            if(constraints.maxHeight <= 250) return lowSize;
            else return maxSize;
          },
        ),
      )
    );
  }
}