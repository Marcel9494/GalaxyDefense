class Player {
  final int id;
  final String createdAt;
  final int gainedXp;
  final int playerLevel;
  int coveringLevel;
  final int availableCredits;
  final int availableBeskar;

  Player({
    required this.id,
    required this.createdAt,
    required this.gainedXp,
    required this.playerLevel,
    required this.coveringLevel,
    required this.availableCredits,
    required this.availableBeskar,
  });

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      id: map['id'],
      createdAt: map['created_at'],
      gainedXp: map['gained_xp'],
      playerLevel: map['player_level'],
      coveringLevel: map['covering_level'],
      availableCredits: map['available_credits'],
      availableBeskar: map['available_beskar'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt,
      'gained_xp': gainedXp,
      'player_level': playerLevel,
      'covering_level': coveringLevel,
      'available_credits': availableCredits,
      'available_beskar': availableBeskar,
    };
  }
}
