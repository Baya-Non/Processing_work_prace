int textXCount;  //  横の文字数
int textYCount;  //  縦の文字数
final String STRING = "abcdefghijklmnopqrstuvwxyz0123456789ｱｲｳｴｵｶｷｸｹｺｻｼｽｾｿﾀﾁﾂﾃﾄﾅﾆﾇﾈﾉﾊﾋﾌﾍﾎﾏﾐﾑﾒﾓﾔﾕﾖﾗﾘﾙﾚﾛﾜｦﾝ";
//final String STRING = "働きたくない。";
PFont font;
 
char[][] word;      //  それぞれの文字
int[][] wordAlpha;  //  文字の透明度
int Globali = 0;
 
void setup() {
  size(1200, 700);
 
  font = createFont("MS Gothic", 48);
  textFont(font, 30);
  textAlign(CENTER);
 
  textXCount = width / 10;
  textYCount = height / 16;
 
  word = new char[textXCount][textYCount];
  wordAlpha = new int[textXCount][textYCount];
 
  coders = new Coder[textXCount];
  for(int i = 0; i < textXCount; i++){
    coders[i] = new Coder(i);
    coders[i].live = false;
  }
 
  //  初期文字の決定
  for (int i = 0; i < textYCount; i++) {
    for (int j = 0; j < textXCount; j++) {
      word[j][i] = returnWord();
      wordAlpha[j][i] = 0;
    }
  }
}
 
 
void draw() {
  background(0);
 
  for (int i = 0; i < coders.length; i++) {
 
    //  描画する文字のαを最大にする
    if (coders[i].live) {
      wordAlpha[(int)coders[i].id][(int)coders[i].y] = 255;
      coders[i].move();
    }else{
      coders[i].revival();
    }
  }
 
  //  各文字の描画
  for (int y = 0; y < textYCount; y++) {
    for (int x = 0; x < textXCount; x++) {
      fill(167, 255, 180, wordAlpha[x][y]);
      //fill(100, 0, 120, wordAlpha[x][y]);
      //  文字の描画
      pushMatrix();
      translate(x * 10, y * 18);
      //scale(-1, 1);  //  反転
      text(word[x][y], 0, 0);
      if(wordAlpha[x][y] == 255){
        fill(255, 192);
        scale(1.1, 1.1);
        text(word[x][y], 0, 0);
        fill(255, 160);
        scale(1.2, 1.2);
        text(word[x][y], 0, 0);
      }
      popMatrix();
 
      //  たまーに文字を置き換える
      if (random(1) < 0.01) {
        word[x][y] = returnWord();
      }
 
      //  だんだん透明にしていく
      wordAlpha[x][y] = max(wordAlpha[x][y] - 3, 0);
    }
  }
}
 
//  文字を一文字得る関数
char returnWord() {
  return STRING.charAt((int)random(STRING.length()));
  /*
  Globali++;
  if(Globali == 7){
    Globali = 0;
  }
  
  return STRING.charAt(Globali);
  */
}
 
//  コーダークラス
Coder[] coders;
class Coder{
  float y;      //  現在Y座標
  float speed;  //  移動スピード
  int id;       //  担当する列番号
  boolean live; //  画面内にいることを表すフラグ
 
  Coder(int id){
    this.id = id;
    init();
  }
 
  //  初期化
  void init(){
    y = 0;
    speed = random(1) * 0.2 + 0.3;  
    live = true;
  }
 
  //  移動
  void move(){
    y += speed;
 
    if((textYCount <= y)){
      live = false;
    }
  }
 
  //  復活
  void revival(){
    if(random(1) < 0.01){
      init();
    }
  }
}
