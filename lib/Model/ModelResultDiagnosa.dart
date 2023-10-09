class ModelResultDiagnosa {
  int? code;
  String? icon;
  String? status;
  String? message;
  Results? results;

  ModelResultDiagnosa(
      {this.code, this.icon, this.status, this.message, this.results});

  ModelResultDiagnosa.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    icon = json['icon'];
    status = json['status'];
    message = json['message'];
    results =
    json['results'] != null ? new Results.fromJson(json['results']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['icon'] = this.icon;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.results != null) {
      data['results'] = this.results!.toJson();
    }
    return data;
  }
}

class Results {
  Diagnosa? diagnosa;
  DiagnosaDipilih? diagnosaDipilih;
  List<DataDiagnosa>? dataDiagnosa;
  List<Pakar>? pakar;
  DataDiagnosa? hasil;
  List<Artikel>? artikel;

  Results(
      {this.diagnosa,
        this.diagnosaDipilih,
        this.dataDiagnosa,
        this.pakar,
        this.hasil,
        this.artikel});

  Results.fromJson(Map<String, dynamic> json) {
    diagnosa = json['diagnosa'] != null
        ? new Diagnosa.fromJson(json['diagnosa'])
        : null;
    diagnosaDipilih = json['diagnosa_dipilih'] != null
        ? new DiagnosaDipilih.fromJson(json['diagnosa_dipilih'])
        : null;
    if (json['data_diagnosa'] != null) {
      dataDiagnosa = <DataDiagnosa>[];
      json['data_diagnosa'].forEach((v) {
        dataDiagnosa!.add(new DataDiagnosa.fromJson(v));
      });
    }
    if (json['pakar'] != null) {
      pakar = <Pakar>[];
      json['pakar'].forEach((v) {
        pakar!.add(new Pakar.fromJson(v));
      });
    }
    hasil =
    json['hasil'] != null ? new DataDiagnosa.fromJson(json['hasil']) : null;
    if (json['artikel'] != null) {
      artikel = <Artikel>[];
      json['artikel'].forEach((v) {
        artikel!.add(new Artikel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.diagnosa != null) {
      data['diagnosa'] = this.diagnosa!.toJson();
    }
    if (this.diagnosaDipilih != null) {
      data['diagnosa_dipilih'] = this.diagnosaDipilih!.toJson();
    }
    if (this.dataDiagnosa != null) {
      data['data_diagnosa'] =
          this.dataDiagnosa!.map((v) => v.toJson()).toList();
    }
    if (this.pakar != null) {
      data['pakar'] = this.pakar!.map((v) => v.toJson()).toList();
    }
    if (this.hasil != null) {
      data['hasil'] = this.hasil!.toJson();
    }
    if (this.artikel != null) {
      data['artikel'] = this.artikel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Diagnosa {
  int? id;
  String? diagnosaId;
  String? dataDiagnosa;
  String? kondisi;
  String? createdAt;
  String? updatedAt;
  int? createdBy;
  int? updatedBy;

  Diagnosa(
      {this.id,
        this.diagnosaId,
        this.dataDiagnosa,
        this.kondisi,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.updatedBy});

  Diagnosa.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    diagnosaId = json['diagnosa_id'];
    dataDiagnosa = json['data_diagnosa'];
    kondisi = json['kondisi'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['diagnosa_id'] = this.diagnosaId;
    data['data_diagnosa'] = this.dataDiagnosa;
    data['kondisi'] = this.kondisi;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    return data;
  }
}

class DiagnosaDipilih {
  double? value;
  KodeDepresi? kodeDepresi;

  DiagnosaDipilih({this.value, this.kodeDepresi});

  DiagnosaDipilih.fromJson(Map<String, dynamic> json) {
    value = double.parse("${json['value']}");
    kodeDepresi = json['kode_depresi'] != null
        ? new KodeDepresi.fromJson(json['kode_depresi'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    if (this.kodeDepresi != null) {
      data['kode_depresi'] = this.kodeDepresi!.toJson();
    }
    return data;
  }
}

class KodeDepresi {
  int? id;
  String? kodeDepresi;
  String? depresi;
  String? createdAt;
  String? updatedAt;
  int? createdBy;
  int? updatedBy;

  KodeDepresi(
      {this.id,
        this.kodeDepresi,
        this.depresi,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.updatedBy});

  KodeDepresi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kodeDepresi = json['kode_depresi'];
    depresi = json['depresi'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kode_depresi'] = this.kodeDepresi;
    data['depresi'] = this.depresi;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    return data;
  }
}

class DataDiagnosa {
  String? value;
  String? kodeDepresi;

  DataDiagnosa({this.value, this.kodeDepresi});

  DataDiagnosa.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    kodeDepresi = json['kode_depresi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['kode_depresi'] = this.kodeDepresi;
    return data;
  }
}

class Pakar {
  int? id;
  String? kodeGejala;
  String? kodeDepresi;
  double? mb;
  double? md;
  String? createdAt;
  String? updatedAt;

  Pakar(
      {this.id,
        this.kodeGejala,
        this.kodeDepresi,
        this.mb,
        this.md,
        this.createdAt,
        this.updatedAt});

  Pakar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kodeGejala = json['kode_gejala'];
    kodeDepresi = json['kode_depresi'];
    mb = double.parse("${json['mb']}");
    md = double.parse("${json['md']}");
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kode_gejala'] = this.kodeGejala;
    data['kode_depresi'] = this.kodeDepresi;
    data['mb'] = this.mb;
    data['md'] = this.md;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Artikel {
  int? id;
  String? slug;
  String? title;
  String? image;
  String? kodeDepresi;
  String? content;
  String? publishDate;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? updatedBy;
  String? createdBy;

  Artikel(
      {this.id,
        this.slug,
        this.title,
        this.image,
        this.kodeDepresi,
        this.content,
        this.publishDate,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.updatedBy,
        this.createdBy});

  Artikel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    title = json['title'];
    image = json['image'];
    kodeDepresi = json['kode_depresi'];
    content = json['content'];
    publishDate = json['publish_date'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    updatedBy = json['updated_by'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['title'] = this.title;
    data['image'] = this.image;
    data['kode_depresi'] = this.kodeDepresi;
    data['content'] = this.content;
    data['publish_date'] = this.publishDate;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['updated_by'] = this.updatedBy;
    data['created_by'] = this.createdBy;
    return data;
  }
}
