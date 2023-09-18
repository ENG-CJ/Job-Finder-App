import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:job_finder/mixins/no_data_found_error.dart';
import 'package:job_finder/util/helpers/text_helper.dart';
import 'package:job_finder/util/text.dart';

import '../../consts/colors.dart';
import '../../mixins/messages.dart';
import '../../services/local/book_marks.dart';

class BookMarksPage extends StatefulWidget {
  const BookMarksPage({super.key});

  @override
  State<BookMarksPage> createState() => _BookMarksPageState();
}

class _BookMarksPageState extends State<BookMarksPage>
    with Messages, NoDataErrorMixin {
  late Future<List<Bookmarks>> bookmarks;

  @override
  void initState() {
    // TODO: implement initState
    bookmarks = Bookmarks().getBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 15),
            child: CText(
              text: "Your Bookmarks",
              decorations:
                  TextDecorations(fontSize: 23, family: "Poppins SemiBold"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
            ),
            child: CText(text: "Manage Your Boommarks,"),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(),
          FutureBuilder(
              future: bookmarks,
              builder: (_, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                  case ConnectionState.done:
                  default:
                    if (snapshot.hasError)
                      return CText(
                          text:
                              "Error occured While Performing Your Bookmarks");
                    else if (snapshot.hasData) {
                      if (snapshot.data!.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 100),
                          child: noDataError(
                              context,
                              "Reload",
                              "You haven't Bookmarked yet",
                              "No Bookmarks available", (context, result) {
                            setState(() {
                              bookmarks = Bookmarks().getBookmarks();
                            });
                          }),
                        );
                      }
                      return ListView.separated(
                          separatorBuilder: (_, i) => SizedBox(height: 10),
                          itemCount: snapshot.data!.length,
                          shrinkWrap: true,
                          itemBuilder: (_, i) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 30),
                              child: Slidable(
                                endActionPane: ActionPane(
                                    motion: ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (_) {
                                          showDialog(
                                              context: context,
                                              builder: (_) => showConfirmation(
                                                      context,
                                                      "Do You want to remove this bookmark",
                                                      "Confirmation",
                                                      onConfirm: () {
                                                    Bookmarks()
                                                        .deleteBookmarks(i);

                                                    setState(() {
                                                      bookmarks = Bookmarks()
                                                          .getBookmarks();
                                                    });
                                                    Navigator.pop(context);
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                            content: CText(
                                                                text:
                                                                    "Bookmark with the name ${snapshot.data![i].jobTitle} has been removed.")));
                                                  }));
                                        },
                                        backgroundColor: colors['error-color']!
                                            .withOpacity(0.7) as Color,
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                      ),
                                    ]),
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Color(0xFFd6d6e5).withOpacity(1),
                                          offset: Offset(-1, 2),
                                          blurRadius: 13,
                                          spreadRadius: -4,
                                        ),
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(14)),
                                  child: ListTile(
                                    // titleTextStyle: TextStyle(fontSize: 19, color: Colors.red),
                                    title: CText(
                                      text: snapshot.data![i].jobTitle!,
                                      decorations: TextDecorations(
                                          color: colors['primary'] as Color,
                                          fontSize: 20,
                                          family: "Poppins Medium"),
                                    ),
                                    subtitle: CText(
                                        decorations: TextDecorations(
                                            color: Colors.grey,
                                            fontSize: 15,
                                            family: "Poppins Light"),
                                        text:
                                            snapshot.data![i].jobDescription!),
                                  ),
                                ),
                              ),
                            );
                          });
                    }

                    return Text("No Data Available");
                }
              })
        ],
      )),
    );
  }
}
