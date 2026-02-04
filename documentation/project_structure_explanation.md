# Tulip Tea Order Booker – Project Structure

This document explains the **Clean Architecture** layout of the app, how layers depend on each other, and where to find features and shared code.

---

## 1. High-Level Layout (Layer-First)

The app is organized **layer-first** under `lib/`:

- **`core/`** – Shared utilities, widgets, network, config, and errors.
- **`domain/`** – Business entities, repository interfaces (contracts), and use cases. No Flutter or external packages.
- **`data/`** – API clients, local storage, DTOs/models, and repository implementations.
- **`presentation/`** – Screens, **controllers (in a separate folder)**, bindings, and routes.
- **`di/`** – Dependency injection setup (GetX): registers APIs, repositories, use cases, and configures Dio (e.g. JWT, 401 handling).

**Dependency rule:**  
`domain` does not depend on anything. `data` and `presentation` depend on `domain`. `core` is used by `data` and `presentation`. `di` wires `core`, `domain`, and `data`.

---

## 2. Folder Structure

```
lib/
├── main.dart                 # Entry: load env, setup DI, decide initial route (onboarding / login / main)
├── app.dart                  # GetMaterialApp, theme, getPages, initialRoute
│
├── core/
│   ├── constants/            # API paths, storage keys, app constants
│   ├── config/               # Env (.env) loading and base URL
│   ├── utils/                # App-wide helpers (colors, fonts, spacing, validators, texts, etc.)
│   ├── network/              # Dio client, interceptors (JWT, 401), ApiResult, exceptions
│   ├── errors/               # Failure types (Server, Validation, Unauthorized, etc.)
│   ├── extensions/           # Context and String extensions
│   └── widgets/              # Reusable UI (buttons, form fields, shimmer, empty, app bar)
│       ├── buttons/
│       ├── form/
│       ├── feedback/
│       └── common/
│
├── domain/
│   ├── entities/             # Plain Dart models (AuthUser, Shop, Zone, Route, Visit, Order, etc.)
│   ├── repositories/         # Abstract repositories (interfaces only)
│   └── use_cases/            # One use case per aggregate (Auth, Shop, Route, Visit, Order, etc.)
│
├── data/
│   ├── data_sources/
│   │   ├── local/            # Secure storage, auth token holder (in-memory)
│   │   └── remote/          # API classes (AuthApi, RoutesApi, …)
│   ├── models/               # DTOs and mappers (e.g. request/response → entity)
│   └── repositories/        # Repository implementations
│
├── di/
│   └── injection.dart        # setupDependencyInjection(): Dio, APIs, repos, use cases
│
└── presentation/
    ├── bindings/             # GetX bindings per feature (Auth, Onboarding, Main, Dashboard, Shops, …)
    ├── controllers/          # All controllers in one place, grouped by feature
    │   ├── auth/
    │   ├── onboarding/
    │   ├── main/
    │   ├── dashboard/
    │   ├── shops/
    │   ├── visits/
    │   ├── credit_limits/
    │   └── account/
    ├── routes/               # AppRoutes (names), AppPages (GetPage list + bindings)
    └── screens/              # UI only; use Get.find<Controller>() or Get.put where needed
        ├── onboarding/
        ├── auth/
        ├── main/             # Main shell with persistent bottom nav
        ├── dashboard/
        ├── shops/
        ├── visits/
        ├── credit_limits/
        └── account/
```

---

## 3. Controllers (Separate Folder)

All **controllers** live under **`presentation/controllers/`**, grouped by feature:

- **`auth/`** – e.g. `LoginController`
- **`onboarding/`** – `OnboardingController`
- **`main/`** – `MainShellController`
- **`dashboard/`** – `DashboardController`
- **`shops/`** – `ShopsController`, `ShopRegisterController`, `MyShopsController`
- **`visits/`** – `VisitsController`, `VisitRegisterController`, `OrderCreateController`, `DailyCollectionController`, `VisitHistoryController`
- **`credit_limits/`** – `CreditLimitsController`, `CreditLimitRequestController`, `MyRequestsController`
- **`account/`** – `AccountController`

