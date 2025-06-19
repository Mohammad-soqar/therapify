final List<Amenity> amenitiesData = [
  Amenity(
    image: "assets/icons/tv.png",
    title: "Television",
  ),
  Amenity(
    image: "assets/icons/ac.png",
    title: "AC",
  ),
  Amenity(
    image: "assets/icons/kitchen.png",
    title: "Kitchen",
  ),
  Amenity(
    image: "assets/icons/pool.png",
    title: "Pool",
  ),
  Amenity(
    image: "assets/icons/bath.png",
    title: "3 Bath",
  ),
  Amenity(
    image: "assets/icons/bed.png",
    title: "4 Bed",
  ),
];

class Amenity {
  final String image;
  final String title;

  Amenity({
    required this.image,
    required this.title,
  });
}
