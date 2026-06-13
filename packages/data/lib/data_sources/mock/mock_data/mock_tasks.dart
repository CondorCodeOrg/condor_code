import 'package:data/data_sources/remote/models/task_answer_remote.dart';
import 'package:data/data_sources/remote/models/task_remote.dart';

/// Lesson '1' (Створення проекту) intentionally has no tasks — intro/theory lesson.
/// Tasks are assigned to lessons '2' through '6'.
final mockTasks = <String, TaskRemote>{
  // ── Lesson 2 · Змінні та типи даних ───────────────────────
  '2-1': TaskRemote(
    id: '2-1',
    lessonId: '2',
    title: 'Task 1. Змінні. Введення',
    mediaUrl: '',
    listImages: [],
    description: '''
# Завдання 1. Змінні — Введення

Створіть програму, яка оголошує змінні різних типів та виводить їх у консоль.

## Вимоги

- Оголосіть змінну типу `String` з вашим ім'ям
- Оголосіть змінну типу `int` з вашим віком
- Оголосіть змінну типу `double` з вашим зростом
- Виведіть усі змінні у консоль

```dart
void main() {
  // Ваш код тут...
}
```
''',
    answer: TaskAnswerRemote(
      title: 'Відповідь: Змінні. Введення',
      mediaUrl: '',
      listImages: [],
      description: '''
# Розв'язок

```dart
void main() {
  String name = 'Олег';
  int age = 25;
  double height = 1.82;
  print('Мене звати \$name, мені \$age років, мій зріст \$height м');
}
```
''',
    ),
  ),
  '2-2': TaskRemote(
    id: '2-2',
    lessonId: '2',
    title: 'Task 2. Змінні. Калькулятор',
    mediaUrl: '',
    listImages: [],
    description: '''
# Завдання 2. Змінні — Калькулятор

Напишіть програму-калькулятор, яка виконує базові арифметичні операції.

## Вимоги

1. Оголосіть дві числові змінні
2. Обчисліть суму, різницю, добуток та частку
3. Виведіть результати у форматованому вигляді

```dart
void main() {
  int a = 15;
  int b = 4;
  // Ваш код тут...
}
```
''',
    answer: TaskAnswerRemote(
      title: 'Відповідь: Калькулятор',
      mediaUrl: '',
      listImages: [],
      description: '''
# Розв'язок

```dart
void main() {
  int a = 15;
  int b = 4;
  print('\$a + \$b = \${a + b}');
  print('\$a - \$b = \${a - b}');
  print('\$a * \$b = \${a * b}');
  print('\$a / \$b = \${a / b}');
}
```
''',
    ),
  ),
  '2-3': TaskRemote(
    id: '2-3',
    lessonId: '2',
    title: 'Task 3. Змінні. Апка кафе',
    mediaUrl: '',
    listImages: [],
    description: '''
# Завдання 3. Змінні — Апка кафе

Створіть модель даних для кав'ярні: напої, ціни та замовлення.

## Вимоги

- Створіть змінні для назви напою, ціни та кількості
- Обчисліть загальну вартість замовлення
- Виведіть чек у консоль

## Приклад виводу

```
☕ Замовлення:
Лате x3 = 210.0 грн
```
''',
    answer: TaskAnswerRemote(
      title: 'Відповідь: Апка кафе',
      mediaUrl: '',
      listImages: [],
      description: '''
# Розв'язок

```dart
void main() {
  String drink = 'Лате';
  double price = 70.0;
  int quantity = 3;
  double total = price * quantity;
  print('☕ Замовлення:');
  print('\$drink x\$quantity = \$total грн');
}
```
''',
    ),
  ),

  // ── Lesson 3 · Умови та цикли ─────────────────────────────
  '3-1': TaskRemote(
    id: '3-1',
    lessonId: '3',
    title: 'Task 1. Умови. Парне чи непарне',
    mediaUrl: '',
    listImages: [],
    description: '''
# Завдання 1. Умови — Парне чи непарне

Напишіть програму, яка перевіряє, чи є число парним чи непарним.

## Вимоги

- Оголосіть змінну `int number`
- Використайте `if/else` для перевірки `number % 2 == 0`
- Виведіть результат у консоль

```dart
void main() {
  int number = 7;
  // Ваш код тут...
}
```
''',
    answer: TaskAnswerRemote(
      title: 'Відповідь: Парне чи непарне',
      mediaUrl: '',
      listImages: [],
      description: '''
# Розв'язок

```dart
void main() {
  int number = 7;
  if (number % 2 == 0) {
    print('\$number — парне');
  } else {
    print('\$number — непарне');
  }
}
```
''',
    ),
  ),
  '3-2': TaskRemote(
    id: '3-2',
    lessonId: '3',
    title: 'Task 2. Цикли. Таблиця множення',
    mediaUrl: '',
    listImages: [],
    description: '''
# Завдання 2. Цикли — Таблиця множення

Виведіть таблицю множення на 5 за допомогою циклу `for`.

## Вимоги

- Використайте цикл `for` від 1 до 10
- Виведіть `5 * i = результат`

```dart
void main() {
  // Ваш код тут...
}
```
''',
    answer: TaskAnswerRemote(
      title: 'Відповідь: Таблиця множення',
      mediaUrl: '',
      listImages: [],
      description: '''
# Розв'язок

```dart
void main() {
  for (int i = 1; i <= 10; i++) {
    print('5 * \$i = \${5 * i}');
  }
}
```
''',
    ),
  ),
  '3-3': TaskRemote(
    id: '3-3',
    lessonId: '3',
    title: 'Task 3. Switch. Дні тижня',
    mediaUrl: '',
    listImages: [],
    description: '''
# Завдання 3. Switch — Дні тижня

Напишіть програму, яка за номером дня (1–7) виводить його назву.

## Вимоги

- Оголосіть змінну `int day`
- Використайте `switch` для виводу назви дня
- Обробіть невірний ввід через `default`

```dart
void main() {
  int day = 3;
  // Ваш код тут...
}
```
''',
    answer: TaskAnswerRemote(
      title: 'Відповідь: Дні тижня',
      mediaUrl: '',
      listImages: [],
      description: '''
# Розв'язок

```dart
void main() {
  int day = 3;
  switch (day) {
    case 1:
      print('Понеділок');
    case 2:
      print('Вівторок');
    case 3:
      print('Середа');
    case 4:
      print('Четвер');
    case 5:
      print("П'ятниця");
    case 6:
      print('Субота');
    case 7:
      print('Неділя');
    default:
      print('Невірний день');
  }
}
```
''',
    ),
  ),

  // ── Lesson 4 · Функції та параметри ───────────────────────
  '4-1': TaskRemote(
    id: '4-1',
    lessonId: '4',
    title: 'Task 1. Функції. Привітання',
    mediaUrl: '',
    listImages: [],
    description: '''
# Завдання 1. Функції — Привітання

Створіть функцію `greet`, яка приймає ім'я та виводить привітання.

## Вимоги

- Функція приймає `String name`
- Повертає `String` з текстом привітання
- Викличте функцію у `main`

```dart
void main() {
  // Ваш код тут...
}
```
''',
    answer: TaskAnswerRemote(
      title: 'Відповідь: Привітання',
      mediaUrl: '',
      listImages: [],
      description: '''
# Розв'язок

```dart
String greet(String name) {
  return 'Привіт, \$name!';
}

void main() {
  print(greet('Олег'));
}
```
''',
    ),
  ),
  '4-2': TaskRemote(
    id: '4-2',
    lessonId: '4',
    title: 'Task 2. Функції. Іменовані параметри',
    mediaUrl: '',
    listImages: [],
    description: '''
# Завдання 2. Функції — Іменовані параметри

Створіть функцію `createUser` з іменованими параметрами.

## Вимоги

- Використайте `{required String name, required int age}`
- Функція повертає опис користувача
- Передайте аргументи у довільному порядку

```dart
void main() {
  // Ваш код тут...
}
```
''',
    answer: TaskAnswerRemote(
      title: 'Відповідь: Іменовані параметри',
      mediaUrl: '',
      listImages: [],
      description: '''
# Розв'язок

```dart
String createUser({required String name, required int age}) {
  return 'Користувач: \$name, \$age років';
}

void main() {
  print(createUser(age: 25, name: 'Олег'));
}
```
''',
    ),
  ),
  '4-3': TaskRemote(
    id: '4-3',
    lessonId: '4',
    title: 'Task 3. Функції. Arrow-функція',
    mediaUrl: '',
    listImages: [],
    description: '''
# Завдання 3. Функції — Arrow-функція

Перепишіть функцію обчислення площі прямокутника у стилі arrow.

## Вимоги

- Використайте синтаксис `=>`
- Функція приймає `width` та `height`
- Повертає добуток

```dart
void main() {
  // Ваш код тут...
}
```
''',
    answer: TaskAnswerRemote(
      title: 'Відповідь: Arrow-функція',
      mediaUrl: '',
      listImages: [],
      description: '''
# Розв'язок

```dart
double area(double width, double height) => width * height;

void main() {
  print(area(4, 5)); // 20.0
}
```
''',
    ),
  ),

  // ── Lesson 5 · Колекції ───────────────────────────────────
  '5-1': TaskRemote(
    id: '5-1',
    lessonId: '5',
    title: 'Task 1. List. Список покупок',
    mediaUrl: '',
    listImages: [],
    description: '''
# Завдання 1. List — Список покупок

Створіть список покупок, додайте елементи та виведіть їх.

## Вимоги

- Створіть `List<String> items`
- Додайте 3 товари через `add`
- Виведіть кожен товар у циклі `for`

```dart
void main() {
  // Ваш код тут...
}
```
''',
    answer: TaskAnswerRemote(
      title: 'Відповідь: Список покупок',
      mediaUrl: '',
      listImages: [],
      description: '''
# Розв'язок

```dart
void main() {
  final items = <String>[];
  items.add('Молоко');
  items.add('Хліб');
  items.add('Яйця');

  for (final item in items) {
    print('• \$item');
  }
}
```
''',
    ),
  ),
  '5-2': TaskRemote(
    id: '5-2',
    lessonId: '5',
    title: 'Task 2. Map. Телефонна книга',
    mediaUrl: '',
    listImages: [],
    description: '''
# Завдання 2. Map — Телефонна книга

Створіть `Map<String, String>` для зберігання імен та телефонів.

## Вимоги

- Додайте 3 контакти
- Виведіть номер за ім'ям
- Перевірте, чи існує контакт через `containsKey`

```dart
void main() {
  // Ваш код тут...
}
```
''',
    answer: TaskAnswerRemote(
      title: 'Відповідь: Телефонна книга',
      mediaUrl: '',
      listImages: [],
      description: '''
# Розв'язок

```dart
void main() {
  final phoneBook = {
    'Олег': '+380991234567',
    'Анна': '+380997654321',
    'Іван': '+380995556677',
  };

  print(phoneBook['Олег']);
  print(phoneBook.containsKey('Анна')); // true
}
```
''',
    ),
  ),
  '5-3': TaskRemote(
    id: '5-3',
    lessonId: '5',
    title: 'Task 3. Set. Унікальні теги',
    mediaUrl: '',
    listImages: [],
    description: '''
# Завдання 3. Set — Унікальні теги

Видаліть дублікати зі списку тегів за допомогою `Set`.

## Вимоги

- Створіть `List<String>` з дублікатами
- Конвертуйте у `Set` і назад у `List`
- Виведіть унікальні теги

```dart
void main() {
  // Ваш код тут...
}
```
''',
    answer: TaskAnswerRemote(
      title: 'Відповідь: Унікальні теги',
      mediaUrl: '',
      listImages: [],
      description: '''
# Розв'язок

```dart
void main() {
  final tags = ['dart', 'flutter', 'dart', 'mobile', 'flutter'];
  final uniqueTags = tags.toSet().toList();
  print(uniqueTags); // [dart, flutter, mobile]
}
```
''',
    ),
  ),

  // ── Lesson 6 · ООП ────────────────────────────────────────
  '6-1': TaskRemote(
    id: '6-1',
    lessonId: '6',
    title: 'Task 1. ООП. Клас Person',
    mediaUrl: '',
    listImages: [],
    description: '''
# Завдання 1. ООП — Клас Person

Створіть клас `Person` з полями `name` та `age` та методом `introduce`.

## Вимоги

- Використайте конструктор з позиційними параметрами
- Метод `introduce` виводить текст у консоль
- Створіть об'єкт і викличте метод

```dart
void main() {
  // Ваш код тут...
}
```
''',
    answer: TaskAnswerRemote(
      title: 'Відповідь: Клас Person',
      mediaUrl: '',
      listImages: [],
      description: '''
# Розв'язок

```dart
class Person {
  String name;
  int age;

  Person(this.name, this.age);

  void introduce() {
    print('Привіт, я \$name, мені \$age років');
  }
}

void main() {
  final person = Person('Олег', 25);
  person.introduce();
}
```
''',
    ),
  ),
  '6-2': TaskRemote(
    id: '6-2',
    lessonId: '6',
    title: 'Task 2. ООП. Іменований конструктор',
    mediaUrl: '',
    listImages: [],
    description: '''
# Завдання 2. ООП — Іменований конструктор

Додайте до класу `Book` іменований конструктор `Book.anonymous()`.

## Вимоги

- Основний конструктор приймає `title` та `author`
- `Book.anonymous()` створює книгу з автором "Невідомий"
- Виведіть дані книги

```dart
void main() {
  // Ваш код тут...
}
```
''',
    answer: TaskAnswerRemote(
      title: 'Відповідь: Іменований конструктор',
      mediaUrl: '',
      listImages: [],
      description: '''
# Розв'язок

```dart
class Book {
  String title;
  String author;

  Book(this.title, this.author);

  Book.anonymous(this.title) : author = 'Невідомий';

  void describe() {
    print('«\$title» — \$author');
  }
}

void main() {
  final book = Book.anonymous('Старий та море');
  book.describe();
}
```
''',
    ),
  ),
  '6-3': TaskRemote(
    id: '6-3',
    lessonId: '6',
    title: 'Task 3. ООП. Наслідування',
    mediaUrl: '',
    listImages: [],
    description: '''
# Завдання 3. ООП — Наслідування

Створіть клас `Animal` та похідний клас `Dog` з перевизначеним методом.

## Вимоги

- `Animal` має метод `makeSound()`, який виводить "Тихо..."
- `Dog extends Animal` перевизначає `makeSound()` на "Гав!"
- Створіть об'єкт `Dog` і викличте метод

```dart
void main() {
  // Ваш код тут...
}
```
''',
    answer: TaskAnswerRemote(
      title: 'Відповідь: Наслідування',
      mediaUrl: '',
      listImages: [],
      description: '''
# Розв'язок

```dart
class Animal {
  void makeSound() => print('Тихо...');
}

class Dog extends Animal {
  @override
  void makeSound() => print('Гав!');
}

void main() {
  final dog = Dog();
  dog.makeSound(); // Гав!
}
```
''',
    ),
  ),
};
