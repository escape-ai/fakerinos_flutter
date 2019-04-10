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
      output["decks"] = this.interestCards.map( (card)=> card.toJson()); 
    }
    return output; 
  }
}

class InterestCard{
  String name; 

  InterestCard.fromJson(dynamic cardJson){
    name = cardJson['name'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> output = new Map<String, dynamic>(); 
    output["name"] = this.name; 

    return output;
  }
}