import 'package:dart/gradebook.dart';
import 'package:dart/student.dart';
import 'package:test/test.dart';

void main() {
  group('GradeBook 统计', () {
    final book = GradeBook([
      Student(name: '小明', age: 18, score: 95),
      Student(name: '小红', age: 19, score: 85),
      Student(name: '小刚', age: 20, score: 70),
      Student(name: '小美', age: 21, score: 50),
    ]);

    test('正常数据：平均分/最高分/及格人数/分档统计均正确', () {
      expect(book.average(), closeTo(75.0, 0.001));
      expect(book.maxBy()!.name, '小明');
      expect(book.countPassed(), 3);

      final grouped = book.groupByGrade();
      expect(grouped['优']!.length, 1);
      expect(grouped['良']!.length, 1);
      expect(grouped['中']!.length, 1);
      expect(grouped['不及格']!.length, 1);
    });

    test('空列表：平均分为 0、最高分为 null、及格人数为 0', () {
      final empty = GradeBook([]);
      expect(empty.average(), 0);
      expect(empty.maxBy(), isNull);
      expect(empty.countPassed(), 0);
      expect(empty.groupByGrade().keys, containsAll(['优', '良', '中', '不及格']));
    });
  });

  group('Student 校验', () {
    test('分数越界（>100 或 <0）抛出 ArgumentError', () {
      expect(
        () => Student(name: '越界', age: 18, score: 120),
        throwsArgumentError,
      );
      expect(
        () => Student(name: '越界', age: 18, score: -1),
        throwsArgumentError,
      );
    });
  });
}
