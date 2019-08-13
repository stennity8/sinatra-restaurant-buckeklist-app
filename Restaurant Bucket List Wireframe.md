## Models will be User, Restaurant, and Reviews
  - Users will be able to create reviews for restaurants
  - Users will be able to see **ALL** reviews
  - Users will be able to see, edit, delete all of their reviews
  - Users will be able to add Restaurants to their BucketList after viewing other user reviews
  - User's restaurants on their Bucket List will be removed once they write a review

## User 
### Attributes
- e-mail
- username
- password-digest
- BucketList -array of restaurants that have not yet been reviewed by user

### Associations
- has_many :reviews
- has_many :restaurants, through: :reviews

## Restaurants
### Attributes
- name
- cuisine(i.e. Italian, American, Greek, etc.)
- location (Address, City, State, Zip Code)

### Associations
- has_many :reviews
- has_many :users, through: :reviews

## Reviews
### Attributes
- Date
- Rating(out of 5)
- Checkboxes for things you **LIKED** about restaurant i.e. Atmosphere, Service, Drinks, Apps, Entrees, Dessert
- Checkboxes for things you **DIDN'T LIKE** about restaurant i.e. Atmosphere, Service, Drinks, Apps, Entrees, Dessert
- Recommendations text box i.e. "I liked the **something** appetizer." or "Avoid the **something** entree."

### Associations
- belongs_to :users
- belongs_to :restaurants

## MVP
Users can signup, log in, log out, CRUD reviews, CRUD restaurants they have created but can not delete them once they have a review, other USERS can not update or delete restaurants created by other users that they have added to their bucket list.  Users will be able to create restaurants for their bucket list without reviews.  A list of all restaurants with and without reviews(bucket lists) will be viewable by users.

## Stretch Goals
- Build in error messages
- Work on CSS, possibly utilize Bootstrap
- Embed Google Map to show the Restaurant location within review page
- Use Google API
  - could also search for local restaurants based on user location(add city, state, zipcode to user)
  - pull Google ratings and/or reviews
- Tests