class CrowdCards {
  List <IndivCrowdCards> cards;

  CrowdCards(this.cards); 

  CrowdCards.fromJson(List<dynamic> json){
    if (json != null) {
      cards = new List<IndivCrowdCards>();
      json.forEach((v) {
        cards.add(new IndivCrowdCards.fromJson(v)); 
      });
    }
  }

  Map<String, dynamic> toJson(){

    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cards != null){
      data["cards"] = this.cards.map((v) => v.toJson);
    }

    return data; 
  }
    }

class IndivCrowdCards{
  int pk; 
  String headline;
  int truth_value; 
  int is_poll;
  String url; 
  String rating; 
  String domain; 
  String text; 
  String thumbnail_url;
  String author;
  String explanation; 


 

  IndivCrowdCards(this.pk, this.headline, this.text, this.thumbnail_url, this.rating, this.author, 
            this.truth_value, this.url, this.is_poll, this.domain, this.explanation);

  IndivCrowdCards.fromJson(Map<String, dynamic> json) {
    pk = json['pk'];
    headline = json['headline'];
    truth_value = json["truth_value"] ? 1: 0;
    is_poll = json["is_poll"] ? 1 : 0; 
    url = json["url"];
    rating = json['rating'];
    domain = json["domain"];
    text = json["text"]; 
    thumbnail_url = json['thumbnail_url'];
    author = json['author'];
    explanation = json["explanation"];
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pk'] = this.pk; 
    data['headline'] = this.headline; 
    data['rating'] = this.rating; 
    data['thumbnail_url'] = this.thumbnail_url; 
    data['author'] = this.author; 
    data['text'] = this.text; 
  return data;
  }
}


