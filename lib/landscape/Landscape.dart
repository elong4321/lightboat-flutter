class Landscape {
    String phrase;
    String passage;
    String image;

    Landscape(Map<String, dynamic> map):
    phrase = map['phrase'], passage = map['passage'], image = map['image'];

}