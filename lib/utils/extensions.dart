

extension StringExtenstions on String {
  String get png => 'assets/png_files/$this.png';

  String get jpg => 'assets/jpg_files/$this.jpg';

  String get jpeg => 'assets/png_files/$this.jpeg';

  String get svg => 'assets/svg_files/$this.svg';
}
