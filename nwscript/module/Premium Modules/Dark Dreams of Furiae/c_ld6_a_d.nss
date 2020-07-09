//(if you haven't killed anyone outside of Aladara's basement, Ulan's warehouse, Rathole, and the Soul Trade Inn,
// NOR have done the Corano Villa investigation,
// AND have killed any ruffians or Teleth in Rathole)

#include "ddf_util"

int StartingConditional()
{
    if(HasKilledInPublic() == TRUE) return FALSE;

    if(GetQuestState(AREA_TEETH_OF_ORISAW) == INVESTIGATION_COMPLETE) return FALSE;

    object oModule = GetModule();
    int ruffiansKilled = GetLocalInt(oModule, "ddf_ruffians_death_counter");
    int telethDead = GetLocalInt(oModule, "ddf_teleth_dead");

    if(ruffiansKilled == 0 && telethDead == FALSE) return FALSE;
    //object oModule = GetModule();

    //if(GetLocalInt(oModule, "ddf_quillian_dead") != TRUE && GetLocalInt(oModule, "ddf_killed_quillian") != TRUE ) return FALSE;

    //if(HelpfulToLucenna(GetPCSpeaker()) == TRUE) return FALSE;

    //if(GetLocalInt(oModule, "ddf_background_flag") !=  BG_COP) return FALSE;

    return TRUE;
}