// [
//   {
//     "id": 1,
//     "headline": "Sanders hate popiahs",
//     "rating": "Pants on Fire",
//     "domain": null,
//     "text": "No, just kidding",
//     "thumbnail_url": "https://cdn.cnn.com/cnnnext/dam/assets/190225203627-bernie-sanders-town-hall-vpx-3-exlarge-169.jpg",
//     "author": "AdamKhoo",
//     "tags": [],
//     "explanation": "Nobody hates popiah",
//     "published": null,
//     "created": "2019-03-26T12:43:20.143175Z",
//     "modified": "2019-03-26T12:43:20.143230Z"
//   },
//   {
//     "id": 2,
//     "headline": "Eminem does the Hon Hon baguette",
//     "rating": "Fake",
//     "domain": null,
//     "text": "Hon hon hon hon hon hon honnnn HOOOON EMINEM DOES THE HON HON AND NOW EVERYONE IS BUYING A BAGUETTE",
//     "thumbnail_url": "https://i.redd.it/ngz7rbjvlj8z.jpg",
//     "author": "MGK from Est19XX",
//     "tags": [],
//     "explanation": "Eminem only has the arms spaghetti",
//     "published": null,
//     "created": "2019-03-26T12:43:55.864533Z",
//     "modified": "2019-03-26T12:43:55.864564Z"
//   },
//   {
//     "id": 3,
//     "headline": "Malaysian government denies giving 'blessing' to Johor Menteri Besar to visit Singapore waters",
//     "rating": "Real",
//     "domain": null,
//     "text": "KUALA LUMPUR - Malaysia has denied approving the visit by the chief minister of Johor last week to a government vessel in waters it is claiming from Singapore.",
//     "thumbnail_url": "https://www.straitstimes.com/sites/default/files/styles/article_pictrure_780x520_/public/articles/2019/01/18/ak_jm_1801.jpg?itok=4CoDf8nD&timestamp=1547783440",
//     "author": "Shannon from ST",
//     "tags": [],
//     "explanation": "Malaysia and Singapore are currently having a dispute on territorial waters.",
//     "published": null,
//     "created": "2019-03-26T12:44:08.167174Z",
//     "modified": "2019-03-26T12:44:08.167208Z"
//   },
//   {
//     "id": 4,
//     "headline": "Undergraduates can go direct to PhD with new SUTD programme",
//     "rating": "Real",
//     "domain": null,
//     "text": "SINGAPORE - A new programme will allow the brightest students here to do research on top of their regular academic load, and upon graduation, jump straight into their PhD.",
//     "thumbnail_url": "https://www.straitstimes.com/sites/default/files/styles/article_pictrure_780x520_/public/articles/2019/01/10/yq-sutd-10012019.jpg?itok=JAcxk2eM&timestamp=1547112609",
//     "author": "Jolene from ST",
//     "tags": [],
//     "explanation": "SUTD have been trying very hard to attract young talents in the past few years. Paired with the innovative spirit of the SUTD community, this is something can always be expected to make such daring moves.",
//     "published": null,
//     "created": "2019-03-26T12:44:17.702363Z",
//     "modified": "2019-03-26T12:44:17.702392Z"
//   },
//   {
//     "id": 5,
//     "headline": "Glory and disgrace: The complex legacy of Singapore founder Raffles",
//     "rating": "Real",
//     "domain": null,
//     "text": "SINGAPORE: Sir Stamford Raffles is best remembered as the founder of modern-day Singapore, but a new exhibition sheds light on less well-known exploits of a man also criticised as a disobedient adventurer and bloodthirsty imperialist.",
//     "thumbnail_url": "https://thumbs.dreamstime.com/z/sir-stamford-raffles-548654.jpg",
//     "author": "CNA",
//     "tags": [],
//     "explanation": "Because years later angmoh came, Stamford Raffles was his name. Pose statue very nice, later kena colonized",
//     "published": null,
//     "created": "2019-03-26T12:44:25.932923Z",
//     "modified": "2019-03-26T12:44:25.932957Z"
//   },
//   {
//     "id": 6,
//     "headline": "Nations Pride - Award Winning Singaporean Poet Elizabeth Sng writes about her favourite Singaporean-Things-To-Do",
//     "rating": "Biased",
//     "domain": null,
//     "text": "For a Canadian you have quite the unique interest in our tiny island. Anyway to answer your question, I take it that what youre really asking is how Singaporeans enjoy/prefer their time to be spent? Things like TV SHOWS, SPORTS, VIDEO GAMES, PROGRAMMING, movies, etc only scratches the surface as these are common interests that almost everyone has. I will first cover the locale pass times, then the trends.",
//     "thumbnail_url": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2hH5vK7lkfH_eaFM9ZayFywV0_TMrogVXZv3Umv77pH0UYJRSBA",
//     "author": "Lian He Zao Bao",
//     "tags": [],
//     "explanation": "Improper use of punctuations amd spelling",
//     "published": null,
//     "created": "2019-03-26T12:44:37.266006Z",
//     "modified": "2019-03-26T12:44:37.266035Z"
//   },
//   {
//     "id": 7,
//     "headline": "You won’t believe how these 9 shocking clickbaits work! (number 8 is a killer!)",
//     "rating": "Exaggerated",
//     "domain": null,
//     "text": "Clickbaits are quite common in social media. The basic concept of ‘clickbait’ is to create a melodramatic title for an online article so as to manipulate people into clicking the link and reading the content. Honestly, clickbait is a smart idea for publicity but, the way it has taken over social media over bland content is quite annoying.",
//     "thumbnail_url": "https://cdn-images-1.medium.com/max/1080/1*FHiucGpNU4ti0JYOKeM37Q.jpeg",
//     "author": "The Zerone",
//     "tags": [],
//     "explanation": "Clickbait title and content",
//     "published": null,
//     "created": "2019-03-26T12:44:48.637841Z",
//     "modified": "2019-03-26T12:44:48.637895Z"
//   },
//   {
//     "id": 8,
//     "headline": "Will these 3 Singapore girls be the next big singing sensations after Nathan Hartono?",
//     "rating": "Real",
//     "domain": null,
//     "text": "She started singing formally only late last year. But she has already been crowned Popstar of the Year 2016 at the annual solo singing competition organised by Precious Talents International & Kids Performing Academy of the Arts. Kaitlyn Ong, 10, has a wide repertoire of performances ranging from dancing to acting and even emceeing.",
//     "thumbnail_url": "https://www.youngparents.com.sg/sites/default/files/2016/Local%20kids%20with%20singing%20ability_3.png",
//     "author": "youngparents.com.sg",
//     "tags": [],
//     "explanation": "Its been 3 years. Look where they are now.",
//     "published": null,
//     "created": "2019-03-26T12:45:13.828011Z",
//     "modified": "2019-03-26T12:45:13.828041Z"
//   },
//   {
//     "id": 9,
//     "headline": "Flat-Earthers Run A Rigorous Experiment To Prove The Earth's Flatness And, Well...",
//     "rating": "Fake",
//     "domain": null,
//     "text": "Hughes converted fairly recently. In 2017, he called in to the Infinite Plane Society, a live-stream YouTube channel that discusses Earths flatness and other matters, to announce his beliefs and ambitions and ask for the communitys endorsement. Soon afterward, The Daily Plane, a flat-Earth information site (News, Media and Science in a post-Globe Reality), sponsored a GoFundMe campaign that raised more than seventy-five hundred dollars on Hughes behalf, enabling him to make the Mojave jump with the words 'Research Flat Earth' emblazoned on his rocket.",
//     "thumbnail_url": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-V_gsbvbfMvobNIM6Rr0eSIz_olkq7dp6l718WUT7luMbeWJ7",
//     "author": "The New Yorker",
//     "tags": [],
//     "explanation": "If Earth is flat why dont we just fall off",
//     "published": null,
//     "created": "2019-03-26T12:45:19.925060Z",
//     "modified": "2019-03-26T12:45:19.925091Z"
//   },
//   {
//     "id": 10,
//     "headline": "Flying Banana train: What our New Measurement Train does and how it saves us millions of pounds",
//     "rating": "Real",
//     "domain": null,
//     "text": "The New Measurement Train (NMT) is the most technically advanced train of its type in the world and the flagship vehicle of our Infrastructure Monitoring fleet.",
//     "thumbnail_url": "https://cdn.networkrail.co.uk/wp-content/uploads/2018/04/New-Measurement-Train-NMT-1035x545.jpg",
//     "author": "NetworkRailReporters",
//     "tags": [],
//     "explanation": "Short and concise article with clear meaning",
//     "published": null,
//     "created": "2019-03-26T12:45:29.554079Z",
//     "modified": "2019-03-26T12:45:29.554155Z"
//   }
// ]