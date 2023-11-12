class ChatContactModel {
  final String name;
  final String profilePic;
  final String contactId;
  final DateTime timeSent;
  final String lastMessage;

  ChatContactModel({
    required this.name,
    required this.profilePic,
    required this.contactId,
    required this.timeSent,
    required this.lastMessage,
  });

  factory ChatContactModel.fromMap(Map<String, dynamic> map) {
    return ChatContactModel(
      name: map['name'],
      profilePic: map['profilePic'],
      contactId: map['contactId'],
      timeSent: map['timeSent'],
      lastMessage: map['lastMessage'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profilePic': profilePic,
      'contactId': contactId,
      'timeSent': timeSent,
      'lastMessage': lastMessage,
    };
  }

  ChatContactModel copyWith({
    String? name,
    String? profilePic,
    String? contactId,
    DateTime? timeSent,
    String? lastMessage,
  }) {
    return ChatContactModel(
      name: name ?? this.name,
      profilePic: profilePic ?? this.profilePic,
      contactId: contactId ?? this.contactId,
      timeSent: timeSent ?? this.timeSent,
      lastMessage: lastMessage ?? this.lastMessage,
    );
  }

  
}
