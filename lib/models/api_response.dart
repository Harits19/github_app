class ApiResponse {
  int? totalCount;
  bool? incompleteResults;
  List<dynamic>? items;

  ApiResponse({
    this.totalCount,
    this.incompleteResults,
    this.items,
  });

  ApiResponse.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'] as int?;
    incompleteResults = json['incomplete_results'] as bool?;
    items = (json['items'] as List?)?.map((dynamic e) => e).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['total_count'] = totalCount;
    json['incomplete_results'] = incompleteResults;
    json['items'] = items?.map((e) => e.toJson()).toList();
    return json;
  }
}
