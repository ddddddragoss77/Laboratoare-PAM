import 'package:equatable/equatable.dart';

class HeaderNotification extends Equatable {
  final bool hasUnread;
  final String iconUrl;

  const HeaderNotification({
    required this.hasUnread,
    required this.iconUrl,
  });

  factory HeaderNotification.fromJson(Map<String, dynamic> json) {
    return HeaderNotification(
      hasUnread: json['hasUnread'] ?? false,
      iconUrl: json['iconUrl'] ?? '',
    );
  }

  @override
  List<Object?> get props => [hasUnread, iconUrl];
}

class HeaderModel extends Equatable {
  final String date;
  final String greeting;
  final HeaderNotification notification;

  const HeaderModel({
    required this.date,
    required this.greeting,
    required this.notification,
  });

  factory HeaderModel.fromJson(Map<String, dynamic> json) {
    return HeaderModel(
      date: json['date'] ?? '',
      greeting: json['greeting'] ?? '',
      notification: HeaderNotification.fromJson(json['notification'] ?? {}),
    );
  }

  @override
  List<Object?> get props => [date, greeting, notification];
}
