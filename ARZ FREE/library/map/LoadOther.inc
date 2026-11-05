  //цр
    gAreas[arCentralRinok][0] = CreateDynamicSphere(1124.3383,-1472.4784,16.1252,100.0);
   
    for(new i; i < sizeof(CentralMarketPosition); i++)
    {
        gAreas[arLavka][i] = CreateDynamicSphere(CentralMarketPosition[i][0], CentralMarketPosition[i][1], CentralMarketPosition[i][2], 3, -1, -1);
        CentralMarket[i][crOwnedId] = INVALID_PLAYER_ID,  CentralMarket[i][crObject] = CreateDynamicObject(14211, CentralMarketPosition[i][0], CentralMarketPosition[i][1], CentralMarketPosition[i][2], 0.000000, 0.000000, CentralMarketPosition[i][3]);
        SetObjectMaterialText(CentralMarket[i][crObject], (str_f("Номер %i. {30A332}Свободная!", i + 1)), 1, 120, "Comic Sans MS", 40, 0, 0xffffffff, 4278190080, 1);
    }
    ///counts
    gPremiumContDor[0] = CreateDynamicObject(19426, -1733.967407, 156.626068, 5.192699, -0.000052, 540.000000, -89.999847, -1, -1);
    SetDynamicObjectMaterial(gPremiumContDor[0], 0, 3564, "dockcargo2_las", "lastrk5", 0);
    gPremiumContDor[1] = CreateDynamicObject(19426, -1732.376587, 156.626068, 5.192699, 0.000059, 0.000000, 89.999817, -1, -1);
    SetDynamicObjectMaterial(gPremiumContDor[1], 0, 3564, "dockcargo2_las", "lastrk5", 0);
    //2kont
    gPremiumContDor[2] = CreateDynamicObject(19426, -1723.385864, 186.246567, 5.178199, -0.000052, 540.000000, -89.999847, 0, 0, -1, 300.00, 300.00);
    gPremiumContDor[3] = CreateDynamicObject(19426, -1721.795044, 186.246567, 5.178199, 0.000059, 0.000000, 89.999817, 0, 0, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(gPremiumContDor[2], 0, 3564, "dockcargo2_las", "lastrk5", 0);
    SetDynamicObjectMaterial(gPremiumContDor[3], 0, 3564, "dockcargo2_las", "lastrk5", 0);
    //3kont
    gPremiumContDor[4] = CreateDynamicObject(19426, -1733.945435, 188.811066, 5.192699, -0.000052, 540.000000, -89.999847, 0, 0, -1, 300.00, 300.00);
    gPremiumContDor[5] = CreateDynamicObject(19426, -1732.354614, 188.811066, 5.192699, 0.000059, 0.000000, 89.999817, 0, 0, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(gPremiumContDor[4], 0, 3564, "dockcargo2_las", "lastrk5", 0);
    SetDynamicObjectMaterial(gPremiumContDor[5], 0, 3564, "dockcargo2_las", "lastrk5", 0);
    //4Kont
    gPremiumContDor[6] = CreateDynamicObject(19426, -1740.197998, 191.400772, 5.178199, -0.000052, 540.000000, -89.999847, 0, 0, -1, 300.00, 300.00);
    gPremiumContDor[7] = CreateDynamicObject(19426, -1738.607178, 191.400772, 5.178199, 0.000059, 0.000000, 89.999817, 0, 0, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(gPremiumContDor[6], 0, 3564, "dockcargo2_las", "lastrk5", 0);
    SetDynamicObjectMaterial(gPremiumContDor[7], 0, 3564, "dockcargo2_las", "lastrk5", 0);
    //5Kont
    gPremiumContDor[8] = CreateDynamicObject(19426, -1723.345703, 153.606674, 5.178199, -0.000052, 540.000000, -89.999847, 0, 0, -1, 300.00, 300.00);
    gPremiumContDor[9] = CreateDynamicObject(19426, -1721.754883, 153.606674, 5.178199, 0.000059, 0.000000, 89.999817, 0, 0, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(gPremiumContDor[8], 0, 3564, "dockcargo2_las", "lastrk5", 0);
    SetDynamicObjectMaterial(gPremiumContDor[9], 0, 3564, "dockcargo2_las", "lastrk5", 0);
    /////
    //6kont
    gPremiumContDor[10] = CreateDynamicObject(19426, -1723.379028, 123.278084, 5.178199, -0.000052, 540.000000, -89.999847, -1, -1);
    SetDynamicObjectMaterial(gPremiumContDor[10], 0, 3564, "dockcargo2_las", "lastrk5", 0);
    gPremiumContDor[11] = CreateDynamicObject(19426, -1721.788208, 123.278084, 5.178199, 0.000059, 0.000000, 89.999817, -1, -1);
    SetDynamicObjectMaterial(gPremiumContDor[11], 0, 3564, "dockcargo2_las", "lastrk5", 0);
    //7kont
    gPremiumContDor[12] = CreateDynamicObject(19426, -1729.997070, 137.012177, 5.192699, -0.000052, 540.000000, -89.999847, -1, -1);
    SetDynamicObjectMaterial(gPremiumContDor[12], 0, 3564, "dockcargo2_las", "lastrk5", 0);
    gPremiumContDor[13] = CreateDynamicObject(19426, -1728.406250, 137.012177, 5.192699, 0.000059, 0.000000, 89.999817, -1, -1);
    SetDynamicObjectMaterial(gPremiumContDor[13], 0, 3564, "dockcargo2_las", "lastrk5", 0);
    //8kont
    gPremiumContDor[14] = CreateDynamicObject(19426, -1740.278564, 138.887177, 5.178199, -0.000052, 540.000000, -89.999847, 0, 0, -1, 300.00, 300.00);
    gPremiumContDor[15] = CreateDynamicObject(19426, -1738.687744, 138.887177, 5.178199, 0.000059, 0.000000, 89.999817, 0, 0, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(gPremiumContDor[14], 0, 3564, "dockcargo2_las", "lastrk5", 0);
    SetDynamicObjectMaterial(gPremiumContDor[15], 0, 3564, "dockcargo2_las", "lastrk5", 0);
    //9kont
    gPremiumContDor[16] = CreateDynamicObject(19426, -1733.967896, 120.745483, 5.192699, -0.000052, 540.000000, -89.999847, -1, -1);
    SetDynamicObjectMaterial(gPremiumContDor[16], 0, 3564, "dockcargo2_las", "lastrk5", 0);
    gPremiumContDor[17] = CreateDynamicObject(19426, -1732.377075, 120.745483, 5.192699, 0.000059, 0.000000, 89.999817, -1, -1);
    SetDynamicObjectMaterial(gPremiumContDor[17], 0, 3564, "dockcargo2_las", "lastrk5", 0);
