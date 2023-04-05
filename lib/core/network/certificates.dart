import 'package:ceylife_digital/flavors/flavor_config.dart';

class SSLCert{
  static List<String> certificateList = List();

  static List<String> getCertificates(){
    if(FlavorConfig.isLive()){
      certificateList.add("08d2eb67f2a2653822e788d6330ddcab1af559a767accc5d3f18fbc2ecf51e34");
      certificateList.add("e6fa484a858940d101978555454aa466531ab6c4abc4ad2b000626aaac0d04f9");
    }else{
      certificateList.add("21c257f3610cd40be35826e16908f2fe1d878a6087637f112cbe878b964b084b");
      certificateList.add("e6fa484a858940d101978555454aa466531ab6c4abc4ad2b000626aaac0d04f9");
    }

    return certificateList;
  }
}