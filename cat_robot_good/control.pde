// 操作説明の表示
  pushMatrix();
  ortho();
  resetMatrix();
  translate(-width/2.0, -height/2.0);
  hint(DISABLE_DEPTH_TEST);
  text("[UP],[DOWN] : Tilt up/down", 10, 20);
  text("[LEFT],[RIGHT] : Pan left/right", 10, 35);
  text("[w],[s] : Move forward/backward", 10, 50);
  text("[a],[d] : Move left/right", 10, 65 );
  text("[e],[c] : Move up/down", 10, 80 );
  hint(ENABLE_DEPTH_TEST);
  popMatrix();
}


// ここからカメラ操作用のクラス
public class CameraControl {
  final float MOVE_SPEED = 8; // 移動スピード
  final float ROTATION_SPEED = 0.02; // 首振りのスピード
  
  PApplet parent;

  CameraControl(PApplet parent) {
    this.parent = parent;
    try {
      parent.registerMethod("dispose", this);
      parent.registerMethod("pre", this);
    } 
    catch (Exception e) {
    }
  }

  public void dispose() {
    parent.unregisterMethod("dispose", this);
    parent.unregisterMethod("pre", this);
  }

  public void pre() {
    // もしキーイベントの自動実行がお気に召さない場合は、ここをコメントアウトしてkeyControl()メソッドを直接メインプログラムから呼んでください。
    keyControl();
  }

  public void keyControl() {
    if ( !parent.keyPressed ) return;

    // ビュー行列（camera）を入力に応じて修正するための行列
    PMatrix3D M = new PMatrix3D();

    if ( parent.key == 'w' ) {
      M.translate( 0, 0, MOVE_SPEED );
    } else if ( parent.key == 's' ) {
      M.translate( 0, 0, -MOVE_SPEED );
    } else if ( parent.key == 'a' ) {
      M.translate( MOVE_SPEED, 0, 0 );
    } else if ( parent.key == 'd' ) { 
      M.translate( -MOVE_SPEED, 0, 0 );
    } else if ( parent.key == 'e' ) { 
      M.translate( 0, MOVE_SPEED, 0 );
    } else if ( parent.key == 'c' ) { 
      M.translate( 0, -MOVE_SPEED, 0 );
    } else if ( parent.key == PConstants.CODED ) {
      if ( parent.keyCode == PConstants.UP ) {     
        M.rotateX(ROTATION_SPEED);
      } else if ( parent.keyCode == PConstants.DOWN ) {  
        M.rotateX(-ROTATION_SPEED);
      } else if ( parent.keyCode == PConstants.RIGHT ) { 
        M.rotateY(ROTATION_SPEED);
      } else if ( parent.keyCode == PConstants.LEFT ) {  
        M.rotateY(-ROTATION_SPEED);
      }
    }

    // ビュー行列の修正
    PMatrix3D C = ((PGraphicsOpenGL)(this.parent.g)).camera.get(); // コピー
    C.preApply(M);

    // 上を向くように修正
    C.invert();
    float ex = C.m03;
    float ey = C.m13;
    float ez = C.m23;
    float cx = -C.m02 + ex;
    float cy = -C.m12 + ey;
    float cz = -C.m22 + ez;
    parent.camera( ex, ey, ez, cx, cy, cz, 0, 1, 0 );
  }
}
