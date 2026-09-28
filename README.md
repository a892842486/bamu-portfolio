# Bamu Portfolio

使用 **Ruby on Rails 8** 開發的個人作品集網站，展示個人介紹、技術技能與開發專案，並提供後台管理介面，方便維護作品集內容。

專案以 Rails MVC 架構開發，整合 Tailwind CSS、Stimulus、Active Storage 與 i18n，實作個人資料、技能、專案及圖片管理功能。

## Features

### Portfolio（前台）

* 個人介紹與技能展示
* 專案列表與詳細頁面
* 專案圖片展示
* 專案相關技術技能呈現
* 響應式網頁設計

### Admin Dashboard（後台）

* Profile 個人資料 CRUD
* Skill 技能 CRUD
* 技能拖曳排序
* Project 專案 CRUD
* 專案與技能關聯管理
* Project Links 外部連結管理
* Project Images 多圖片上傳與管理

### Image Management（圖片管理）

* 使用 Active Storage 管理專案圖片
* 支援多張圖片上傳
* 管理後台圖片預覽與刪除

## Tech Stack

| 分類                   | 技術              |
| -------------------- | --------------- |
| Backend              | Ruby on Rails 8 |
| Database             | PostgreSQL      |
| Frontend             | Tailwind CSS    |
| JavaScript           | Stimulus        |
| Image Upload         | Active Storage  |
| Internationalization | Rails i18n      |
| Testing              | Rails Minitest  |
| Version Control      | Git / GitHub    |

## Project Structure

主要資料模型：

* `Profile`：個人介紹資料
* `Skill`：技術技能及排序
* `Project`：作品專案與圖片
* `ProjectSkill`：專案與技能的關聯
* `Link`：專案相關連結

透過 Rails Active Record associations 管理模型之間的關聯，並使用 RESTful routes 與 Strong Parameters 處理後台資料操作。

## Development Highlights

### Admin CRUD

使用 Rails RESTful 架構建立後台管理功能，支援個人資料、技能及專案的新增、編輯、刪除與查詢。

### Skill Drag & Drop Sorting

使用 Stimulus 實作技能拖曳排序，讓管理者能調整前台技能的顯示順序。

### Project Images

使用 Active Storage 實作專案多圖片上傳、預覽及刪除，讓作品頁面能呈現實際開發成果。

### Internationalization

使用 Rails i18n 管理中英文介面文字，讓作品集支援多語系呈現。

## Screenshots

作品畫面截圖將陸續補充。

## Local Development

### Requirements

* Ruby
* Rails 8
* PostgreSQL
* Node.js

### Setup

```bash
git clone https://github.com/a892842486/bamu-portfolio.git
cd bamu-portfolio

bundle install

bin/rails db:create
bin/rails db:migrate
```

### Start Server

```bash
bin/dev
```

開啟瀏覽器前往：

http://localhost:3000

## Testing

執行 Rails 測試：

```bash
bin/rails test
```

## Future Improvements

* 完善作品展示內容與截圖
* 持續優化響應式版面
* 完善正式環境部署與維護
