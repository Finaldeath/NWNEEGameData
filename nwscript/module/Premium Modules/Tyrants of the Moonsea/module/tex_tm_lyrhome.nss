//Set Lyressa's home to the Sword's Meet if she's been hired

#include "hf_in_henchman"

void main()
{
    object oLyressa = GetNearestObjectByTag("Lyressa");
    object oPC = GetExitingObject();

    if(GetIsPC(oPC) && HenchmanIsMine(oLyressa, oPC))
    {
        HenchmanSetHome(oLyressa, GetLocation(GetWaypointByTag("WP_C1_HENCH_HOME_LYRESSA")));
        DestroyObject(OBJECT_SELF, 5.0);
    }
}
