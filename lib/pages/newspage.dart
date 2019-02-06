import 'package:finalproject/helpers/app_constants.dart';
import 'package:finalproject/helpers/newsmodel.dart';
import 'package:finalproject/pages/addmedicinepage.dart';
import 'package:finalproject/pages/languagepage.dart';
import 'package:finalproject/pages/newsmorepage.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  _NewsPageState createState() => new _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<NewsModel> newslist = new List<NewsModel>();
  @override
  initState() {
    super.initState();
    getData();
  }

  Future<Null> refreshData() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      // checkConnection(context);
    });
    return null;
  }

  getData() {
    newslist.add(NewsModel(
        news:
            "Sed ut perspiciatis unde omnis iste natu error sit voluptatem accusantium doloremque laudantium, totam rem aperiameaque ipsa quae ab illo inventore veritatis et quasi architectobeatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.",
        title: "Lorem ipsum dolor sit amet onsectetur adipiscing Lorem ipsum",
        imgUrl:
            "https://www.es-rueck.de/203898/teaserbild_publikationen_c44c0dcc9a2bef6a309cca9ceae231f6b4fbe68b.jpg",
        date: "07.02.2019"));
    newslist.add(NewsModel(
        news:
            "Sed ut perspiciatis unde omnis iste natu error sit voluptatem accusantium doloremque laudantium, totam rem aperiameaque ipsa quae ab illo inventore veritatis et quasi architectobeatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.",
        title: "Lorem ipsum dolor sit amet onsectetur adipiscing Lorem ipsum",
        imgUrl:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSiXf0UWAyeyKc6aOhyxL6w6BPHU3kL5IsyNhvdpvydeqczunCSGA",
        date: "07.02.2019"));
    newslist.add(NewsModel(
        news:
            "Sed ut perspiciatis unde omnis iste natu error sit voluptatem accusantium doloremque laudantium, totam rem aperiameaque ipsa quae ab illo inventore veritatis et quasi architectobeatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.",
        title: "Lorem ipsum dolor sit amet onsectetur adipiscing Lorem ipsum",
        imgUrl:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSiXf0UWAyeyKc6aOhyxL6w6BPHU3kL5IsyNhvdpvydeqczunCSGA",
        date: "07.02.2019"));
    newslist.add(NewsModel(
        news:
            "Sed ut perspiciatis unde omnis iste natu error sit voluptatem accusantium doloremque laudantium, totam rem aperiameaque ipsa quae ab illo inventore veritatis et quasi architectobeatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.",
        title: "Lorem ipsum dolor sit amet onsectetur adipiscing Lorem ipsum",
        imgUrl:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSiXf0UWAyeyKc6aOhyxL6w6BPHU3kL5IsyNhvdpvydeqczunCSGA",
        date: "07.02.2019"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(language == eng
            ? "News"
            : language == rus ? "Новости" : "Yangilkilar"),
      ),
      body: SafeArea(
          child: RefreshIndicator(
        child: Container(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: newslist.length,
            itemBuilder: (context, index) {
              var news = newslist[index];
              return GestureDetector(
                child: Container(
                  width: 310.0,
                  height: 300.0,
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                  margin:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            blurRadius: 10.0,
                            color: Colors.black,
                            offset: Offset(0.5, 0.5))
                      ],
                      image: DecorationImage(
                          image: NetworkImage(news.imgUrl),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.black45, BlendMode.darken))),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        news.title,
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewsMorePage(
                                title: news.title,
                                news: news.news,
                                imageurl: news.imgUrl,
                                date: news.date,
                              )));
                },
              );
            },
          ),
        ),
        onRefresh: refreshData,
      )),
    );
  }
}
