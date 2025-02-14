class QuotesApi {
  String? quote;
  String? author;
  String? category;

  QuotesApi({this.quote, this.author, this.category});

  QuotesApi.fromJson(Map<String, dynamic> json) {
    quote = json['quote'];
    author = json['author'];
    category = json['category'];
  }
}
