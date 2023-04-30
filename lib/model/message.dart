class MessageModel {
  String? id;
  String? sourceId;
  String? targetId;
  String? message;
  String? createdAt;
  String? time;

  MessageModel(
      {this.id,
      this.sourceId,
      this.targetId,
      this.message,
      this.createdAt,
      this.time});

  MessageModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'] as String;
    sourceId = json['sourceId'] as String;
    targetId = json['targetId'] as String;
    message = json['message'] as String;
    createdAt = json['createdAt'] as String;
    time = json['time'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['sourceId'] = sourceId;
    data['targetId'] = targetId;
    data['message'] = message;
    data['createdAt'] = createdAt;
    data['time'] = time;

    return data;
  }
}
