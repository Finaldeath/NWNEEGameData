//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: nsp_tm_bulette
//::////////////////////////////////////////////////////
//:: Bulette Spawn script
//:: Use SetObjectVisualTransform() to set a Z offset
//:: to simulate burrowing
//::////////////////////////////////////////////////////

const float Z_OFFSET = -2.65f;

void main()
{
    SetObjectVisualTransform(OBJECT_SELF, OBJECT_VISUAL_TRANSFORM_TRANSLATE_Z, Z_OFFSET);
    SetLocalInt(OBJECT_SELF, "bulette_isburrowed", 1);

    ExecuteScript("x2_def_spawn", OBJECT_SELF);
}
