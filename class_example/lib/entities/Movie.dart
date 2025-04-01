class Movie {
  String title;
  String description;
  String imageUrl;
  String year;

  Movie(
      {required this.title,
      required this.description,
      required this.imageUrl,
      required this.year});

  String mostrarInformacion() {
    return 'Titulo: $title, Descripcion: $description, Año: $year';
  }
}
