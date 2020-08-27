part of transit;

/**
 * Type of ReadHandlers - unary function.
 */
typedef T ReadHandler<T>(dynamic);

final Map<String, ReadHandler> _standardReadHandlers = {
                                         
  "_": (_) => null,
      
  "?": (o){
      if(o is bool) return o;
      if(o == "t") return true;
      if(o == "f") return false;
      return null;
  },
  
  "i": (o){
    if(o is int) return o;
    if(o is String) return int.parse(o);
    return null;
  },
  
  "n": (o){
    if(o is int) return o;
    if(o is String) return int.parse(o);
    return null;
  },
  
  "d": (o){
    if(o is double) return o;
    if(o is int) return o.toDouble();
    if(o is String) return double.parse(o);
    return null;
  },
  
  "f": (o){
    if(o is double) return o;
    if(o is int) return o.toDouble();
    if(o is String) return double.parse(o);
    return null;
  },
  
  "s": (o) => o.toString(),
  
  "b": (o){
    if(o is String)
      return new TransitBytes(base64.decode(o));
    return null;
  },
  
  ":": (o) => new TransitKeyword(o.toString()),
  
  "\$": (o) => new TransitSymbol(o.toString()),
  
  "m": (o){
    if(o is int) return new DateTime.fromMillisecondsSinceEpoch(o);
    if(o is String) return
        new DateTime.fromMillisecondsSinceEpoch(int.parse(o));
    return null;
  },
  
  "t": (o){
    if(o is String) return DateTime.parse(o);
    return null;
  },
    
  "u": (o){
    if(o is String) return new TransitUuid.parse(o);
    if(o is List && o.length == 2 && o[0] is int && o[1] is int)
      return new TransitUuid(o[0],o[1]);
    return null;
   },
     
  "r": (o){
    if(o is String) return Uri.parse(o);
    return null;
  },
      
    
  "c": (o) => o.toString()[0],
  
  "'": (o) => o,
  
  "array": (o){
    if(o is List) return o;
    return null;
  },
  
  "map": (o){
    if(o is Map) return o;
    return null;
  },
   
  "cmap": (o){
    if(o is List && o.length % 2 == 0){
      Map result = {};
      int l = o.length ~/ 2;
      for(int i = 0; i < l; i++){
        result[o[2*i]] = o[2*i+1];
      }
      return result;
    };
    return null;
  },
   
  "list": (o){
    if(o is List) return new Queue.from(o);
    return null;
  },
   
  "set": (o){
    if(o is List) return new Set.from(o);
    return null;
  },
  
  "link": (o){
    try {
      TransitLink l = new TransitLink(
          o["href"],
          o["rel"],
          o["name"]
      );
      if(o.containsKey("render"))
        l.render = TransitLinkRenderType.ALL[o["render"]];
      if(o.containsKey("prompt"))
        l.prompt = o["prompt"];
      return l;
    } catch(e) {
      return null;
    }
      
  },
   
  
};
