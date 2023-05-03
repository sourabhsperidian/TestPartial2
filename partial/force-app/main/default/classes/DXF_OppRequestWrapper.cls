global class DXF_OppRequestWrapper {

     global List<oppwrapper> opportunity;
    
global class oppwrapper{
    global String Opp_Id;	
    global String Oppt_name;
    global String Type;
    global String StageName;
    global Boolean Offer_amount;
    global List<unitpreferences> unitprefs;
    global List<offers> offers;
    global List<transactions> transactions;
}
    
global class unitpreferences{
    global String UnitPrefNum;
    global String UnitName;
    global String Unit_type;
    global String Unit_number;//123
}
    global class offers{
    global String OfferNum;	//123
	global String UnitName;
    global Date Offer_date;
	global Decimal Offer_price;
    global String Offer_status;
}
    global class transactions{
    global String Name;	//123
}
}