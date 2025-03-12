users = [
  { name: "Marsela", surname: "Admin", email: "admin@library.com", password: "password123", user_type: "library_personnel" },
  { name: "Erion", surname: "Krasniqi", email: "erion.krasniqi@example.com", password: "password123", user_type: "library_user", contact_address: "Rruga e Dibrës, Tiranë" },
  { name: "Arta", surname: "Dervishi", email: "arta.dervishi@example.com", password: "password123", user_type: "library_user", contact_address: "Bulevardi Zogu I, Tiranë" }
]

users.each do |user|
  User.create!(
    name: user[:name],
    surname: user[:surname],
    email: user[:email],
    password: user[:password],
    password_confirmation: user[:password],
    user_type: user[:user_type],
    contact_address: user[:contact_address] # Optional for personnel
  )
end

books = [
  {
    title: "Kronikë në Gur",
    author: "Ismail Kadare",
    language: "Albanian",
    publisher: "Onufri",
    publish_year: 1971,
    category: "Historical",
    description: "A powerful story set in Gjirokastër."
  },
  {
    title: "Gjenerali i Ushtrisë së Vdekur",
    author: "Ismail Kadare",
    language: "Albanian",
    publisher: "Naim Frashëri",
    publish_year: 1963,
    category: "Drama",
    description: "A haunting exploration of war and memory."
  },
  {
    title: "Koha e Cometës",
    author: "Ismail Kadare",
    language: "Albanian",
    publisher: "Onufri",
    publish_year: 1986,
    category: "Historical Fiction",
    description: "A novel exploring Albania's history through fiction."
  },
  {
    title: "Lumit i Madh",
    author: "Fan Noli",
    language: "Albanian",
    publisher: "Onufri",
    publish_year: 1920,
    category: "Poetry",
    description: "A collection of poetic reflections."
  },
  {
    title: "Prilli i Thyer",
    author: "Ismail Kadare",
    language: "Albanian",
    publisher: "Onufri",
    publish_year: 1978,
    category: "Drama",
    description: "A story about blood feuds in the Albanian highlands."
  }
]

books.each do |book|
  Book.create!(book)
end

journals = [
  {
    title: "Shqipëria Sot",
    volume: 15,
    issue: 2,
    language: "Albanian",
    publisher: "Akademia e Shkencave",
    publish_year: 2022,
    category: "Academic",
    description: "A journal focusing on contemporary Albanian issues."
  },
  {
    title: "Buletini Shkencor",
    volume: 10,
    issue: 1,
    language: "Albanian",
    publisher: "Universiteti i Tiranës",
    publish_year: 2023,
    category: "Scientific",
    description: "Scientific papers across various fields."
  },
  {
    title: "Kultura Popullore",
    volume: 20,
    issue: 4,
    language: "Albanian",
    publisher: "Akademia e Shkencave",
    publish_year: 2021,
    category: "Cultural",
    description: "Insights into Albanian cultural heritage."
  },
  {
    title: "Revista Ekonomike",
    volume: 7,
    issue: 3,
    language: "Albanian",
    publisher: "Universiteti i Tiranës",
    publish_year: 2024,
    category: "Economic",
    description: "Economic trends and analysis in Albania."
  },
  {
    title: "Histori Shqiptare",
    volume: 12,
    issue: 5,
    language: "Albanian",
    publisher: "Instituti i Historisë",
    publish_year: 2023,
    category: "Historical",
    description: "In-depth articles on Albanian history."
  }
]

journals.each do |journal|
  Journal.create!(journal)
end
