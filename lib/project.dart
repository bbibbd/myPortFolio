class Project {
  final String name;
  final String description;
  final String imageUrl;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> imageUrls;

  Project({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.startDate,
    required this.endDate,
    required this.imageUrls,
  });
}
