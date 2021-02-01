import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {



    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(
        primaryColor: Colors.white
      ),
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {

  final List<WordPair> _suggestions = <WordPair>[];            // NEW
  final TextStyle _biggerFont = const TextStyle(fontSize: 18);
  final _saved = Set<WordPair>();

  Widget _buildSuggestions(){
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemBuilder: (BuildContext _context, int i){
        if(i.isOdd){
         return Divider();
        }

        final int index = i~/2;


        if(index>= _suggestions.length){
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );

  }

  Widget _buildRow(WordPair suggestion) {
    final alreadySaved = _saved.contains(suggestion);
    return ListTile(
      title: Text(
          suggestion.asPascalCase,
          style: _biggerFont,

      ),
      trailing: Icon(
        alreadySaved?Icons.favorite:Icons.favorite_border,
        color: alreadySaved?Colors.red:null,
      ),
      onTap: (){
        setState(() {
          if(alreadySaved){
            _saved.remove(suggestion);
          }else{
            _saved.add(suggestion);
          }
        });
      },
    );
  }
  void _onPushed(){
    Navigator.of(context).push(
      MaterialPageRoute<void>(
          builder: (BuildContext _context){
            final tiles = _saved.map((WordPair pair) {
              return ListTile(
                title: Text(
                    pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            });

            final divided = ListTile.divideTiles(
              context: _context,
              tiles: tiles,
            ).toList();
            return Scaffold(
              appBar: AppBar(
                title: Text('Saved Suggestion'),

              ),
              body: ListView(children: divided),
            );

          }
      )


    );
  }

  @override
  Widget build(BuildContext context) {
   // final wordPair = WordPair.random();

    return  Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _onPushed)
        ],

      ),
      body: _buildSuggestions(),
    );
  }


}



