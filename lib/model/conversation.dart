class ConversationModel {
  String? id;
  String? targetId;
  String? sourceId;
  List<String>? messagesList;

  ConversationModel({
    this.id,
    this.targetId,
    this.sourceId,
    this.messagesList,
  });

  ConversationModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'] as String;
    targetId = json['targetId'] as String;
    sourceId = json['sourceId'] as String;
    messagesList = List.from(json['messagesList']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['targetId'] = targetId;
    data['sourceId'] = sourceId;
    data['messagesList'] = messagesList;

    return data;
  }
}
