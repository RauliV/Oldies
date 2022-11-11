PROGRAM SpriteTest;

USES Graph,crt,sprites;

VAR
 Sprite1     : Sprite;
 Driver,mode : Integer;
 Temp        : Char;


BEGIN
 Driver:=EGA;
 Mode:=EGAHi;
 InitGraph(Driver,mode,'');
 Circle(100,100,10);
 Sprite1.Capture(90,90,110,110);
 Sprite1.SetX(200);
 Sprite1.SetY(200);
 Sprite1.Show;
 REPEAT UNTIL Keypressed;
 Temp:=ReadKey;
 Sprite1.SaveSprite('TEST.SPT');
 ClearDevice;
 Sprite1.LoadSprite('TEST.SPT');
 Sprite1.SetX(200);
 Sprite1.SetY(200);
 Sprite1.Show;
 REPEAT UNTIL Keypressed;
 Temp:=ReadKey;

 CloseGraph;
END.