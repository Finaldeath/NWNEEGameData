//if the fatabulizer is already fixed progress the plot, otherwise
//set it as fixed (conv point reached via the hand over the part option)
void main()
{
    if(GetLocalInt(GetModule(),"evani_plot")==10)
    {
        SetLocalInt(GetModule(),"evani_plot",15);
    }
    else if (GetLocalInt(GetModule(), "evani_plot") ==20)
    {
        SetLocalInt(GetModule(), "evani_plot", 25);
    }
    else
    {
        SetLocalInt(GetModule(),"evani_plot",10);
    }
}
