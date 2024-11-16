class ReaderModel {
  final int id;
  final Reciter reciter;
  final Rewaya rewaya;
  final String server;

  ReaderModel({
    required this.id,
    required this.reciter,
    required this.rewaya,
    required this.server,
  });

  factory ReaderModel.fromJson(Map<String, dynamic> json) {
    return ReaderModel(
      id: json["id"],
      reciter: Reciter.fromJson(json["reciter"]),
      rewaya: Rewaya.fromJson(json["rewaya"]),
      server: json["server"],
    );
  }
}

class Reciter {
  final String ar;
  final String en;

  Reciter({
    required this.ar,
    required this.en,
  });

  factory Reciter.fromJson(Map<String, dynamic> json) {
    return Reciter(
      ar: json["ar"],
      en: json["en"],
    );
  }
}

class Rewaya {
  final String ar;
  final String en;

  Rewaya({
    required this.ar,
    required this.en,
  });

  factory Rewaya.fromJson(Map<String, dynamic> json) {
    return Rewaya(
      ar: json["ar"],
      en: json["en"],
    );
  }
}
