class PageModel {
  String? label;
  dynamic destination;

  PageModel({this.label, this.destination});

  PageModel.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    destination = json['destination'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['destination'] = destination;
    return data;
  }
}