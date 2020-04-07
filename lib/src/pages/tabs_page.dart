import 'package:flutter/material.dart';
import 'package:newsapp/src/pages/tab1_page.dart';
import 'package:newsapp/src/pages/tab2_page.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new _NavegacionModel(),
      child: Scaffold(
        body: _Paginas(),
        bottonNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {
  const _Navegacion({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final navegacionModel = Provider.of<_NavegacionModel>(context);
    final newsService = Provider.of<NewsService>(context);

    return BottonNavigationBar(
      currentIndex: navegacionModel.paginaActual,
      onTap: (i) => navegacionModel.paginaActual = i,
      items: [
        BottonNavigationBarItem( icon: Icon(Icons.person_outline), title: Text('Pata ti'),),
        BottonNavigationBarItem( icon: Icon(Icons.public), title: Text('Encabezados'),),
      ]
    );
  }
}

class _Paginas extends StatelessWidget {
  const _Paginas({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return PageView(
      controller: navegacionModel.pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Tab1Page(),
        Tab2Page(),
      ],
    );
  }
}

class _NavegacionModel with ChangeNotifier{

  int _paginaActual = 0;
  PageController _pageController = new PageController();

  int get paginaActual => this._paginaActual;

  set paginaActual (int valor) {
    this._paginaActual = valor;
    _pageController.animateToPage(valor, duration: Duration(milliseconds: 250), curve: Curves.easeOut);
    notifyListeners();
  }

  PageController get pageController => this._pageController;
}