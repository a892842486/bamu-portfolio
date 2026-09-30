# Demo Admin
admin = User.find_or_initialize_by(email: "admin@test.com")
if admin.new_record?
  admin.password = "123456"
  admin.password_confirmation = "123456"
  admin.save!
end

# Profile
profile = Profile.find_or_initialize_by(display_name: "Bamu")
profile.assign_attributes(
  job_title: "Ruby on Rails Backend Developer",
  introduction: <<~TEXT,
    我正朝 Ruby on Rails 後端工程師方向發展，透過實作個人作品集與電商網站，累積 Rails MVC、RESTful CRUD、資料庫關聯、使用者驗證、訂單流程及 Active Storage 等開發經驗。

    持續精進程式設計能力，並將實作經驗應用於解決實際問題，期待加入開發團隊，參與產品開發與維護。
  TEXT
  contact_email: "a892842486@gmail.com"
)
profile.save!
profile_link = profile.links.find_or_initialize_by(label: "Github")
profile_link.url = "https://github.com/a892842486"
profile_link.position = 1
profile_link.save!

# Profile Links
# 依目前已確認的資料，Profile 尚未盤點出 Links，暫不新增。

# Skills
skill_names = [
  "Ruby",
  "Ruby on Rails",
  "JavaScript",
  "Tailwind CSS",
  "PostgreSQL",
  "Devise",
  "Active Storage",
  "AWS S3",
  "Stimulus",
  "Action Mailer",
  "i18n"
]

skills = skill_names.each_with_index.to_h do |name, index|
  skill = Skill.find_or_initialize_by(name: name)
  skill.position = index + 1
  skill.save!
  [ name, skill ]
end

# Projects
projects_data = [
  {
    name: "Amiibo Store",
    summary: "使用 Ruby on Rails 開發的電商網站，提供商品瀏覽、購物車與訂單流程。",
    description: <<~TEXT,
      以 Ruby on Rails 開發的全端電商網站，包含會員註冊與登入、商品管理、購物車、結帳、訂單追蹤與後台管理功能。
      使用 Devise 處理使用者驗證，並透過 Active Storage 搭配 AWS S3 儲存商品圖片。
      訂單狀態使用 AASM 管理購買流程中的狀態轉換。
    TEXT
    github: "https://github.com/a892842486/amiibo-store",
    live_demo: "https://jdstore20260510.onrender.com",
    skills: [
      "Ruby", "Ruby on Rails", "JavaScript", "Tailwind CSS",
      "PostgreSQL", "Devise", "Active Storage", "AWS S3",
      "Action Mailer", "i18n"
    ],
    captions: [
      "Home Page",
      "Product Listing",
      "Product Details",
      "Shopping Cart",
      "Product Management"
    ]
  },
  {
    name: "Bamu Profolio",
    summary: "使用 Ruby on Rails 開發的個人作品集網站，展示個人介紹與開發作品。",
    description: <<~TEXT,
      以 Ruby on Rails 開發的個人作品集網站，包含個人資料、技能與作品管理功能。
      使用 Devise 處理管理者登入，並透過 Active Storage 管理作品圖片。
      作品內容支援 Skills、Links 與圖片等資訊，並建立 Admin 後台進行內容管理。
      使用 Stimulus 實作 Skills 拖曳排序，讓技能顯示順序可以直接在後台調整。
    TEXT
    github: "https://github.com/a892842486/bamu-portfolio",
    skills: [
      "Ruby", "Ruby on Rails", "JavaScript", "Tailwind CSS",
      "PostgreSQL", "Devise", "Active Storage", "Stimulus"
    ],
    captions: [
      "Bamu Portfolio Home Page",
      "About Me and Technologies",
      "Portfolio Project List",
      "Amiibo Store Project Details",
      "Contact Information",
      "Project Management",
      "Profile Management",
      "Skills Management (it can drag)"
    ]
  }
]

projects_data.each do |data|
  project = Project.find_or_initialize_by(name: data[:name])
  project.summary = data[:summary]
  project.description = data[:description]
  project.save!

  # Project Skills
  data[:skills].each_with_index do |skill_name, index|
    association = ProjectSkill.find_or_initialize_by(
      project: project,
      skill: skills.fetch(skill_name)
    )
    association.position = index + 1
    association.save!
  end

  # Project Links
  github_link = project.links.find_or_initialize_by(label: "Github")
  github_link.url = data[:github]
  github_link.position = 1
  github_link.save!

  if data[:live_demo].present?
    demo_link = project.links.find_or_initialize_by(label: "Live Demo")
    demo_link.url = data[:live_demo]
    demo_link.position = 2
    demo_link.save!
  end

  # Project Images
  data[:captions].each_with_index do |caption, index|
    project_image = project.project_images.detect do |image|
      image.caption.to_s.gsub(/\s+/, " ").strip == caption
    end

    project_image ||= project.project_images.build

    project_image.caption = caption
    project_image.position = index + 1
    project_image.save!

    image_files = Dir[Rails.root.join(
      "db/seeds/images/#{project.name.parameterize}-#{index + 1}-*"
    )]

    if image_files.any? && !project_image.image.attached?
      File.open(image_files.first) do |file|
        project_image.image.attach(
          io: file,
          filename: File.basename(image_files.first),
          content_type: "image/png"
        )
      end
    end
  end
end

puts "Portfolio seeds completed!"
