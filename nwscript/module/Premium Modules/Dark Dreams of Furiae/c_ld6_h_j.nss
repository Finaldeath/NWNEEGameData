// (if Quillian is not dead,
// AND you were helpful*** to Lucenna)

#include "ddf_util"

int StartingConditional()
{
    object oModule = GetModule();

    if(GetLocalInt(oModule, "ddf_quillian_dead") == TRUE) return FALSE;
    if(GetLocalInt(oModule, "ddf_killed_quillian") == TRUE ) return FALSE;

    if(HelpfulToLucenna(GetPCSpeaker()) == FALSE) return FALSE;

    return TRUE;
}
