import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qoute_generator/Apis/QuotesModel.dart';
import 'package:qoute_generator/Apis/fetch_Quotes.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Apis/fetch_Quotes.dart';


class QuoteScreen extends StatefulWidget {
  @override
  _QuoteScreenState createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  List<QuotesApi> quotesList = [];
  QuotesApi? currentQuote;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchQuotes().processData();
    FetchQuotes();
  }

  void _copyQuote() {
    if (currentQuote != null) {
      final String quoteText = '"${currentQuote!.quote}" - ${currentQuote!.author ?? 'Unknown'}';
      Clipboard.setData(ClipboardData(text: quoteText));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Quote copied to clipboard!')),
      );
    }
  }

  Future<void> FetchQuotes() async {
    fetchQuotes FetchQuotes = fetchQuotes();
    await FetchQuotes.processData();
    setState(() {
      quotesList = FetchQuotes.quoteList;
      currentQuote = quotesList.isNotEmpty ? quotesList[0] : null;
    });
  }
  void getNewQuote() {
    if (quotesList.isNotEmpty) {
      setState(() {
        FetchQuotes();
        currentQuote = quotesList[(quotesList.indexOf(currentQuote!) + 1) % quotesList.length];
      });
    }
  }

  void _shareQuote() {
    if (currentQuote != null) {
      final String quoteText = '"${currentQuote!.quote}" - ${currentQuote!.author ?? 'Unknown'}';
      Share.share(quoteText);
    }
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text("Quote Generator",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500),),
    centerTitle: true,)
    ,
    body: Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (currentQuote != null)
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        '" ${currentQuote!.quote} "',
                        style: TextStyle(
                          fontSize: 25,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        '- ${currentQuote!.author ?? 'Unknown'}',
                        style: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey[700],
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: getNewQuote,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text(
                "New Quote",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: (){
                setState(() {
                  _copyQuote();
                });
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text(
                "Copy this Quote",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: (){
                setState(() {
                  _shareQuote();
                });
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text(
                "Share this Quote",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}