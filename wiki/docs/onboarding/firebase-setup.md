# Firebase Setup

> 💡 **This is optional.**  
> You can develop entirely in `mock` mode without a Firebase account. Only set this up if you need real data, analytics, or want to test features that require a backend.

CondorCode uses Firebase for authentication, Firestore database, analytics, and hosting. The project has **three environments**, each backed by its own Firebase project:

| Environment | Firebase Project | Who has access |
|-------------|------------------|--------------|
| **Dev** | `YOUR_DEV_PROJECT_ID` | Core team members only |
| **Staging** | `YOUR_STAGING_PROJECT_ID` | Core team members only |
| **Production** | `YOUR_PROD_PROJECT_ID` | Core team members only |

---

## What You Actually Need

### External contributors

Create **your own Firebase project** for local development. You do **not** have access to the official projects Firebase.

Steps below assume you created a project named, for example, `my-condorcode-dev`.

---

## 2. Register Android Apps

For each app you want to run with Firebase you must register an Android app inside the Firebase project.

### Main app

- **Package name:** `com.condorcode.condorcodeapp` *(check `apps/condor_code_app/android/app/build.gradle` if this changes)*
- **Nickname:** `condor_code_app`

### Admin app

- **Package name:** `com.condorcode.admin` *(check `apps/condor_code_admin_app/android/app/build.gradle` if this changes)*
- **Nickname:** `condor_code_admin_app`

> 📝 **Can I reuse the same package name in my own Firebase project?**
> Yes. Firebase projects are completely independent, so `com.condorcode.condorcodeapp` can exist in both the official project and your personal project at the same time without any conflict. Keep the same package name for local development — it saves you from editing `build.gradle` or `Info.plist`. You only need to change it if you plan to publish your own fork to the Play Store or App Store.

Steps:
1. In Firebase Console → **Project Overview** → **Add app** → **Android**
2. Enter the package name above
3. Download `google-services.json`
4. Move the downloaded file to the correct location:
   - Main app → `apps/condor_code_app/android/app/google-services.json`
   - Admin app → `apps/condor_code_admin_app/android/app/google-services.json`

> 🔒 **Never commit these files.** They are listed in `.gitignore`, but double-check before pushing.

---

## 3. Register iOS Apps

### Main app

- **Bundle ID:** `com.condorcode.condorcodeapp` *(check `ios/Runner/Info.plist` or `ios/Runner.xcodeproj/project.pbxproj`)*
- **Nickname:** `condor_code_app`

### Admin app

- **Bundle ID:** `com.condorcode.admin` *(check `ios/Runner/Info.plist` or `ios/Runner.xcodeproj/project.pbxproj`)*
- **Nickname:** `condor_code_admin_app`

Steps:
1. In Firebase Console → **Project Overview** → **Add app** → **iOS**
2. Enter the bundle ID above
3. Download `GoogleService-Info.plist`
4. Move the downloaded file to the correct location:
   - Main app → `apps/condor_code_app/ios/Runner/GoogleService-Info.plist`
   - Admin app → `apps/condor_code_admin_app/ios/Runner/GoogleService-Info.plist`

---

## 4. Generate Dart Firebase Options

Install `flutterfire_cli` if you haven't already:
```bash
dart pub global activate flutterfire_cli
```

Log in to Firebase:
```bash
firebase login
```

Generate the Dart config for each app:

**Main app:**
```bash
cd apps/condor_code_app
flutterfire configure
```
- Select your Firebase project
- Select the platforms you registered (Android / iOS / Web)

**Admin app:**
```bash
cd apps/condor_code_admin_app
flutterfire configure
```
- Same steps as above

`flutterfire configure` creates `lib/firebase_options.dart` in each app. **However**, the app imports from `lib/config/firebase/` instead. You must copy the generated content to the correct file:

| Environment | Copy generated content to |
|-------------|--------------------------|
| Dev | `apps/condor_code_app/lib/config/firebase/firebase_options_dev.dart` |
| Staging | `apps/condor_code_app/lib/config/firebase/firebase_options_stg.dart` |
| Production | `apps/condor_code_app/lib/config/firebase/firebase_options_prod.dart` |

For admin app use the same pattern inside `apps/condor_code_admin_app/lib/config/firebase/`.

> 💡 **Only have one Firebase project?**> Copy the same generated content into `firebase_options_dev.dart`, `firebase_options_stg.dart`, and `firebase_options_prod.dart`. The app picks the correct file at runtime based on `BUILD_TYPE`. If all three point to the same project, that is fine for local development.

After copying, you can delete the generated `lib/firebase_options.dart` to avoid confusion.
---

## 5. Run the App with Real Data

Now you can switch from `mock` to `remote`:

**Main app:**
```bash
cd apps/condor_code_app
fvm flutter run --dart-define=BUILD_TYPE=dev --dart-define=DATA_SOURCE=remote
```

**Admin app:**
```bash
cd apps/condor_code_admin_app
fvm flutter run --dart-define=BUILD_TYPE=dev --dart-define=DATA_SOURCE=remote
```

The app should connect to Firebase Auth + Firestore and load real content.

---

## Troubleshooting

| Problem | Likely Cause | Fix |
|---------|-------------|-----|
| "Firebase not initialised" error | Missing `google-services.json` or wrong package name | Double-check the file exists and the package ID matches Firebase Console |
| `flutterfire configure` can't find the project | Wrong account or no permission | Make sure you are logged into the correct Google account |
| Crash on startup with `remote` mode | `firebase_options.dart` points to a different project | Re-run `flutterfire configure` for the correct project |

---

## Related

- [Working with the Monorepo](../codebase/conventions/working-with-monorepo.md) — how the monorepo handles config files
- [CI/CD](../codebase/ci-cd.md) — how CI deploys to staging and production Firebase projects
