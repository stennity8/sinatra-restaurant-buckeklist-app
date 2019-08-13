demo = {username: "demo", email: "demo@demo.com", password_digest: "password"}
User.create(demo)
demo_rest = {name: "Chilis", cuisine: "Mexican", location: "Rochester, NY"}
Restaurant.create(demo_rest)
demo_review = {rating: 3, good: "fajitas", bad: "dessers", recommendation: "queso"}
Review.create(demo_review)