Screens stay under **`presentation/screens/`** and reference these controllers via **Get.find\<Controller\>()** when a **binding** has already registered them, or **Get.put(Controller(...))** when the screen is embedded (e.g. tabs in main shell).

---

## 4. Bindings

Each major route can have a **binding** that registers the controllers for that flow:

- **OnboardingBinding** – `OnboardingController` (and ensures DI is set up if needed).
- **AuthBinding** – `LoginController`.
- **MainBinding** – `MainShellController` and **all tab bindings** (ShopsBinding, VisitsBinding, CreditLimitsBinding, DashboardBinding, AccountBinding) so that when the user switches tabs, controllers are already registered and screens can use **Get.find\<Controller\>()**.
- **ShopsBinding** – `ShopsController`, `ShopRegisterController` (Auth, Zone, Route, Shop use cases), `MyShopsController`.
- **VisitsBinding** – `VisitsController`, `VisitRegisterController`, `OrderCreateController` (Auth, Shop, Product, Order use cases), `DailyCollectionController` (Auth, Shop, DailyCollection use cases), `VisitHistoryController`.
- **CreditLimitsBinding** – `CreditLimitsController`, `CreditLimitRequestController` (Auth, Shop, CreditLimitRequest use cases), `MyRequestsController` (Auth, CreditLimitRequest use cases).

Bindings are attached to **GetPage** in **`presentation/routes/app_pages.dart`**.  
**`di/injection.dart`** runs once at startup and registers repositories, use cases, and Dio (with JWT and 401 handling).

---

## 5. Utils Usage

**`core/utils/`** is used across the app:

- **app_colors** – Theme and widget colors.
- **app_fonts** – Font families (e.g. for `app_text_styles`).
- **app_formatters** – Date/time formatting (visits, orders, collections).
- **app_images** – Asset paths (onboarding, placeholders).
- **app_lotties** – Lottie asset paths.
- **app_responsive** – Screen size and scaling.
- **app_spacing** – Padding, margin, gaps.
- **app_styles** – Text styles (headline, body, hint, button, label, error).
- **app_texts** – All user-facing strings (labels, errors, empty states, camera, gallery).
- **app_validators** – Form validation (phone, password, required, etc.).

**`core/widgets/form/`** includes:

- **AppTextField**, **AppDropdown** – Form inputs with labels and validators.
- **AppImagePicker** – Reusable image picker (camera/gallery) with preview and remove; used for CNIC photos in Shop Register. Uses **image_picker** and **AppTexts** (addPhoto, remove, camera, gallery).

---

## 6. Icons

**Iconsax** is used for icons across the app (buttons, tabs, form fields, app bar, empty states).  
Import: `package:iconsax/iconsax.dart` and use e.g. `Iconsax.login_1`, `Iconsax.shop`, `Iconsax.user`.

---

## 7. Navigation and Initial Route

- **Routes** are defined in **`AppRoutes`** and **`AppPages`** (GetX).
- **Initial route** is chosen in **`main.dart`**:
  - Onboarding not completed → **`/onboarding`**
  - Not logged in → **`/login`**
  - Logged in → **`/main`** (bottom nav shell with Dashboard, Shops, Visits, Credit Limits, Account).
- **Main shell** uses **`persistent_bottom_nav_bar_v2`** so each tab keeps its own navigation stack.

---

## 8. Authentication and 401 Handling

- **JWT** is stored in **flutter_secure_storage** and kept in an **in-memory** holder for quick access.
- **Dio interceptors** add the token to requests and, on **401**, clear token + user data and redirect to **`/login`** (session expired).
- **AuthUser** is the single source of truth for the logged-in user; **orderBookerId** is the user `id` for the order booker role.

---

## 9. API and Result Type

- **Base URL** comes from **`.env`** (e.g. `BASE_URL`).
- **Dio** is configured in **`core/network/dio_client.dart`** with interceptors from **`core/network/api_interceptors.dart`**.
- API results are wrapped in **`ApiResult<T>`** (success/failure); **`ApiExceptions`** map Dio errors and 422 validation to **`ApiFailure`** and domain **`Failure`** types.

