// (if Quillian is dead)
#include "ddf_util"

int StartingConditional()
{
    object oModule = GetModule();

    if(GetLocalInt(oModule, "ddf_quillian_dead") == TRUE) return TRUE;
    if(GetLocalInt(oModule, "ddf_killed_quillian") == TRUE ) return TRUE;

    return FALSE;
}
