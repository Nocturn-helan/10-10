# dart

一个命令行 Dart 示例工程：`lib/` 存放库代码，`test/` 存放单元测试，`bin/` 为入口。

## 结构

- `lib/student.dart` — `Student` 类：私有字段封装、命名构造 `fromJson`、校验 setter
- `lib/logger.dart` — `mixin Logger`：以混入方式提供日志能力（替代一层继承）
- `lib/gradebook.dart` — `GradeBook with Logger`：链式集合统计
- `test/gradebook_test.dart` — 单元测试（正常路径 + 异常路径）

## AI 使用标注

本工程在 AI（TraeCode 助手）辅助下完成，具体分工如下：

| 文件 | AI 参与内容 | 人工确认/调整 |
| --- | --- | --- |
| `lib/student.dart` | AI 起草 `Student` 类骨架（字段、getter、校验 setter、`fromJson`） | 人工核对校验范围（年龄 0~150、成绩 0~100）与命名 |
| `lib/logger.dart` | AI 起草 `mixin Logger` 及"为何用混入替代继承"的说明注释 | 人工确认改造理由与措辞 |
| `lib/gradebook.dart` | AI 实现 `average`/`maxBy`/`countPassed`/`groupByGrade`/`passedTierSummary` 的链式集合写法 | 人工确认"禁止 for 循环"约束与分档边界（60/80/90） |
| `test/gradebook_test.dart` | AI 生成测试用例骨架 | 人工确认正常/异常路径覆盖 |
| `README.md` | AI 生成本说明 | 人工核对 |

说明：以上代码均由 AI 生成初稿，经人工审阅、运行 `dart analyze` 与 `dart test` 验证后定稿。

## 运行

```bash
dart analyze
dart test
```