---

## 10. Features (Implemented)

- **Onboarding** – 3 screens; completion stored with auth storage; then navigate to login.
- **Login** – Phone + password; calls **POST /auth/login/order-booker**; on success goes to main.
- **Dashboard** – Shows assigned routes (**GET /routes/order-booker/{id}**); shimmer/empty handled.
- **Shops** – Tabs: **Register** (full form: name, owner, phone, GPS lat/lng, zone, route, credit limit, **CNIC front/back photos** via `AppImagePicker`; images sent as base64) and **My Shops** (list from **GET /shops/order-booker/{id}**).
- **Visits** – Tabs: **Register Visit** (shop, visit type, GPS, reason; **POST /shop-visits/order-booker/{id}**), **Create Order** (shop, products from **GET /products/active**, quantity/unit price per line, scheduled date; **POST /orders/order-booker/{id}**), **Submit Collection** (shop, amount, remarks; **POST /daily-collections/order-booker/{id}**), **History** (list from **GET /shop-visits/order-booker/{id}**).
- **Credit Limits** – Tabs: **Request Change** (shop dropdown, requested amount, remarks; **POST /credit-limit-requests/order-booker/{id}**) and **My Requests** (list from **GET /credit-limit-requests/all** filtered client-side by `requested_by_id == orderBookerId`).
- **Account** – Profile (name, phone, email from login response), app version, logout.

**Hero animations** are used on onboarding (image + title per page), login (app name, title, button), and list cards (shop, visit, credit request) for smoother transitions.

**Next steps (optional):** Map/GPS auto-fill, optional `visit_id` when creating order/collection from a visit.

---

## 11. Key Files (Reference)

| File | Purpose |
|------|--------|
| **lib/main.dart** | Entry: load `.env`, run `setupDependencyInjection()`, decide initial route from onboarding + auth, run `MyApp`. |
| **lib/app.dart** | `GetMaterialApp` with theme, `getPages: AppPages.routes`, `initialRoute`. |
| **lib/di/injection.dart** | Registers: `AuthTokenHolder`, `SecureStorageSource`, `DioClient`, all APIs, repositories, use cases (GetX `Get.put`). |
| **lib/core/config/env_config.dart** | Loads `.env`; exposes `baseUrl` and flags. |
| **lib/core/network/dio_client.dart** | Singleton Dio with base URL and `ApiInterceptors` (JWT + 401 → logout). |
| **lib/core/network/api_interceptors.dart** | Adds `Authorization: Bearer`; on 401 calls `onUnauthorized` and `Get.offAllNamed('/login')`. |
| **lib/core/widgets/form/app_image_picker.dart** | Camera/gallery picker; preview + remove; uses `AppTexts` (camera, gallery, addPhoto). |
| **lib/presentation/routes/app_pages.dart** | All `GetPage` definitions with bindings; used by `GetMaterialApp.getPages`. |
| **lib/presentation/bindings/main_binding.dart** | Registers `MainShellController` and **all tab bindings** (Shops, Visits, CreditLimits, Dashboard, Account) so tab screens can `Get.find<Controller>()`. |
| **lib/presentation/controllers/shops/shop_register_controller.dart** | Zones/routes from use cases; form state; on submit converts CNIC file paths to base64 and calls `ShopUseCase.registerShop`. |
| **lib/presentation/controllers/visits/visit_register_controller.dart** | Loads shops (approved only); submit calls `ShopVisitUseCase.registerVisit`. |
| **lib/presentation/controllers/visits/order_create_controller.dart** | Loads shops and products (active); order lines (product, quantity, unit price); submit calls `OrderUseCase.createOrder`. |
| **lib/presentation/controllers/visits/daily_collection_controller.dart** | Loads shops; submit calls `DailyCollectionUseCase.submitCollection` (amount, remarks). |
| **lib/presentation/controllers/credit_limits/my_requests_controller.dart** | Loads all requests; filters by `requestedById == orderBookerId`. |

---

This file is the single reference for the **whole project structure** and how the parts fit together.
