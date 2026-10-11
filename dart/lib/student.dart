/// 学生类：演示命名构造函数、getter 与校验 setter。
class Student {
  String _name = '';
  int _age = 0;
  double _score = 0;

  Student({
    required String name,
    required int age,
    required double score,
  }) {
    // 通过 setter 赋值，统一走校验逻辑
    this.name = name;
    this.age = age;
    this.score = score;
  }

  /// 命名构造函数：从 JSON Map 创建学生，复用主构造函数的校验
  Student.fromJson(Map<String, dynamic> json)
      : this(
          name: json['name'] as String,
          age: (json['age'] as num).toInt(),
          score: (json['score'] as num).toDouble(),
        );

  String get name => _name;
  int get age => _age;
  double get score => _score;

  /// 姓名：不允许空白
  set name(String value) {
    if (value.trim().isEmpty) {
      throw ArgumentError('姓名不能为空');
    }
    _name = value;
  }

  /// 年龄：限定 0~150
  set age(int value) {
    if (value < 0 || value > 150) {
      throw ArgumentError('年龄必须在 0~150 之间，收到: $value');
    }
    _age = value;
  }

  /// 成绩：限定 0~100
  set score(double value) {
    if (value < 0 || value > 100) {
      throw ArgumentError('成绩必须在 0~100 之间，收到: $value');
    }
    _score = value;
  }
}
