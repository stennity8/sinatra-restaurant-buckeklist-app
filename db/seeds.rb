user = User.create({username: "demo", email: "demo@demo.com", password_digest: "password"})
restaurant = Restaurant.create({name: "Chilis", cuisine: "Mexican", city: "Rochester", state: "NY", zip_code: "12345"})
review = Review.create({rating: 3, recommendation: "The queso is great!", user_id: user.id, restaurant_id: restaurant.id})

restaurant = Restaurant.create({name: "Macaroni Grill", cuisine: "Italian", city: "Albany", state: "NY", zip_code: "67890"})
review = Review.create({rating: 4, recommendation: "I love their blackened chicken pasta.  Service is great too.", user_id: user.id, restaurant_id: restaurant.id})

user = User.create({username: "demo2", email: "demo2@demo.com", password_digest: "password"})
restaurant = Restaurant.create({name: "Red Lobster", cuisine: "Seafood", city: "Buffalo", state: "NY", zip_code: "11223"})
review = Review.create({rating: 5, recommendation: "Did someone say endless shrimp?", user_id: user.id, restaurant_id: restaurant.id})