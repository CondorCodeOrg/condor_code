---
sidebar_position: 2
---

# Віджет YouTube-плеєра (`YouTubePlayerWidget`)

**Розташування:** `apps/condor_code_app/lib/ui/widgets/youtube_player.dart`

**Залежності:** `youtube_player_iframe`, на **web** додатково `pointer_interceptor`.

Цей файл документує поведінку саме **нашої** обгортки навколо `youtube_player_iframe`, особливо **скрол на вебі**, **паузу при навігації** та обмеження платформи. Якщо змінюєте код плеєра або верстку навколо нього (наприклад, `SingleChildScrollView`), перечитайте розділ про скрол.

---

## Призначення

- Єдиний віджет для вбудованого відтворення YouTube за **`youtubeUrl`** (витягується `videoId`).
- Використовується на екранах курсу, деталях завдання, медіавіджеті тощо.
- На **mobile/desktop (не web)** — майже звичайний `YoutubePlayer` без додаткових шарів.
- На **web** додано шари для сумісності **коліщатка миші** із батьківськими `Scrollable` та обхід конфліктів із **iframe**.

---

## Поведінка для користувача

### Усі платформи

- Якщо з URL неможливо отримати `videoId`, показується текст про невалідне посилання (через `localization.invalidYouTubeLink`).
- Рамка, закруглення, співвідношення сторін задаються контейнером (`AspectRatio` 18 / 9 у поточній реалізації).
- Відео **не** автостартує після завантаження: використовується `cueVideoById`.

### Навігація та аудіо

- Віджет підписаний на **`RouteAware`** і **`coursesBranchRouteObserver`** (гілка курсів у `go_router`): при **`didPushNext`** / **`didPop`** викликається **`pauseVideo()`**, щоб звук приглушити при відкритті іншого маршруту **навігаційного стека** або поверненні назад цим стеком.
- Політику **історії браузера** і чому між уроками використовують **`context.push`** (а не лише **`go`**), описано в **`wiki/docs/codebase/conventions/navigation_conventions.md`**. Якщо під стеком лишаються живі сторінки курсу, важливо, щоб **RouteAware / пауза** або інша логіка зупинки відтворення відповідала продуктовим очікуванням.

### Лише web

| Стан відтворення | Що бачить користувач |
|------------------|----------------------|
| **Не грає** (cue, пауза, кінець, невідомий стан тощо) | Поверх плеєра є **прозорий шар** для перехоплення подій + **центральна кнопка відтворення** (Flutter). Коліщатко миші **прокручує сторінку** (батьківський скрол), а не лише iframe. Тап по **кнопці Play** запускає відео. Тап по **прозорій зоні** сам по собі відео **не запускає** — лише скрол. |
| **`playing`** або **`buffering`** | Прозорий шар і кнопка **зникають**. Показані **штатні елементи YouTube** у iframe (пауза, звук тощо). Скрол коліщатком **над самим iframe** може знову «з sticking» до браузера/iframe — це очікуваний компроміс. |

### Лише не-web

- Стандартна взаємодія через `YoutubePlayer`; додаткової кнопки Play немає.
- Вертикальний drag для переходу в fullscreen у плеєра **увімкнено** як у пакеті за замовчуванням (на web вимикається, див. нижче).

---

## Поведінка для розробника

### Пакет і контролер

- **`YoutubePlayerController`** не створюють через **`fromVideoId`** з одним лише `key: videoId`: на web кілька інстансів з тим самим відео дають конфлікти **ідентифікаторів платформи / GlobalKey**. У коді задається **`key: '${videoId}_${identityHashCode(this)}'`** і окремо **`cueVideoById`**.
- Підписка на **`controller.listen`** керує прапором **`_webScrollCaptureActive`** (показ/прибирання web-оверлею).
- При зміні **`youtubeUrl`**: скасувати підписку, **`close()`** старого контролера, ініціалізувати новий.

### Web: скрол (ключовий момент)

**Проблема:** HTML-iframe перехоплює scroll/wheel так, що батьківський Flutter-`ScrollView` майже не отримує події над областю відео.

**Рішення в коді:**

1. **`PointerInterceptor(intercepting: true)`** — шар між Flutter та platform view (iframe), щоб події обробляв Flutter-дочірній віджет.
2. **`Listener` + `onPointerSignal`** — на **`PointerScrollEvent`** виконується **`Scrollable.maybeOf(context).position.jumpTo(...)`** з урахуванням **`scrollDelta.dy`** та меж прокрутки.
3. **`enableFullScreenOnVerticalDrag: false`** у `YoutubePlayer` на web — вертикальний жест не забирає скрол у повноекранний режим плеєра на користь батьківського списку/скрола.

**Чому центральна кнопка Play, а не тап по всьому плеєру:** повний екранний `GestureDetector` у поєднанні з `SingleChildScrollView` зазвичай **програє скролові** у розпізнаванні жестів; надійний старт — окремий **`IconButton`**.

### RouteAware

- У **`didChangeDependencies`** передписка лише якщо **`ModalRoute.of(context)`** це **`PageRoute<dynamic>`**.
- Обовʼязково **`unsubscribe`** у **`dispose`**.

### Розташування у дереві віджетів

- **`_forwardWheelToScrollable`** шукає **`Scrollable.maybeOf(context)`** — очікується **батьківський скрол** вище по дереву від `YouTubePlayerWidget`. Якщо вкласти плеєр без `Scrollable` або в нестандартний **`NestedScrollView`**, ручний скрол може не знайти `position` або поводитись некоректно — треба перевірити на місці.

---

## Що не варто ламати без перегляду цього файлу

1. Прибирати **`PointerInterceptor`** / **`Listener`** на web без заміни — зазвичай знов зʼявиться «не працює скрол над відео».
2. Повертати **`YoutubePlayerController.fromVideoId`** без унікального `key` для кількох інстансів одного відео.
3. Використовувати **`GlobalKey`** на віджеті плеєра для «пересадки» між wide/narrow без крайньої потреби — раніше це давало проблеми з **WebView/iframe** і деревом Flutter.
4. Обгортати плеєр у ще один **fullscreen** opaque hit target без перевірки жестів зі скролом.

---

## Повʼязані файли та теми

| Що | Де шукати |
|----|-----------|
| Реалізація | `apps/condor_code_app/lib/ui/widgets/youtube_player.dart` |
| Панель уроку курсу | `apps/condor_code_app/lib/ui/screens/course/widgets/course_lesson_details_panel.dart` |
| Навігація курсу (push / go / route observer) | `wiki/docs/codebase/conventions/navigation_conventions.md`, `course_screen.dart` |
| Маршрут observer гілки курсів | `apps/condor_code_app/lib/ui/navigation/route_observers.dart` |
| Резponsive layout із скролом | `wiki/docs/codebase/widgets/side-panel-screen-widget.md` |

---

## Оновлення документації

При зміні логіки web-шару, умов **`PlayerState`** або роботи з **`Scrollable`** — оновіть цей файл і короткий коментар-блок угорі **`_forwardWheelToScrollable`** / **`_shouldCaptureWebScroll`** у коді за потреби.
