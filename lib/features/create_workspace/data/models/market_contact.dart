class MarketContactModel {
  final String market;
  final String firstMobileNumber;
  final String secondMobileNumber;
  final String telephone;
  final String fax;
  final String email;
  final String websiteUrl;
  final MessengerIds messengerIds;

  MarketContactModel({
    required this.market,
    required this.firstMobileNumber,
    required this.secondMobileNumber,
    required this.telephone,
    required this.fax,
    required this.email,
    required this.websiteUrl,
    required this.messengerIds,
  });

  factory MarketContactModel.fromJson(Map<String, dynamic> json) {
    return MarketContactModel(
      market: json['market'],
      firstMobileNumber: json['first_mobile_number'],
      secondMobileNumber: json['second_mobile_number'],
      telephone: json['telephone'],
      fax: json['fax'],
      email: json['email'],
      websiteUrl: json['website_url'],
      messengerIds: MessengerIds.fromJson(json['messenger_ids']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'market': market,
      'first_mobile_number': firstMobileNumber,
      'second_mobile_number': secondMobileNumber,
      'telephone': telephone,
      'fax': fax,
      'email': email,
      'website_url': websiteUrl,
      'messenger_ids': messengerIds.toJson(),
    };
  }
}

class MessengerIds {
  final String? telegram;
  final String? whatsapp;
  final String? instagram;
  final String? eita;
  final String? igap;
  final String? bale;
  final String? soroush;
  final String? rubika;

  MessengerIds({
    this.telegram,
    this.whatsapp,
    this.instagram,
    this.eita,
    this.bale,
    this.igap,
    this.rubika,
    this.soroush,
  });

  factory MessengerIds.fromJson(Map<String, dynamic> json) {
    return MessengerIds(
      telegram: json['telegram'] ?? "",
      whatsapp: json['whatsapp'] ?? "",
      instagram: json['instagram'] ?? "",
      eita: json['eita'] ?? "",
      bale: json['bale'] ?? "",
      igap: json['igap'] ?? "",
      rubika: json['rubika'] ?? "",
      soroush: json['soroush'] ?? "",
    );
  }
  factory MessengerIds.fromAnotherModel(MessengerIds newMess) {
    return MessengerIds(
      telegram: newMess.telegram,
      eita: newMess.eita,
      instagram: newMess.instagram,
      whatsapp: newMess.whatsapp,
      bale: newMess.bale,
      igap: newMess.igap,
      rubika: newMess.rubika,
      soroush: newMess.soroush,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'telegram': telegram,
      'whatsapp': whatsapp,
      'eita': eita,
      'instagram': instagram,
      'soroush': soroush,
      'rubika': rubika,
      'igap': igap,
      'bale': bale,
    };
  }
}

extension MessengerIdsCopy on MessengerIds {
  MessengerIds copyWith({
    String? telegram,
    String? whatsapp,
    String? instagram,
    String? eita,
    final String? igap,
    final String? bale,
    final String? soroush,
    final String? rubika,
  }) {
    return MessengerIds(
      telegram: telegram ?? this.telegram,
      whatsapp: whatsapp ?? this.whatsapp,
      instagram: instagram ?? this.instagram,
      eita: eita ?? this.eita,
      bale: bale ?? this.bale,
      igap: igap ?? this.igap,
      rubika: rubika ?? this.rubika,
      soroush: soroush ?? this.soroush,
    );
  }
}

extension MessengerIdsExtension on MessengerIds {
  MessengerIds copyWithByKey(String key, String value) {
    final Map<String, String?> updated = {
      'telegram': telegram,
      'whatsapp': whatsapp,
      'instagram': instagram,
      'eita': eita,
      'soroush': soroush,
      'rubika': rubika,
      'igap': igap,
      'bale': bale,
    };

    updated[key] = value; // مقدار جدید رو جایگزین کن

    return MessengerIds(
      telegram: updated['telegram'],
      whatsapp: updated['whatsapp'],
      instagram: updated['instagram'],
      eita: updated['eita'],
      bale: updated['bale'],
      igap: updated['igap'],
      rubika: updated['rubika'],
      soroush: updated['soroush'],
    );
  }
}
