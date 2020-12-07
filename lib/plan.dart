class Plan {
  final int id;
  final String fromICAO;
  final String toICAO;
  final String fromName;
  final String toName;
  final int downloads;

  Plan(
      {this.id,
      this.fromICAO,
      this.toICAO,
      this.fromName,
      this.toName,
      this.downloads});

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      id: json['id'] as int,
      fromICAO: json['fromICAO'] as String,
      toICAO: json['toICAO'] as String,
      fromName: json['fromName'] as String,
      toName: json['toName'] as String,
      downloads: json['downloads'] as int,
    );
  }
}
