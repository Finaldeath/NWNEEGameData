const int ANIMATION_LANCERACK_REM_1   = ANIMATION_PLACEABLE_DEACTIVATE;
const int ANIMATION_LANCERACK_REM_2   = ANIMATION_PLACEABLE_CLOSE;
const int ANIMATION_LANCERACK_REM_3   = ANIMATION_PLACEABLE_OPEN;
const int ANIMATION_LANCERACK_REM_4   = ANIMATION_PLACEABLE_ACTIVATE;
const int ANIMATION_LANCERACK_FULL    = ANIMATION_LOOPING_CUSTOM1;

//#include "x0_i0_position"

void main()
{
//   SpeakLocation(GetLocation(OBJECT_SELF));
   int iEf = GetLocalInt(OBJECT_SELF, "t");
   switch (iEf)
   {
      case 0: ActionPlayAnimation(ANIMATION_LANCERACK_REM_1); break;
      case 1: ActionPlayAnimation(ANIMATION_LANCERACK_REM_2); break;
      case 2: ActionPlayAnimation(ANIMATION_LANCERACK_REM_3); break;
      case 3: ActionPlayAnimation(ANIMATION_LANCERACK_REM_4); break;
      case 4: ActionPlayAnimation(ANIMATION_LANCERACK_FULL); break;
      case 5: SetLocalInt(OBJECT_SELF, "t", 0); iEf = -1;break;
   }
   SetLocalInt(OBJECT_SELF, "t", ++iEf);

//   effect eListEnd2 = EffectVisualEffect(348);
//   ApplyEffectToObject(DURATION_TYPE_PERMANENT,eListEnd2,OBJECT_SELF);

}
