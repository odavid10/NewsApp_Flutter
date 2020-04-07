import 'package:flutter/material.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/services/news_service.dart';
import 'package:newsapp/src/theme/tema.dart';
import 'package:newsapp/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            _ListaCategorias(),
            Expanded(
              child: ListaNoticias(newsService.getArticulosCategoriaSeleccionada),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListaCategoria extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final categories = Provider.of<NewsService>(context).categories;

    return Container(
      width: double.infinity,
      heigth: 80,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {

          final cName = categories[index].name;

          return Container(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  _CategoryButton(categories[index]),
                  SizedBox(height: 5),
                  Text('${cName[0].toUpperCase()}${cName.substring(1)}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {

  final Category categoria;

  const _CategoryButton(this.categorias);

  @override
  Widget build(BuildContext context) {

    final newService = Provider.of<NewsService>(context);

    return GestureDetector(
      onTap: (){
        final newService = Provider.of<NewsService>(context, listen: false);
        newService.selectedCategory = categoria.name;
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10,)
        width: 40,
        heigth: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle
        ),
        child: Icon(
          categoria.icon,
          color: (newService.selectedCategory == this.categoria.name)
                ? miTema.accentColor
                : Colors.balck54,
        ),
      ),
    );
  }
}