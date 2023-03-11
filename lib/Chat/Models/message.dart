class Message {
  //String sId;
  int? sourceId;
  int? targetId;
  String? message;
  String? createdAt;

  Message({
    this.sourceId,
    this.targetId,
    this.message,
    this.createdAt,
  });

  Message.fromJson(Map<String, dynamic> json) {
    //sId = json['_id'];
    sourceId = json['sourceId'] as int;
    targetId = json['targetId'] as int;
    message = json['message'] as String;
    createdAt = json['createdAt'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    //data['_id'] = this.sId;
    data['sourceId'] = sourceId;
    data['targetId'] = targetId;
    data['message'] = message;
    data['createdAt'] = createdAt;

    return data;
  }
}
