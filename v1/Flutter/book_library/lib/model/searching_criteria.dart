class SearchingCriteria {
  String keyword;

  // construtor
  SearchingCriteria(this.keyword);

  SearchingCriteria.fromJson(Map<String, dynamic> json)
      : keyword = json['keyword'];

  Map<String, dynamic> toJson() => {
        'keyword': keyword,
      };
}
