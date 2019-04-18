class Decks {
  List <Deck> decks; 

  Decks(this.decks); 

  Decks.fromJson(List<dynamic> decksJson){
    
    decks = new List<Deck>(); 
    decksJson.forEach((v) => {
      decks.add(new Deck.fromJson(v))
    });
  }

  Map<String, dynamic> toJson(){
    
    final Map<String, dynamic> output = new Map<String, dynamic>(); 
    
    if (this.decks != null){
      output["decks"] = this.decks.map((v) => v.toJson());  
    }
    return output; 
  }

}

class Deck {
  int pk; 
  String title;
  String description;  
  List <dynamic> articles; 
  List <dynamic> tags;
  String thumbnail_url; 
  int times_played; 
  int stars;

  Deck(this.pk, this.title, this.description, this.articles, this.tags,
      this.thumbnail_url, this.times_played, this.stars); 

  Deck.fromJson(dynamic deckJson){
    pk = deckJson['pk']; 
    title = deckJson["title"];
    description = deckJson['description'];
    articles = deckJson['articles'];
    thumbnail_url = deckJson['thumbnail_url'];
    times_played = deckJson['times_played'];
    stars = deckJson['stars'];
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> output = new Map<String, dynamic>();
    output['pk'] = this.pk;
    output['title'] = this.title;
    output['description'] = this.description;
    output['articles'] = this.articles;
    output['thumbnail_url'] = this.thumbnail_url;
    output['times_played'] = this.times_played;
    output['stars'] = this.stars;
    
    return output; 

  }
}