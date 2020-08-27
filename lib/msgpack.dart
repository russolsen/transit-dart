part of transit;

/**
 * Wrapper for [Packer] to behave like [Converter]
 */
class MsgPackEncoder extends Converter<dynamic, List<int>>{
  
  List<int> convert(obj){
    return pack(obj);
  }
}

/**
 * Wrapper for [Unpacker] to behave like [Converter]
 */
class MsgPackDecoder extends Converter<List<int>, dynamic>{
  
  convert(List<int> list){
    Uint8List data = new Uint8List.fromList(list);
    return unpack(data);
  }
}

