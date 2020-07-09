// (if Quillian is not dead,
// NOR were you helpful*** to Lucenna
// AND you are not law enforcement)

#include "ddf_util"

int StartingConditional()
{
    object oModule = GetModule();

    if(GetLocalInt(oModule, "ddf_quillian_dead") == TRUE) return FALSE;
    if(GetLocalInt(oModule, "ddf_killed_quillian") == TRUE ) return FALSE;

    if(HelpfulToLucenna(GetPCSpeaker()) == TRUE) return FALSE;

    if(GetLocalInt(oModule, "ddf_background_flag") ==  BG_COP) return FALSE;

    return TRUE;
}
