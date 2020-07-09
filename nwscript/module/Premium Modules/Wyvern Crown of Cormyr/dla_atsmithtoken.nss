// B W-Husey
// October 2005
// Sets the custom token 1012 (shards you have)
#include "nw_i0_tool"
void main()
{
    object oPC = GetPCSpeaker();
    string sItems = "";
    if(HasItem(GetPCSpeaker(), "Shard1")) sItems = sItems + "the shards of a broken blade, ";
    if(HasItem(GetPCSpeaker(), "Shard3")) sItems = sItems + "a shattered sword, ";
    if(HasItem(GetPCSpeaker(), "Shard2")) sItems = sItems + "a spearhead, ";
    if(HasItem(GetPCSpeaker(), "Shard4")) sItems = sItems + "a poleaxe head, ";

    SetCustomToken(1012,"a few bits and pieces I can't use, "+sItems+"and that's all.");

}
