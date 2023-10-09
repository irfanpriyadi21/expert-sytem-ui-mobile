class ModelListGejala {
  int? id;
  String? kodeGejala;
  String? gejala;
  String? createdAt;
  String? updatedAt;
  String? updatedBy;
  String? createdBy;

  ModelListGejala(
      {this.id,
        this.kodeGejala,
        this.gejala,
        this.createdAt,
        this.updatedAt,
        this.updatedBy,
        this.createdBy});

  ModelListGejala.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kodeGejala = json['kode_gejala'];
    gejala = json['gejala'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    updatedBy = json['updated_by'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kode_gejala'] = this.kodeGejala;
    data['gejala'] = this.gejala;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['updated_by'] = this.updatedBy;
    data['created_by'] = this.createdBy;
    return data;
  }
}
