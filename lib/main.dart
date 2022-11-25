import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}


class Book {
  final String title;
  final String author;
  Book(this.title, this.author);
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //var _selectBook = false;
  Book? book;
  _handleSelectBook(Book book){
    setState(() {
      //_selectBook = true;
      this.book = book;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Navigator(pages: [
        MaterialPage(child: ListBookScreen(_handleSelectBook)),
        if (book != null)
        MaterialPage(child: DetailBookScreen(book))
      ],
        onPopPage: (route,result)=>route.didPop(result),
      ));
  }
}

class ListBookScreen extends StatelessWidget{

  var onTaped;
  ListBookScreen(this.onTaped) : super (key: ValueKey(onTaped));

  List<Book> books = [
    Book('book1', 'author1'),
    Book('book2', 'author2'),
    Book('book3', 'author3')
  ];
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(title: Text('ListBooks')),
      body: ListView(
        children: [
          for(var book in books)
              ListTile(title: Text(book.title),
              subtitle: Text(book.author),
              onTap:()=> this.onTaped(book)),
        ],
      ),
    ));
  }
}

class DetailBookScreen extends StatelessWidget{
  var book;
  DetailBookScreen(this.book) : super(key: ValueKey(book));
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(title: Text('detail')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(book.title + '     ' + book.author),
      )));
  }

}
