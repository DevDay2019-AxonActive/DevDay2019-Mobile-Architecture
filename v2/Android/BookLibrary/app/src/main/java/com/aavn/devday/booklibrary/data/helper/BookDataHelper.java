package com.aavn.devday.booklibrary.data.helper;

import com.aavn.devday.booklibrary.data.model.Book;
import com.aavn.devday.booklibrary.data.model.BookDetail;
import com.google.gson.Gson;

import java.util.ArrayList;
import java.util.List;

public class BookDataHelper {
    private BookDataHelper() {
    }

    public static List<Book> validateData(List<Book> rawData) {
        List<Book> resultList = new ArrayList<>();
        if (rawData != null && !rawData.isEmpty()) {
            for (Book bookItem : rawData) {
                if (bookItem.getDetails() != null && bookItem.getDetails().size() > 1) {
                    List<Book> bookSeparated = separateBookDetail(bookItem);
                    resultList.addAll(bookSeparated);
                } else {
                    resultList.add(copyBook(bookItem));
                }
            }
        }
        return resultList;
    }

    private static Book copyBook(Book rawData) {
        Gson gson = new Gson();
        return gson.fromJson(gson.toJson(rawData), Book.class);
    }

    private static BookDetail copyBookDetail(BookDetail rawDataDetail) {
        Gson gson = new Gson();
        return gson.fromJson(gson.toJson(rawDataDetail), BookDetail.class);
    }

    public static List<Book> separateBookDetail(Book rawdata) {
        List<Book> resultList = new ArrayList<>();
        if (rawdata == null) return resultList;
        for (BookDetail bookDetailItem : rawdata.getDetails()) {
            BookDetail bookDetail = copyBookDetail(bookDetailItem);
            List<BookDetail> bookDetails = new ArrayList<>();
            bookDetails.add(bookDetail);
            Book book = new Book(rawdata.getId(), rawdata.getTitle(), rawdata.getAuthor(), bookDetails);
            resultList.add(book);
        }
        return resultList;
    }
}
