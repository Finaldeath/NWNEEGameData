//does the player have the recovered communique in their pack?
#include "nw_i0_tool"
int StartingConditional()
{
    //object oCoded1=GetObjectByTag();
    //object oCoded2=GetObjectByTag();
    if((!HasItem(GetPCSpeaker(),"db_itnote2")==0))
    return TRUE;
    return FALSE;
}
