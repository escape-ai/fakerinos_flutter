class InterestCards {
  List <InterestCard> interestCards; 

  InterestCards(this.interestCards); 

  InterestCards.fromJson(List<dynamic> interestCardsJson){
    interestCards = new List<InterestCard>(); 
    interestCardsJson.forEach((v)=> {
      interestCards.add(new InterestCard.fromJson(v))
    });
    
  }

  Map<String, dynamic> toJson(){

    final Map<String, dynamic> output = new Map<String, dynamic>(); 

    if (this.interestCards != null){
      output["cards"] = this.interestCards.map( (card)=> card.toJson()); 
    }
    return output; 
  }
}

class InterestCard{
  String name; 
  String thumbnail_url;

  InterestCard(this.name, this.thumbnail_url);

  InterestCard.fromJson(dynamic cardJson){
    name = cardJson['name'];
    thumbnail_url = cardJson["thumbnail_url"];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> output = new Map<String, dynamic>(); 
    output["name"] = this.name; 
    output["thumbnail_url"] = this.thumbnail_url; 
    return output;
  }
}