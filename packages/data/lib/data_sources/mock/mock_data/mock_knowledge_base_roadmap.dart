const mockKnowledgeBaseRoadmapJson = r'''
{
  "initiallyCollapsed": [
    "subtopic_async"
  ],
  "root": {
    "id": "root",
    "kind": "root",
    "title": "Dart Roadmap 2026",
    "subtitle": "Крок за кроком: віхи → підтеми → уроки",
    "descriptionMarkdown": "## Dart Roadmap 2026\n\nЦе головна карта навчання. Рухайся від віх до підтем і далі до конкретних практичних кроків.\n\n- Починай із базових тем\n- Закріплюй знання вправами\n- Переходь до складніших блоків тільки після практики",
    "accentHex": "#00B4AB",
    "children": [
      {
        "id": "milestone_basics",
        "kind": "milestone",
        "title": "Віха 1 · Основи мови",
        "subtitle": "Синтаксис, типи, оператори",
        "descriptionMarkdown": "## Віха 1 · Основи мови\n\nФундамент Dart, без якого важко рухатись далі.\n\n### Що важливо опанувати\n- базовий синтаксис\n- типи даних\n- оператори та вирази",
        "accentHex": "#D3F686",
        "children": [
          {
            "id": "subtopic_syntax",
            "kind": "subtopic",
            "title": "Синтаксис і типи",
            "subtitle": "Модуль під темою віхи",
            "descriptionMarkdown": "## Синтаксис і типи\n\nЦей модуль формує впевненість у базовому читанні та написанні Dart-коду.\n\n- оголошення змінних\n- базові типи\n- робота з операторами",
            "accentHex": "#C4E86A",
            "children": [
              {
                "id": "variables",
                "kind": "topic",
                "title": "Змінні та константи",
                "subtitle": "var, final, const",
                "descriptionMarkdown": "### Змінні та константи\n\nРозбери різницю між `var`, `final` та `const`, і коли кожен варіант доречний.\n\n```dart\nfinal name = 'Oleh';\nconst pi = 3.14;\n```",
                "accentHex": "#E8D44D"
              },
              {
                "id": "types",
                "kind": "topic",
                "title": "Вбудовані типи",
                "subtitle": "num, String, bool",
                "descriptionMarkdown": "### Вбудовані типи\n\nПознайомся з основними типами в Dart і їх типовим застосуванням.\n\n- `num`, `int`, `double`\n- `String`\n- `bool`",
                "accentHex": "#E8D44D"
              },
              {
                "id": "operators",
                "kind": "topic",
                "title": "Оператори",
                "subtitle": "Арифметика та логіка",
                "descriptionMarkdown": "### Оператори\n\nОпануй оператори, щоб впевнено писати умови та обчислення.\n\n- арифметичні\n- порівняння\n- логічні",
                "accentHex": "#E8D44D"
              }
            ]
          },
          {
            "id": "subtopic_control",
            "kind": "subtopic",
            "title": "Керування потоком",
            "subtitle": "Ще один рівень вкладеності",
            "descriptionMarkdown": "## Керування потоком\n\nКонтроль виконання програми через умови і цикли.\n\n- умовні конструкції\n- повторення коду в циклах",
            "accentHex": "#B8E050",
            "children": [
              {
                "id": "conditions",
                "kind": "topic",
                "title": "Умови",
                "subtitle": "if / switch / ?:",
                "descriptionMarkdown": "### Умови\n\nНавчись обирати правильну гілку виконання.\n\n- `if` / `else`\n- `switch`\n- тернарний оператор `?:`",
                "accentHex": "#F0E04A"
              },
              {
                "id": "loops",
                "kind": "topic",
                "title": "Цикли",
                "subtitle": "for, while",
                "descriptionMarkdown": "### Цикли\n\nПовторюй дії керовано та читабельно.\n\n- `for`\n- `while`\n- практичні кейси проходу по колекціях",
                "accentHex": "#F0E04A"
              }
            ]
          }
        ]
      },
      {
        "id": "milestone_data",
        "kind": "milestone",
        "title": "Віха 2 · Дані та ООП",
        "subtitle": "Колекції, класи, null safety",
        "descriptionMarkdown": "## Віха 2 · Дані та ООП\n\nТут формується системне мислення про моделі даних і структуру коду.\n\n- колекції\n- об'єкти та класи\n- null safety",
        "accentHex": "#6AB9FF",
        "children": [
          {
            "id": "subtopic_oop",
            "kind": "subtopic",
            "title": "ООП у Dart",
            "subtitle": "Класи та успадкування",
            "descriptionMarkdown": "## ООП у Dart\n\nПобудова чистих моделей, інкапсуляції та перевикористання коду.\n\n- класи\n- наслідування\n- композиція",
            "accentHex": "#F64848",
            "children": [
              {
                "id": "classes",
                "kind": "topic",
                "title": "Класи",
                "subtitle": "конструктори, factory",
                "descriptionMarkdown": "### Класи\n\nСтвори міцну основу для доменних моделей.\n\n- звичайні та іменовані конструктори\n- `factory` конструктори",
                "accentHex": "#FF6B6B"
              },
              {
                "id": "inheritance",
                "kind": "topic",
                "title": "Mixins & extends",
                "subtitle": "композиція поведінки",
                "descriptionMarkdown": "### Mixins & extends\n\nВибирай правильний спосіб повторного використання поведінки.\n\n- `extends`\n- `with` (mixins)\n- коли краще композиція",
                "accentHex": "#FF6B6B"
              },
              {
                "id": "null_safety",
                "kind": "topic",
                "title": "Null safety",
                "subtitle": "?, !, late",
                "descriptionMarkdown": "### Null safety\n\nПиши безпечний код без випадкових `null`-помилок.\n\n- nullable типи `?`\n- оператор `!`\n- `late` поля",
                "accentHex": "#FF6B6B"
              }
            ]
          },
          {
            "id": "subtopic_collections",
            "kind": "subtopic",
            "title": "Колекції",
            "subtitle": "List, Set, Map",
            "descriptionMarkdown": "## Колекції\n\nГнучка та ефективна робота з наборами даних.\n\n- списки\n- множини\n- словники",
            "accentHex": "#89C9FF",
            "children": [
              {
                "id": "lists",
                "kind": "topic",
                "title": "Lists",
                "subtitle": "spread, методи",
                "descriptionMarkdown": "### Lists\n\nРобота зі списками у повсякденних задачах Flutter-розробки.\n\n- `[]`, `add`, `map`, `where`\n- spread-оператор `...`",
                "accentHex": "#A8D9FF"
              },
              {
                "id": "maps_sets",
                "kind": "topic",
                "title": "Maps & Sets",
                "subtitle": "ключі та унікальність",
                "descriptionMarkdown": "### Maps & Sets\n\nОпануй ключ-значення та унікальні колекції.\n\n- `Map<K, V>`\n- `Set<T>`\n- типові помилки з ключами",
                "accentHex": "#A8D9FF"
              }
            ]
          }
        ]
      },
      {
        "id": "milestone_async",
        "kind": "milestone",
        "title": "Віха 3 · Асинхронність",
        "subtitle": "Future, Stream, ізоляція",
        "descriptionMarkdown": "## Віха 3 · Асинхронність\n\nЦе критично важливий блок для реального Flutter-додатку.\n\n- Future\n- Stream\n- керування конкурентністю",
        "accentHex": "#9B59B6",
        "children": [
          {
            "id": "subtopic_async",
            "kind": "subtopic",
            "title": "Async-модель",
            "subtitle": "Підтема з вкладеними темами",
            "descriptionMarkdown": "## Async-модель\n\nРозуміння того, як працює неблокуючий код у Dart.\n\n- event loop\n- `async` / `await`\n- стріми подій",
            "accentHex": "#AF7AC5",
            "children": [
              {
                "id": "futures",
                "kind": "topic",
                "title": "Futures",
                "subtitle": "async / await",
                "descriptionMarkdown": "### Futures\n\nОпис одного майбутнього результату асинхронної операції.\n\n```dart\nfinal user = await repo.loadUser();\n```",
                "accentHex": "#C39BD3"
              },
              {
                "id": "streams",
                "kind": "topic",
                "title": "Streams",
                "subtitle": "listen, async*",
                "descriptionMarkdown": "### Streams\n\nПотоки даних у часі: підходять для реактивних сценаріїв.\n\n- `listen`\n- `async*`\n- одноразові та broadcast-потоки",
                "accentHex": "#C39BD3"
              }
            ]
          }
        ]
      },
      {
        "id": "milestone_advanced",
        "kind": "milestone",
        "title": "Віха 4 · Просунутий Dart",
        "subtitle": "Generics, extensions, isolates",
        "descriptionMarkdown": "## Віха 4 · Просунутий Dart\n\nПоглиблення знань для масштабних та продуктивних застосунків.\n\n- generics\n- extensions\n- isolates",
        "accentHex": "#2ECC71",
        "children": [
          {
            "id": "subtopic_meta",
            "kind": "subtopic",
            "title": "Мета-програмування",
            "subtitle": "Останній рівень підтем",
            "descriptionMarkdown": "## Мета-програмування\n\nІнструменти для більш виразного і перевикористовуваного коду.\n\n- узагальнення типів\n- розширення API\n- паралельне виконання",
            "accentHex": "#58D68D",
            "children": [
              {
                "id": "generics",
                "kind": "topic",
                "title": "Generics",
                "subtitle": "обмеження типів",
                "descriptionMarkdown": "### Generics\n\nПиши універсальний і безпечний до типів код.\n\n- параметри типів\n- обмеження через `extends`",
                "accentHex": "#7DCEA0"
              },
              {
                "id": "extensions",
                "kind": "topic",
                "title": "Extensions",
                "subtitle": "методи на чужих типах",
                "descriptionMarkdown": "### Extensions\n\nДодавай зручні методи до існуючих типів без наслідування.\n\n- синтаксис `extension`\n- практичні utility-методи",
                "accentHex": "#7DCEA0"
              },
              {
                "id": "isolates",
                "kind": "topic",
                "title": "Isolates",
                "subtitle": "паралельні обчислення",
                "descriptionMarkdown": "### Isolates\n\nВинось важкі обчислення з UI-потоку для плавної роботи додатку.\n\n- ізольовані контексти\n- обмін повідомленнями",
                "accentHex": "#7DCEA0"
              }
            ]
          }
        ]
      }
    ]
  }
}
''';
