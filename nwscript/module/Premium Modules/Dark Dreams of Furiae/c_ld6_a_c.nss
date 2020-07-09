// (if you haven't killed anyone outside of Aladara's basement, Ulan's warehouse, Rathole, and the Soul Trade Inn
// AND have done the Corano Villa investigation)

#include "ddf_util"

int StartingConditional()
{
    if(HasKilledInPublic() == TRUE) return FALSE;

    if(GetQuestState(AREA_TEETH_OF_ORISAW) != INVESTIGATION_COMPLETE) return FALSE;

    //object oModule = GetModule();

    //if(GetLocalInt(oModule, "ddf_quillian_dead") != TRUE && GetLocalInt(oModule, "ddf_killed_quillian") != TRUE ) return FALSE;

    //if(HelpfulToLucenna(GetPCSpeaker()) == TRUE) return FALSE;

    //if(GetLocalInt(oModule, "ddf_background_flag") !=  BG_COP) return FALSE;

    return TRUE;
}
