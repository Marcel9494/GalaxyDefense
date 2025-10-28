class Covering {
  final int level;
  final int coveringValue;
  final int upgradeCost;

  Covering({
    required this.level,
    required this.coveringValue,
    required this.upgradeCost,
  });

  factory Covering.fromMap(Map<String, dynamic> map) {
    return Covering(
      level: map['level'],
      coveringValue: map['coveringValue'],
      upgradeCost: map['upgradeCost'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'level': level,
      'coveringValue': coveringValue,
      'upgradeCost': upgradeCost,
    };
  }
}
