// if the conversation is "successfully" completed
// i can do a couple different things...
// ... dang, i need to also check if we are in a combat.
// ahh, maybe regardless i can just get rid of the invisible walls...
// but i ahve to update the combat related ones to also set this value.
// I guess we only get the "normal" end of conversation event if we
// end the dialog ending "properly"
#include "ddf_util"

void main()
{
    //debug("-- exiting dialog...");

    SetLocalInt(GetModule(), HADLIEUTENANTDIALOG, TRUE);

    string sNewTag = "ddf_ld6_wall_tag";

    int iWallCounter = 0;

    object oWall = GetObjectByTag(sNewTag);

    while(GetIsObjectValid(oWall))
    {
        //debug("-- destroying wall...");

        DestroyObject(oWall);

        iWallCounter = iWallCounter + 1;
        oWall = GetObjectByTag(sNewTag, iWallCounter);
    }

}
