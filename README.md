# 🐱 Cat Search App（SwiftUI × CoreData）

📱 Overview

猫の画像を検索し、お気に入り登録ができるiOSアプリです。
シンプルなUIと直感的な操作を意識して設計しています。

---

## 🚀 Features

- 猫画像の検索（API連携）
- ローディング表示（ProgressView）
- 詳細画面で猫情報を表示
- お気に入り登録（CoreData）
- お気に入り一覧表示
- お気に入り削除（スワイプ対応）
- 空状態UI（お気に入り未登録時の案内表示）

---

## 🛠️ Tech Stack

- SwiftUI
- CoreData
- MVVM
- AsyncImage

---

## 📸 Screenshots
検索画面
 <img src="screenshot1.png" width="250">

詳細画面（お気に入りボタン付き）
 <img src="screenshot2.png" width="250">

お気に入り一覧
 <img src="screenshot3.png" width="250">

空状態UI
 <img src="screenshot4.png" width="250">
---

## 📌 Architecture

MVVMアーキテクチャを採用し、責務を分離しています。

- View：UI表示
- ViewModel：ロジック管理（検索 / お気に入り）
- Model：APIレスポンス・CoreData

---

## 💡 Points
🔹 CoreDataとSwiftUIの連携
- `@FetchRequest` を使用してお気に入り一覧を自動更新
- `NSManagedObjectContext` をEnvironmentで管理
🔹 UI/UXの工夫
- 画像上にお気に入りボタンを配置（直感的操作）
- ローディング中の状態を明確化
- 空状態UIでユーザーに行動を促す
🔹 設計
- 検索機能とお気に入り機能をViewModelで分離
- 責務を明確にして保守性を向上

---

## 🔧 Future Improvements
- 猫種情報の表示改善
- お気に入りの並び替え
- UIのブラッシュアップ（ダークモード対応など）

---

## 🧑‍💻 Author

GitHub: https://github.com/taka-sakamoto


  
