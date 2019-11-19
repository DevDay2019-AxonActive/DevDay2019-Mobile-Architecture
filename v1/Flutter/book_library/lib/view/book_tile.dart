import 'package:book_library/model/book.dart';
import 'package:flutter/material.dart';

class BookTile extends StatelessWidget {
  final Book book;
  final bool isSearching = true;
  BookTile({this.book});

  Widget separator() {
    return Container(
        margin: new EdgeInsets.symmetric(vertical: 8.0),
        height: 2.0,
        width: 18.0,
        color: new Color(0xff00c6ff));
  }

  @override
  Widget build(BuildContext context) {
    var _isDetailValid = (book.details != null &&
        book.details.length > 0 &&
        book.details[0].description != null);

    return Card(
      margin: EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 5.0),
      elevation: 5,
      // constraints: new BoxConstraints.expand(),
      child: Row(
        children: <Widget>[
          // book's image
          Container(
            alignment: Alignment.center,
            width: 90.0,
            height: 120.0,
            child: (_isDetailValid && book.details[0].coverUrl != "")
                ? Image.network(book.details[0].coverUrl)
                : Image.asset('lib/assets/images/book_thumbnail.png'),
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  book.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 3,
                ),
                separator(),
                Text(
                  (isSearching && _isDetailValid)
                      ? book.details[0].description
                      : book.author,
                  maxLines: 3,
                ),
                separator(),
                Container(
                    alignment: Alignment(0.95, 1.0),
                    child: Text(
                      (_isDetailValid) ? book.details[0].source : "AAVN",
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
