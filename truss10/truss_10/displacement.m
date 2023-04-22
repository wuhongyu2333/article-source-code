function y = displacement(x)

    load bp_displacment
    test_feature_deal=mapminmax('apply',x',train_feature_format);
    t_sim = sim(net,test_feature_deal);
    y = mapminmax('reverse',t_sim,train_label_format);              
end
