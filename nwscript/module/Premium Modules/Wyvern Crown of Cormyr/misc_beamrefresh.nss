// Febraury 2006
// B W-Husey
// Used for refreshing beam visuals in the Through the Portal area.

#include "x0_i0_petrify"
void main()
{
    if (GetTag(GetArea(OBJECT_SELF)) == "PortalArea")
    { //Run the script only if the caller is in the relevant area
        int i;
        for (i=0;i<4;i++)
        {
            string sI       = IntToString(i+1);
            object oShoot   = GetObjectByTag("CWPShoot" + sI);
            object oTarget  = GetObjectByTag("CWPTarget" + sI);
            object oTrig    = GetObjectByTag("CWPTrig" + sI);

            RemoveEffectOfType(oTarget, EFFECT_TYPE_BEAM);

            effect eBeam = EffectBeam(VFX_BEAM_EVIL, oShoot, BODY_NODE_CHEST);
            if (!GetLocalInt(oTrig, "nOff"))
                DelayCommand(0.1, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBeam, oTarget));
        }
    }
}
