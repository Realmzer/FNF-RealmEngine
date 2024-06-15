//package objects;

//import flixel.FlxState;
//import flixel.FlxObject;
//import flixel.FlxSprite;
//import flixel.FlxG;
//import flixel.FlxCollision;

//class PlatformPlayer extends FlxSprite
//{
 //   final SPEED:Float = 250;
  //  final GRAVITY:Float = 600;

   // public function new(xPos:Int = 0, yPos:Int = 0)
      //  {
         //   super(xPos, yPos);
        //    drag.x = SPEED * 4;

         //   loadGraphic(Paths.image("platformer/PlatTest", true, 32, 48));
            
        

          //  setFacingFlip(FlxObject.LEFT, false, false);
          //  setFacingFlip(FlxObject.RIGHT, true, false);

          //  acceleration.y = GRAVITY;
     //   }

//function movement()
//{
  // final left = FlxG.keys.anyPressed([LEFT, A]);
  // final right = FlxG.keys.anyPressed([RIGHT, D]);
  // final jump = FlxG.keys.anyPressed([UP, SPACE, W]);

  // if (jump && isTouching(FlxObject.FLOOR)) {
   // velocity.y = -GRAVITY / 1.5;
  // }

   //if (left && right) {
  //  velocity.x = 0;
 //  } else if (left) {
   // velocity.x = -SPEED;
   // facing = FlxObject.LEFT;
   //} else if (right) {
   //velocity.x = SPEED;
   // facing = FlxObject.RIGHT;
//}
//}

//override function update(elapsed:Float )
 //   {
  //      super.update(elapsed);
    //    movement();
    //}
//}