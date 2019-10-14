import 'package:books/bloc/base_bloc.dart';
import 'package:books/bloc/search_book_bloc/search_book_bloc.dart';
import 'package:books/model/book.dart';
import 'package:books/screen/book_cell.dart';
import 'package:flutter/material.dart';

class BookListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BookListViewState();
  }
}

class BookListViewState extends State<BookListView> {
  SearchBookBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = SearchBookBloc();
  }

  @override
  void dispose() {
    bloc?.dispose();
    super.dispose();
  }

  TextEditingController editingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchBookBloc>(
      bloc: bloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Book List'),
        ),
        body: Column(
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                      bloc.changeKeyword(value);
                    },
                  controller: editingController,
                  decoration: InputDecoration(
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
            ),
            Expanded(
                flex: 5,
                child: StreamBuilder(
                    stream: bloc.bookList,
                    builder: (context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data.results.length,
                            itemBuilder: (context, index) {
                              return listItem(snapshot.data.results[index]);
                            });
                      } else {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              // Image.asset(
                              //   'assets/search_image.png',
                              //   width: 180.0,
                              //   height: 180.0,
                              // ),
                              SizedBox(height: 20.0),
                              Flexible(
                                  child: Text(
                                'Type a word',
                                style: Theme.of(context).textTheme.display1,
                              ))
                            ],
                          ),
                        );
                      }
                    }),
              ),
          ],
        ),
      ),
    );
  }

  Widget listItem(Book result) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 10.0,
      margin: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Container(
            // child: Image.network(result.details.regular),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                ClipRRect(
                  child: FadeInImage.assetNetwork(
                      width: 30,
                      height: 30,
                      // placeholder: 'assets/user.png',
                      // image: result.user.profileImage.medium
                      ),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                SizedBox(width: 10.0),
                Text(result.name),
                Spacer(),
                // GestureDetector(
                //   onTap: (){
                //     bloc.shareImage(result.urls.regular);
                //   },
                //   child: Icon(Icons.share, color: Colors.white),
                // )
              ],
            ),
          )
        ],
      ),
    );
  }
}
