class NotificationSettings {
  bool generalNotification;
  bool sound;
  bool vibrate;
  bool specialOffers;
  bool promoDiscount;
  bool payments;
  bool appUpdates;

  NotificationSettings({
    required this.generalNotification,
    required this.sound,
    required this.vibrate,
    required this.specialOffers,
    required this.promoDiscount,
    required this.payments,
    required this.appUpdates,
  });

  NotificationSettings copyWith({
    bool? generalNotification,
    bool? sound,
    bool? vibrate,
    bool? specialOffers,
    bool? promoDiscount,
    bool? payments,
    bool? appUpdates,
  }) {
    return NotificationSettings(
      generalNotification: generalNotification ?? this.generalNotification,
      sound: sound ?? this.sound,
      vibrate: vibrate ?? this.vibrate,
      specialOffers: specialOffers ?? this.specialOffers,
      promoDiscount: promoDiscount ?? this.promoDiscount,
      payments: payments ?? this.payments,
      appUpdates: appUpdates ?? this.appUpdates,
    );
  }
}
