class JobData {
  final String field;
  final int count;

  JobData({required this.field, required this.count});

  factory JobData.fromJson(Map<String, dynamic> json) {
    return JobData(
      field: json['field'],
      count: json['count'],
    );
  }
}