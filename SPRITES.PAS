UNIT Sprites;

INTERFACE

USES Graph;

TYPE
 SpriteFIleRec = RECORD
                  Size   : Word;
                 END;

 SpriteFileType = FILE;

 String12 = STRING[12];
 Sprite = OBJECT
           Sprite : Pointer;
           X,Y    : Integer;
           Size   : Word;


           FUNCTION GetX:Integer;
           FUNCTION GetY:Integer;
           PROCEDURE Capture(x1,y1,x2,y2: Integer);
           PROCEDURE Show;
           PROCEDURE SetX(I : Integer);
           PROCEDURE SetY(I : Integer);
           PROCEDURE Move(ToX,ToY : Integer);
           PROCEDURE SaveSprite(Filename : String12);
           PROCEDURE LoadSprite(Filename : String12);

          END;


IMPLEMENTATION

FUNCTION Sprite.GetX;

BEGIN
 GetX:=X;
END;

FUNCTION Sprite.GetY;

BEGIN
 GetY:=Y;
END;

PROCEDURE Sprite.Capture;

BEGIN
 Size:=ImageSize(x1,y1,x2,y2);
 GetMem(Sprite,size);
 GetImage(x1,y1,x2,y2,sprite^);
END;

PROCEDURE Sprite.Show;

BEGIN
 PutImage(x,y,Sprite^,XORPut);
END;

PROCEDURE Sprite.SetX;

BEGIN
 X:=I;
END;

PROCEDURE Sprite.SetY;

BEGIN
 Y:=I;
END;

PROCEDURE Sprite.Move;

BEGIN
 PutImage(x,y,Sprite^,XORPut);
 X:=ToX;
 Y:=ToY;
 PutImage(x,y,Sprite^,XORPut);
END;

PROCEDURE Abort(Msg : STRING);

BEGIN
 CloseGraph;
 Writeln(Msg,' Aborting...');
 Halt(1);
END;

PROCEDURE Sprite.SaveSprite;

VAR
 SpriteRec  : SpriteFileRec;
 SpriteFile : SpriteFileType;


BEGIN
 {$I-}
 IF Size>MaxAvail THEN Abort('Not enough memory');
 Assign(SpriteFile,FileName);
 Rewrite(SpriteFile,1);
 IF IOResult<>0 THEN Abort('Could not open file');
 SpriteRec.Size:=Size;
 BlockWrite(SpriteFile,SpriteRec,SizeOf(SpriteRec));
 IF IOResult<>0 THEN Abort('Could not save sprite');
 BlockWrite(SpriteFile,Sprite^,Size);
 IF IOResult<>0 THEN Abort('Could not save sprite');
 Close(SpriteFile);
 IF IOResult<>0 THEN Abort('Could not close file');
 {$I+}
END;

PROCEDURE Sprite.LoadSprite;

VAR
 SpriteRec  : SpriteFileRec;
 SpriteFile : SpriteFileType;

BEGIN
 {$I-}
 Assign(SpriteFile,FIleName);
 Reset(SpriteFile,1);
 IF IOResult<>0 THEN Abort('Could not open file');
 BlockRead(SpriteFile,SpriteRec,SizeOf(SpriteRec));
 Size:=SpriteRec.Size;
 IF Size>MaxAvail THEN Abort('Not enough memory');
 GetMem(Sprite,Size);
 BlockRead(SpriteFile,Sprite^,Size);
 Close(SpriteFile);
 IF IOResult<>0 THEN Abort('Could not close file');
 {$I+}
END;



END.






