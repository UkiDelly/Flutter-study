class User {
  final String name;
  final String urlImage;

  // constructor
  User({
    required this.name,
    required this.urlImage,
  });

  // toString
  @override
  String toString() => 'User(name: $name, urlImage: $urlImage)';
}
