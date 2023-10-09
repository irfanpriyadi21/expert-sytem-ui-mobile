class ModelListDiagnosa {
  int? id;
  String? diagnosaId;
  String? dataDiagnosa;
  String? kondisi;
  String? createdAt;
  String? updatedAt;

  ModelListDiagnosa(
      {this.id,
        this.diagnosaId,
        this.dataDiagnosa,
        this.kondisi,
        this.createdAt,
        this.updatedAt});

  ModelListDiagnosa.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    diagnosaId = json['diagnosa_id'];
    dataDiagnosa = json['data_diagnosa'];
    kondisi = json['kondisi'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['diagnosa_id'] = this.diagnosaId;
    data['data_diagnosa'] = this.dataDiagnosa;
    data['kondisi'] = this.kondisi;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
