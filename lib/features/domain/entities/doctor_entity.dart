class DoctorEntity {
  final String name;
  final String id;
  final String location;
  final String about;
  final String category;
  final String fee;
  final String profileImgUrl;
  final List<String> qualifications;

  DoctorEntity({
    required this.name,
    required this.id,
    required this.location,
    required this.about,
    required this.category,
    required this.fee,
    required this.profileImgUrl,
    required this.qualifications,
  });
}
