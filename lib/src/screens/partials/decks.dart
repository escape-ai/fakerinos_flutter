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
  String subject; 
  List <dynamic> articles; 
  List <dynamic> tags;

  Deck(this.pk, this.subject, this.articles, this.tags); 

  Deck.fromJson(dynamic deckJson){
    pk = deckJson['pk']; 
    subject = deckJson['subject'];
    articles = deckJson['articles'];
    tags = deckJson['tags'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> output = new Map<String, dynamic>();
    output['pk'] = this.pk;
    output['subject'] = this.subject;
    output['articles'] = this.articles;
    output['tags'] = this.tags;
    print("printing output");
    print(output);
    return output; 

  }
}