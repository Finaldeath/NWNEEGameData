// make the speakers faction go hostile
// and attack!

#include "ddf_util"

void main()
{
  object oPC = GetPCSpeaker();

    AdjustReputation(oPC, OBJECT_SELF, -100);

    object oNPC = GetFirstObjectInArea(GetArea(OBJECT_SELF));

    while(GetIsObjectValid(oNPC))
    {
        debug("-- checking oNPC: " + GetName(oNPC));
        if(GetFactionEqual(oNPC))
        {
            AssignCommand(oNPC, ClearAllActions());
            AssignCommand(oNPC, ActionAttack(oPC));
        }

        oNPC = GetNextObjectInArea(GetArea(OBJECT_SELF));
    }

    ActionAttack(oPC);

}
