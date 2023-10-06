class ModelKondisiUser {
  int? id;
  String? kondisi;
  double? nilai;
  String? createdAt;
  String? updatedAt;
  String? updatedBy;
  String? createdBy;

  ModelKondisiUser(
      {this.id,
        this.kondisi,
        this.nilai,
        this.createdAt,
        this.updatedAt,
        this.updatedBy,
        this.createdBy});

  ModelKondisiUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kondisi = json['kondisi'];
    nilai = double.parse("${json['nilai']}");
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    updatedBy = json['updated_by'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kondisi'] = this.kondisi;
    data['nilai'] = this.nilai;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['updated_by'] = this.updatedBy;
    data['created_by'] = this.createdBy;
    return data;
  }
}
