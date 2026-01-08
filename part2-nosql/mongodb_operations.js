// Operation 1: Load Data
// Import the provided JSON file into collection 'products'
// Run in terminal:
// mongoimport --db fleximart_nosql --collection products --file part2-nosql/products_catalog.json --jsonArray

// Operation 2: Basic Query
// Find all products in "Electronics" category with price less than 50000
// Return only: name, price, stock
db.products.find(
  { category: "Electronics", price: { $lt: 50000 } },
  { name: 1, price: 1, stock: 1, _id: 0 }
);

// Operation 3: Review Analysis
// Find all products that have average rating >= 4.0
// Use aggregation to calculate average from reviews array
db.products.aggregate([
  { $unwind: "$reviews" },
  { $group: { _id: "$name", avgRating: { $avg: "$reviews.rating" } } },
  { $match: { avgRating: { $gte: 4.0 } } },
  { $project: { _id: 0, name: "$_id", avgRating: 1 } }
]);

// Operation 4: Update Operation
// Add a new review to product with product_id "ELEC001"
db.products.updateOne(
  { product_id: "ELEC001" },
  {
    $push: {
      reviews: {
        user_id: "U999",
        username: "ValueBuyer",
        rating: 4,
        comment: "Good value for money!",
        date: ISODate()
      }
    }
  }
);

// Operation 5: Complex Aggregation
// Calculate average price by category
// Return: category, avg_price (rounded to 2 decimals), product_count
// Sort by avg_price descending
db.products.aggregate([
  {
    $group: {
      _id: "$category",
      avg_price: { $avg: "$price" },
      product_count: { $sum: 1 }
    }
  },
  {
    $project: {
      _id: 0,
      category: "$_id",
      avg_price: { $round: ["$avg_price", 2] },
      product_count: 1
    }
  },
  { $sort: { avg_price: -1 } }
]);