//User-defined script to handle the illusion in Elmwood Subterranean Lair

void main()
{
    int i = 0;

    string sPixie;

    object oFlower;
    object oObject;
    object oPixie;

    location lFlower;
    location lPixie;
    location lSelf = GetLocation(OBJECT_SELF);

    vector vSelf = GetPosition(OBJECT_SELF);

    effect eEffect;
    effect eEntangle = EffectAreaOfEffect(AOE_PER_ENTANGLE);
    effect eChunk = EffectVisualEffect(VFX_COM_CHUNK_GREEN_MEDIUM);
    effect eSummon = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1);
    effect eSwamp = EffectVisualEffect(VFX_FNF_HORRID_WILTING);

    switch(GetUserDefinedEventNumber())
    {
        //Dispel the illusion
        case 4500 :
            if(GetLocalInt(OBJECT_SELF, "nIllusionDispelled") == 0)
            {
                SetLocalInt(OBJECT_SELF, "nIllusionDispelled", 1);
                AssignCommand(GetFirstPC(),
                    SpeakString("The illusion dissipates and the grim reality is revealed!"));

                //Remove the illusory placeables and create the plant's entangle
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eSummon, OBJECT_SELF);
                ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, eEntangle, lSelf);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eSwamp, OBJECT_SELF);
                DestroyObject(GetNearestObjectByTag("ElmwoodIllusion1"));
                DestroyObject(GetNearestObjectByTag("ElmwoodIllusion2"));

                //Create the Tri-Flower Frond placeable and transform its position
                //so that it appears in the same position as the creature
                vSelf.z +=5.0;
                lFlower = Location(GetArea(OBJECT_SELF), vSelf, 0.0);
                oFlower = CreateObject(OBJECT_TYPE_PLACEABLE, "tm_plc_triflower", lFlower);
                SetObjectVisualTransform(oFlower, OBJECT_VISUAL_TRANSFORM_TRANSLATE_Z, -5.0);
                SetObjectVisualTransform(oFlower, OBJECT_VISUAL_TRANSFORM_SCALE, 2.0);

                //Create the Tri-Flower Frond creature
                CreateObject(OBJECT_TYPE_CREATURE, "triflowerfrond", GetLocation(GetWaypointByTag("WP_SPAWN_TriFlower")));
                //Remove the pixies and create will-o-wisps
                for(i = 1; i < 8; i++)
                {
                    sPixie = "ElmwoodPixie" + IntToString(i);
                    oPixie = GetNearestObjectByTag(sPixie);
                    lPixie = GetLocation(oPixie);

                    if(d3() == 1)
                    {
                        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSummon, lPixie);
                    }

                    DestroyObject(oPixie);
                    CreateObject(OBJECT_TYPE_CREATURE, "tm_cre_willowisp", lPixie);
                }
            }
        break;

        //Tri-Flower Frond is killed
        case 4501 :
            //Destroy the Tri-Flower Frond
            oFlower = GetNearestObjectByTag("tm_plc_triflower");
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eChunk, lSelf);
            DelayCommand(1.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eChunk, lSelf));
            DestroyObject(oFlower, 2.0);

            //Remove the Entangle AOE
            oObject = GetFirstObjectInShape(SHAPE_SPHERE, 20.0, lSelf, FALSE, OBJECT_TYPE_AREA_OF_EFFECT);
            while(oObject != OBJECT_INVALID)
            {
                if(GetAreaOfEffectCreator(oObject) == OBJECT_SELF)
                {
                    DestroyObject(oObject);
                }
                oObject = GetNextObjectInShape(SHAPE_SPHERE, 20.0, lSelf, FALSE, OBJECT_TYPE_AREA_OF_EFFECT);
            }
        break;
    }
}
