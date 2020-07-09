//Mutchs Cutstom Spawn Script
void main()
{
    DelayCommand(1.0f, ActionUseSkill(SKILL_HIDE, OBJECT_SELF));

    ExecuteScript("nw_c2_default9", OBJECT_SELF);
}
