class SourcesResponseDM {
  String? status;
  List<SourceDM>? sources;
  String? message;
  String? code;

  SourcesResponseDM({this.status, this.sources, this.message, this.code});

  SourcesResponseDM.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    code = json['code'];
    if (json['sources'] != null) {
      sources = [];
      json['sources'].forEach((v) {
        sources?.add(SourceDM.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['code'] = code;
    if (sources != null) {
      map['sources'] = sources?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class SourceDM {
  SourceDM({
    this.id,
    this.name,
    this.description,
    this.url,
    this.category,
    this.language,
    this.country,
  });

  SourceDM.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    url = json['url'];
    category = json['category'];
    language = json['language'];
    country = json['country'];
  }
  String? id;
  String? name;
  String? description;
  String? url;
  String? category;
  String? language;
  String? country;
  SourceDM copyWith({
    String? id,
    String? name,
    String? description,
    String? url,
    String? category,
    String? language,
    String? country,
  }) => SourceDM(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    url: url ?? this.url,
    category: category ?? this.category,
    language: language ?? this.language,
    country: country ?? this.country,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['url'] = url;
    map['category'] = category;
    map['language'] = language;
    map['country'] = country;
    return map;
  }
}
