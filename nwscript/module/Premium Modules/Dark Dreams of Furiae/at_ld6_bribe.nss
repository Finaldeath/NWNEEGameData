// make the lieutenant and guards fade-away....

#include "ddf_util"

void main()
{
    float fDelay = 2.0f;

    DestroyObject(OBJECT_SELF, fDelay);

    object oNPC;
    int i = 0;
    for(i = 0; i < 6; i++)
    {
        oNPC = GetObjectByTag("ddf_city_guard_0" + IntToString(i));
        if(GetIsObjectValid(oNPC))
        {
            DestroyObject(oNPC, fDelay);
        }
    }

    i = 0;
    object blocker = GetObjectByTag("ddf_ld6_wall_tag", i);
    while(GetIsObjectValid(blocker))
    {
        DestroyObject(blocker, fDelay);

        i++;
        blocker = GetObjectByTag("ddf_ld6_wall_tag", i);
    }
}
