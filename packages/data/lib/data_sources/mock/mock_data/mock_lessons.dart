import 'package:data/data_sources/remote/models/lesson_remote.dart';

final mockLessons = <String, LessonRemote>{
  '1': LessonRemote(
    id: '1',
    sortOrder: 0,
    title: 'Створення проекту',
    topic: 'Ознайомлення',
    youtubeUrl: 'https://youtu.be/-SV_J5N9eQs?si=ERNeDRgUMAXdWvT5',
    description:
        'У цьому уроці ми створимо новий проект на Dart, налаштуємо середовище розробки та запустимо першу програму "Hello, World!".\n\n',
    isYouTubeLesson: true,
    courseId: '1',
  ),
  '2': LessonRemote(
    id: '2',
    sortOrder: 1,
    title: 'Змінні та типи даних',
    topic: 'Основи Dart',
    youtubeUrl: 'https://youtu.be/qWqlMi6aqFw?si=LIIgOsHy2HhRVnJx',
    description:
        'Змінні — це основа будь-якої програми. Вони зберігають дані, які можуть змінюватися під час виконання.\n\n'
        'У Dart змінні дозволяють працювати з текстом, числами, логікою та іншими типами даних. '
        'Розберемося з var, final та const — коли що використовувати. '
        'Дізнаємося про int, double, String, bool та dynamic.\n\n'
        'Наприкінці уроку ви зможете оголошувати змінні, розуміти різницю між типами '
        'та писати прості вирази на Dart.',
    isYouTubeLesson: true,
    courseId: '1',
  ),
  '3': LessonRemote(
    id: '3',
    sortOrder: 2,
    title: 'Умови та цикли',
    topic: 'Керування потоком',
    youtubeUrl: 'https://youtu.be/PyZK5xkxiSw?si=q0-eWGmK8FftYizM',
    description:
        'Умовні конструкції та цикли дозволяють програмі приймати рішення та повторювати дії.\n\n'
        'У цьому уроці ми розглянемо if/else, switch/case та тернарний оператор. '
        'Також вивчимо цикли for, while та do-while. '
        'Окрему увагу приділимо for-in для роботи з колекціями.\n\n'
        'Практичні приклади: валідація введення користувача, фільтрація списків, '
        'побудова простих текстових меню.',
    isYouTubeLesson: true,
    courseId: '1',
  ),
  '4': LessonRemote(
    id: '4',
    sortOrder: 3,
    title: 'Функції та параметри',
    topic: 'Функції',
    youtubeUrl: 'https://youtu.be/aFldvFfH0S8?si=dF8bSuJuj1OBxGCt',
    description:
        'Функції — це спосіб організувати код у логічні блоки, які можна перевикористовувати.\n\n'
        'Dart підтримує іменовані та позиційні параметри, значення за замовчуванням, '
        'required-параметри та анонімні функції (лямбди).\n\n'
        'У цьому уроці:\n'
        '• Як оголосити функцію та повернути результат\n'
        '• Різниця між positional та named параметрами\n'
        '• Arrow-функції для коротких виразів\n'
        '• Передача функцій як аргументів (callback)',
    isYouTubeLesson: true,
    courseId: '1',
  ),
  '5': LessonRemote(
    id: '5',
    sortOrder: 4,
    title: 'Колекції: List, Set, Map',
    topic: 'Структури даних',
    youtubeUrl: 'https://youtu.be/b_fay5noBUE?si=u2yJDYgkgTgSLU8l',
    description:
        'Колекції — це основні структури для зберігання та обробки груп даних у Dart.\n\n'
        'List — впорядкований список елементів. Підтримує індексацію, додавання, видалення, '
        'сортування та трансформацію через map/where/reduce.\n\n'
        'Set — множина унікальних елементів. Ідеально підходить для видалення дублікатів '
        'та перевірки належності.\n\n'
        'Map — словник пар ключ-значення. Використовується для конфігурацій, '
        'кешування та роботи з JSON.\n\n'
        'Також розглянемо spread-оператор (...), collection if та collection for.',
    isYouTubeLesson: true,
    courseId: '1',
  ),
  '6': LessonRemote(
    id: '6',
    sortOrder: 5,
    title: "ООП: Класи та об'єкти",
    topic: "Об'єктно-орієнтоване програмування",
    youtubeUrl: 'https://youtu.be/eCGFv3Qh9Aw?si=AaNV8y5Tdl2ff5Yn',
    description:
        "Об'єктно-орієнтоване програмування — це парадигма, яка дозволяє моделювати реальний світ у коді.\n\n"
        'У цьому уроці ми створимо свій перший клас, навчимося працювати з конструкторами '
        '(default, named, factory), інкапсуляцією через приватні поля та гетери/сетери.\n\n'
        'Теми уроку:\n'
        '• Оголошення класів та створення обʼєктів\n'
        '• Конструктори: звичайні, іменовані, factory\n'
        '• Наслідування (extends) та перевизначення методів\n'
        '• Mixins (with) — додавання поведінки без наслідування\n'
        '• Abstract класи та інтерфейси\n\n'
        'Після цього уроку ви зможете проектувати прості моделі даних для Flutter-додатків.',
    isYouTubeLesson: true,
    courseId: '1',
  ),
};
