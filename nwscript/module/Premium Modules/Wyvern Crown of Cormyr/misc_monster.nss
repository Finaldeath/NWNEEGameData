// B W-Husey
// called from wandering monster library to spawn the monster
// (stops the random seed from generating an identical monster each time, and actually gives us a random one)

#include "cu_wandering"
void main()
{
            string sTarget = "Enc_"+GetLocalString(OBJECT_SELF,"sEncounter")+IntToString(d2());
            location lSpawn;
            lSpawn = GetLocation(GetWaypointByTag("WM"+sTarget));
            DelayCommand(4.0,GenerateMonster(lSpawn, OBJECT_SELF, GetLocalString(OBJECT_SELF,"sEncounter")));
}
