import 'package:reel_news/models/category_model.dart';

List<CategoryModel> getCategories() {
  List<CategoryModel> categoryList = [];

  // Business Category
  CategoryModel businessCategory = CategoryModel(
    categoryName: "Business",
    imageUrl:
        "https://images.unsplash.com/photo-1504711434969-e33886168f5c?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  );

  // Entertainment Category
  CategoryModel entertainmentCategory = CategoryModel(
    categoryName: "Entertainment",
    imageUrl:
        "https://images.unsplash.com/photo-1598387993240-44b625d97d7f?q=80&w=1176&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  );

  // General Category
  CategoryModel generalCategory = CategoryModel(
    categoryName: "General",
    imageUrl:
        "https://images.unsplash.com/photo-1550135311-8572a1642f22?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  );

  // Health Category
  CategoryModel healthCategory = CategoryModel(
    categoryName: "Health",
    imageUrl:
        "https://images.unsplash.com/photo-1476480862126-209bfaa8edc8?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  );

  // Science Category
  CategoryModel scienceCategory = CategoryModel(
    categoryName: "Science",
    imageUrl:
        "https://images.unsplash.com/photo-1518152006812-edab29b069ac?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  );

  // Sports Category
  CategoryModel sportsCategory = CategoryModel(
    categoryName: "Sports",
    imageUrl:
        "https://a57.foxnews.com/static.foxnews.com/foxnews.com/content/uploads/2023/03/931/523/GettyImages-1453081672.jpg?ve=1&tl=1",
  );

  // Technology Category
  CategoryModel technologyCategory = CategoryModel(
    categoryName: "Technology",
    imageUrl:
        "https://images.unsplash.com/photo-1487058792275-0ad4aaf24ca7?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  );

  // Add all categories
  categoryList.add(businessCategory);
  categoryList.add(entertainmentCategory);
  categoryList.add(generalCategory);
  categoryList.add(healthCategory);
  categoryList.add(scienceCategory);
  categoryList.add(sportsCategory);
  categoryList.add(technologyCategory);

  return categoryList;
}
