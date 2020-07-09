void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

if (GetLocalInt(oPC, "amberlynrescued")!= 1)
   return;

if (GetLocalInt(OBJECT_SELF, "fired") == 1)
    return;

FadeFromBlack(oPC, FADE_SPEED_MEDIUM);

SetLocalInt(OBJECT_SELF, "fired", 1);
}

