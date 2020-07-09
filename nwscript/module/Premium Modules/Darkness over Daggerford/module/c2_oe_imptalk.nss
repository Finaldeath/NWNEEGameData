////////////////////////////
//c2_oe_imptalk
//Author: Phil Mitchell (Baron of Gateford)
//Placed on the trigger near the imp chest in the bear cave.
//used to make the chest appear to be talking
/////////////////////////////

void main()
{
    object oPC = GetEnteringObject();
    object oChest;

    if (GetIsPC(oPC))
    {
       oChest = GetNearestObjectByTag("pm_impchest",oPC);
       if (GetIsObjectValid(oChest))
       {
            AssignCommand(oChest,ActionSpeakString("Help, Help, Let me out!"));
            DelayCommand(3.0,AssignCommand(oChest,ActionSpeakString("Please let me out!")));
       }
    }
}
