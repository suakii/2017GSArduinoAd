XML res;
String sunrise, sunset;
//영통동
String source="http://openapi.airkorea.or.kr/openapi/services/rest/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty?stationName=%EC%98%81%ED%86%B5%EB%8F%99&dataTerm=month&pageNo=1&numOfRows=10&ServiceKey=";
String apiKey="8n%2Bl3gJJn6o2pN%2BwlFHj6i9anqdFAjpD97TWoC%2FeV4zynQPsgQ3TCxhgua6DYylpMGG%2Fn1%2BH7rX%2Fya6uDkcItA%3D%3D";
void setup() {
  res = loadXML(source+apiKey);
  //println(res);
  //println(res.getName());
  //println(res.listChildren());
  
  XML[] children = res.getChildren("body");
  XML res2 = children[0];
  
  XML[] answer = res.getChildren("body")[0].getChildren("items")[0].getChildren("item");
  println(answer);
  
  XML want = answer[0].getChild("dataTime");
  println(want);
  
  XML pm10Value = answer[0].getChild("pm10Value");
  println(pm10Value);
  println(pm10Value.getContent());
  
  
}

void draw() {

}