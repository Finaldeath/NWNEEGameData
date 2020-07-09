// make the guards & lieutenant go hostile.
#include "ddf_util"
void main()
{
    object oPC = GetPCSpeaker();
    object oNPC = OBJECT_SELF;

    // Lieutenant Hostile/attack
    AdjustReputation(oPC, oNPC, -100);
    ClearAllActions();
    ActionAttack(oPC);

    // Setting Guards to hostile/attack.
    int i = 0;
    for(i = 0; i < 6; i++)
    {
        oNPC = GetObjectByTag("ddf_city_guard_0" + IntToString(i));
        if(GetIsObjectValid(oNPC))
        {
            AssignCommand(oNPC, ClearAllActions());
            AdjustReputation(oPC, oNPC, -100);
            AssignCommand(oNPC, ActionAttack(oPC));
            debug("Guard " + IntToString(i) + " attackign PC.");
        }
    }

}
