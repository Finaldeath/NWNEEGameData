#include "ddf_util"

void main()
{
    // SUPERSEDED by the TRIGGER in VOID SPACE
    // see `t_oe_equip_setup`.

    /*
    object oPC = GetEnteringObject();
    if(GetIsPC(oPC) == FALSE) return;
     //SetLocalInt(GetModule(), "ddf_in_area", AREA_ALADARAS_APARTMENT);
     debug("we do not set ddf_in_area when in the VOID SPACE.");
     debug("Should also level you up or down to LV 5 on entry...");

    oPC = GetFirstPC();
    object oPartyMember = GetFirstFactionMember(oPC, TRUE);
    while(GetIsObjectValid(oPartyMember) && GetIsPC(oPartyMember))
    {
        int currentXP = GetXP(oPartyMember);
        if(currentXP < 10000)
        {
            SetXP(oPartyMember, 10000);
        }
        else if(currentXP >= 15000)
        {
            SetXP(oPartyMember, 14999);
        }
        oPartyMember = GetNextFactionMember(oPC, TRUE);
    }
    */

}
