// onEnter for rothe dung trigger (yuck!)

#include "x3_inc_horse"

string GetRandomSaying(object oPC)
{
    string s;
    int n = d8();
    if      (n == 1) s = "... You just stepped in something brown and smelly! ...";
    else if (n == 2) s = "... Yuck! Rothe dung! Worse than cow dung! ...";
    else if (n == 3) s = "... Apparently these rothe are not toilet trained ...";
    else if (n == 4) s = "... You're going to have to clean those boots ...";
    else if (n == 5) s = "... Never walk through a rothe pasture barefoot ...";
    else if (n == 6) s = "... Just think of it as aromatic brown fertilizer ...";
    else if (n == 7) s = "... Something just went squish under your foot ...";
    else if (n == 8) s = "... Rothe dung! Oh, the hazardous life of an adventurer! ...";
    return(s);
}

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        if (!HorseGetIsMounted(oPC))
        {
            string sText = GetRandomSaying(oPC);
            AssignCommand(oPC, ClearAllActions());
            AssignCommand(oPC, PlaySound("fs_beetle_wlk1"));
            AssignCommand(oPC, SpeakString(sText));
            AssignCommand(oPC, PlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 4.0));
            DestroyObject(OBJECT_SELF);
        }
    }
}
