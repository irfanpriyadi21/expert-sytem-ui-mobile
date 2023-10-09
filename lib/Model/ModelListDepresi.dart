class ModelListDepresi {
  int? id;
  String? kodeDepresi;
  String? depresi;
  String? createdAt;
  String? updatedAt;
  String? updatedBy;
  String? createdBy;

  ModelListDepresi(
      {this.id,
        this.kodeDepresi,
        this.depresi,
        this.createdAt,
        this.updatedAt,
        this.updatedBy,
        this.createdBy});

  ModelListDepresi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kodeDepresi = json['kode_depresi'];
    depresi = json['depresi'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    updatedBy = json['updated_by'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kode_depresi'] = this.kodeDepresi;
    data['depresi'] = this.depresi;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['updated_by'] = this.updatedBy;
    data['created_by'] = this.createdBy;
    return data;
  }
}
